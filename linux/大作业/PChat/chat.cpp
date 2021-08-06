#include "chat.h"
#include "ui_chat.h"

Chat::~Chat()
{
    is_opend = false;
    delete ui;
}

Chat::Chat(QString passusername, QString passuserip,QString selfusername,QString selfip):
    opusername(passusername),
    opuserip(passuserip),
    logusername(selfusername),
    localIPaddress(selfip),
    is_opend(false),
    server(nullptr),
    xchat(nullptr),
    used(false),
    xport(8718),
    ui(new Ui::Chat)
{
    ui->setupUi(this);
    ui->messageTextEdit->setFocusPolicy(Qt::StrongFocus);
    ui->textBrowser->setFocusPolicy(Qt::NoFocus);
    ui->messageTextEdit->setFocus();
    ui->messageTextEdit->installEventFilter(this);
    ui->label->setText(tr("与%1私聊中，对方的IP为：%2").arg(opusername).arg(opuserip));
    QFile qssfile(":/qdarkgraystyle/style.qss");
    qssfile.open(QFile::ReadOnly);
    QTextStream filetext(&qssfile);
    QString stylesheet = filetext.readAll();
    this->setStyleSheet(stylesheet);
    qssfile.close();

    setAttribute(Qt::WA_DeleteOnClose);

    xchat = new QUdpSocket(this);
    xchat->bind(QHostAddress(localIPaddress),xport);
    server = new TcpServer(this);

    connect(xchat,SIGNAL(readyRead()),this,SLOT(processPendinDatagrams()));
    connect(server, SIGNAL(sendFileName(QString)),this,SLOT(getSendFileName(QString)));
}

void Chat::sendMessage(messageType type, QString serverAddress)
{
    QByteArray data;
    QDataStream out(&data,QIODevice::WriteOnly);
    QString localHostName = QHostInfo::localHostName();
    QString address = localIPaddress;
    out <<type << logusername << localHostName;
    switch (type) {
        case Message:
        {
            used = false;
            if(ui->messageTextEdit->toPlainText() =="")
            {
                QMessageBox::warning(0,tr("警告"),tr("发送内容不能为空"),QMessageBox::Ok);
                return ;
            }
            else
            {
                ui->label->setText(tr("与%1私聊中 对方的IP：%2").arg(opusername).arg(opuserip));
                message = getMessage();
                out << address << message;
                ui->textBrowser->verticalScrollBar()->setValue(ui->textBrowser->verticalScrollBar()->maximum());
            }
            break;
        }
        case SendFileName:
        {
            QString clientAddresss = opuserip;
            out << address << clientAddresss << fileName;
            break;
        }
        case RefuseFile:
        {
            out << serverAddress ;
            break;
        }
    }
    xchat->writeDatagram(data,data.length(),QHostAddress(opuserip),xport);
}

void Chat::processPendinDatagrams()
{
    while (xchat->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(xchat->pendingDatagramSize());
        xchat->readDatagram(datagram.data(),datagram.size());

        QDataStream in(&datagram,QIODevice::ReadOnly);
        int messageTyep;
        in >> messageTyep;
        QString userName,localHostName,ipAddress,messagestr;

        QString time = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
        switch (messageTyep) {
            case Message:
            {
                ui->label->setText(tr("与%1私聊中 对方的IP：%2").arg(opusername).arg(opuserip));
                in >> userName >> localHostName >>ipAddress >>messagestr;
                ui->textBrowser->setTextColor(Qt::green);
                ui->textBrowser->setCurrentFont(QFont("黑体",8));
                ui->textBrowser->append("[ " +userName+ " ]" + time);

                ui->textBrowser->append(messagestr);
                this->show();
                setWindowTitle("私聊");
                is_opend = true;
            }
            case SendFileName:
            {
                QString clientAddress,fileName;
                in >> userName >> localHostName >> ipAddress >> clientAddress >> fileName ;
                hasPendinFile(userName,ipAddress,clientAddress,fileName);
                this->show();
                setWindowTitle("私聊");
                is_opend = true;
                break;
            }
            case RefuseFile:
            {
                in >>userName >> localHostName;
                QString serverAddress;
                in >> serverAddress;
                if(localIPaddress == serverAddress)
                {
                    server->refused();
                }
                break;
            }
            case LeftParticipant:
            {
                in >> userName >> localHostName;
                userLeft(userName,localHostName,time);
                ui->~Chat();
                break;
            }
        }
    }
}

QString Chat::getMessage()
{
    QString msg = ui->messageTextEdit->toHtml();
    ui->messageTextEdit->clear();
    ui->messageTextEdit->setFocus();
    return msg;
}

void Chat::getSendFileName(QString name)
{
    fileName = name;
    sendMessage(SendFileName);
}

void Chat::userLeft(QString userName, QString localHostName, QString time)
{
    ui->textBrowser->setTextColor(Qt::gray);
    ui->textBrowser->setCurrentFont(QFont("黑体",10));
    if(!used)
    {
         ui->textBrowser->append(tr("%1于%2离开!").arg(userName).arg(time));
         used = true;
    }
    ui->label->setText(tr("用户%1离开会话界面!").arg(userName));
}

void Chat::hasPendinFile(QString userName, QString serverAddress, QString clientAddress, QString fileName)
{
    QString  ipAddress = localIPaddress;
    if(clientAddress  == ipAddress)
    {
        int btn = QMessageBox::information(this,tr("接收文件"),
                                           tr("来自 %1 (%2)的文件:%3","是否接受")
                                           .arg(userName)
                                           .arg(serverAddress).arg(fileName),
                                           QMessageBox::Yes,QMessageBox::No);
        if(btn == QMessageBox::Yes)
        {
            QString name = QFileDialog::getSaveFileName(0,tr("保存文件"),fileName);
            if(!name.isEmpty())
            {
                TcpClient *client = new TcpClient(this);
                client->setFileName(name);
                client->setHostAddress(QHostAddress(serverAddress));
                client->show();
            }
        }
        else if(btn == QMessageBox::No)
        {
            sendMessage(RefuseFile,serverAddress);
        }
    }
}

void Chat::on_readToolButton_clicked()
{
    QString fileName = "RECORD_" + opusername + "_" + opuserip;
    QFile file(fileName);
    if(!file.open(QFile::ReadOnly | QFile::Text))
    {
        QMessageBox::warning(this,tr("读取记录"),tr("无该记录 %1:\n").arg(fileName).arg(file.errorString()));
        return;
    }
    QString histext="";
    QTextStream stream(&file);
    while(stream.atEnd()==0)
    {
       QString tmp = stream.readLine();
       histext += tmp + "\n";
    }
    his.init("group",histext);
    his.setWindowTitle("私聊记录");
    his.show();
}

void Chat::on_sendToolButton_clicked()
{
    server->show();
    server->initServer();
}

void Chat::saveFile(QString fileName)
{
    QFile file(fileName);
    if(!file.open(QFile::WriteOnly | QFile::Text | QIODevice::Append))
    {
        QMessageBox::warning(this,tr("保存文件"),tr("无法保存文件 %1:\n %2").arg(fileName).arg(file.errorString()));
        return ;
    }
    QTextStream out(&file);
    out << ui->textBrowser->toPlainText() + "\n";
}

void Chat::on_closePushButton_clicked()
{
    sendMessage(LeftParticipant);
    QString fileName = "RECORD_" + opusername + "_" + opuserip;
    if(!fileName.isEmpty())
        saveFile(fileName);
    ui->textBrowser->clear();
    ui->messageTextEdit->clear();
    close();
    ui->~Chat();
    emit exitChat();
}

void Chat::on_sendPushButton_clicked()
{
    sendMessage(Message);
    QString time = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
    ui->textBrowser->setTextColor(Qt::green);
    ui->textBrowser->setCurrentFont(QFont("黑体",8));
    ui->textBrowser->append("[ " +logusername+" ]" +time);
    ui->textBrowser->append(message);
}

void Chat::closeEvent(QCloseEvent *)
{
    on_closePushButton_clicked();
}

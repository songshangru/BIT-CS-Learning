#include "mainwindow.h"
#include "ui_mainwindow.h"


MainWindow::MainWindow(QWidget *parent):
    QWidget(parent),
    udpSocket(nullptr),
    server(nullptr),
    privateChatTo(nullptr),
    privateChatFrom(nullptr),
    port(8717),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->messageTextEdit->setFocusPolicy(Qt::StrongFocus);
    ui->messageBrower->setFocusPolicy(Qt::NoFocus);
    ui->messageTextEdit->setFocus();
    ui->messageTextEdit->installEventFilter(this);
    ui->userTableWidget->setColumnHidden(1, true);
    ui->userTableWidget->setColumnHidden(2, true);
    QFile qssfile(":/qdarkgraystyle/style.qss");
    qssfile.open(QFile::ReadOnly);
    QTextStream filetext(&qssfile);
    QString stylesheet = filetext.readAll();
    this->setStyleSheet(stylesheet);
    qssfile.close();

    udpSocket = new QUdpSocket(this);
    server = new TcpServer(this);
    udpSocket->bind(port,QUdpSocket::ShareAddress|QUdpSocket::ReuseAddressHint);
    connect(udpSocket,SIGNAL(readyRead()),this,SLOT(processPendingDatagrams()));
    connect(server,SIGNAL(sendFileName(QString)),this,SLOT(getSendFileName(QString)));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::setUserName(QString name)
{
    logusername = name;
    this->show();
    localIPaddress = getIP();
    sendMessage(NewParticipant);
}

void MainWindow::sendMessage(messageType type, QString serverAddress)
{
    QByteArray data;
    QDataStream out(&data,QIODevice::WriteOnly);

    QString localHostName = QHostInfo::localHostName();

    out << type << logusername << localHostName;
    switch (type) {
        case Message:
        {
            if(ui->messageTextEdit->toPlainText() == "")
            {
                QMessageBox::warning(0,tr("警告"),tr("发送内容不能为空"),QMessageBox::Ok);
                return ;
            }
            out << localIPaddress << getMessage();
            ui->messageBrower->verticalScrollBar()->setValue(ui->messageBrower->verticalScrollBar()->maximum());
            break;
        }
        case NewParticipant:
        {
            out << localIPaddress ;
            break;
        }
        case RefuseFile:
        {
            out << serverAddress;
            break;
        }
        case SendFileName:
        {
            int row = ui->userTableWidget->currentRow();
            QString clientAddress = ui->userTableWidget->item(row,2)->text();
            out << localIPaddress << clientAddress << fileName;
            break;
        }
    }
    udpSocket->writeDatagram(data,data.length(),QHostAddress::Broadcast,port);
}


void MainWindow::processPendingDatagrams()
{
    while(udpSocket->hasPendingDatagrams())
    {
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
        udpSocket->readDatagram(datagram.data(),datagram.size());

        QDataStream in(&datagram,QIODevice::ReadOnly);
        int messageType;
        in >> messageType;
        QString userName,HostName,ipAddress,message;

        QString time = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
        switch (messageType)
        {
            case Message:
            {
                in >> userName >> HostName >> ipAddress >> message;
                ui->messageBrower->setTextColor(Qt::green);
                ui->messageBrower->setCurrentFont(QFont("黑体",8));
                ui->messageBrower->append("[ " + userName + " ]" + time);
                ui->messageBrower->append(message);
                break;
            }
            case NewParticipant:
            {
                in >> userName >> HostName >>ipAddress;
                newParticipant(userName,HostName,ipAddress);
                break;
            }
            case LeftParticipant:
            {
                in >> userName >> HostName;
                leftParticipant(userName,HostName,time);
                break;
            }
            case SendFileName:
            {
                QString clientAddress,fileName;
                in >> userName >> HostName >> ipAddress;
                in >> clientAddress >> fileName;
                hasPendingFile(userName,ipAddress,clientAddress,fileName);
                break;
            }
            case RefuseFile:
            {
                QString serverAddress;
                in >> userName >> HostName >> serverAddress;
                QString ipAddress = localIPaddress;
                if(ipAddress == serverAddress)
                {
                    server->refused();
                }
                break;
            }
            case AskChat:
            {
                in >> userName >> HostName >> ipAddress;
                privateChatFrom = new Chat(userName,ipAddress,logusername,localIPaddress);
                connect(privateChatFrom,SIGNAL(exitChat()),this,SLOT(CloseChatFrom()));
                break;
            }
        }
    }
}

void MainWindow::getSendFileName(QString name)
{
    fileName = name;
    sendMessage(SendFileName);
}

void MainWindow::newParticipant(QString userName, QString localHostName, QString ipAddress)
{
    bool isEmpty = ui ->userTableWidget->findItems(ipAddress,Qt::MatchExactly).isEmpty();
    if(isEmpty)
    {
        QTableWidgetItem *user = new QTableWidgetItem(userName);
        QTableWidgetItem *host = new QTableWidgetItem(localHostName);
        QTableWidgetItem *ip = new QTableWidgetItem(ipAddress);

        ui->userTableWidget->insertRow(0);
        ui->userTableWidget->setItem(0,0,user);
        ui->userTableWidget->setItem(0,1,host);
        ui->userTableWidget->setItem(0,2,ip);

        ui->messageBrower->setTextColor(Qt::gray);
        ui->messageBrower->setCurrentFont(QFont("黑体",10));

        ui->messageBrower->append(tr("%1 在线").arg(userName));
        ui->userNumLabel->setText(tr("在线人数:%1").arg(ui->userTableWidget->rowCount()));
        sendMessage(NewParticipant);
    }
}


void MainWindow::hasPendingFile(QString userName, QString serverAddress,QString clientAddress, QString fileName)
{
    if(clientAddress == localIPaddress)
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
            else
            {
               TcpClient  *client = new TcpClient(this);
               client->localFile =new QFile(fileName);
            }
        }
        else if(btn == QMessageBox::No)
        {
            sendMessage(RefuseFile,serverAddress);
            TcpClient *client = new TcpClient(this);
            client->localFile =new QFile(fileName);
        }
    }
}

void MainWindow::leftParticipant(QString userName, QString localHostName, QString time)
{
    int rowNum = ui->userTableWidget->findItems(localHostName,Qt::MatchExactly).first()->row();
    ui->userTableWidget->removeRow(rowNum);
    ui->messageBrower->setTextColor(Qt::gray);
    ui->messageBrower->setCurrentFont(QFont("黑体",10));
    ui->messageBrower->append(tr("%1于%2离开").arg(userName).arg(time));
    ui->userNumLabel->setText(tr("在线人数:%1").arg(ui->userTableWidget->rowCount()));
}

QString MainWindow::getIP()
{
    QList<QHostAddress > list = QNetworkInterface::allAddresses();
    foreach (QHostAddress address, list)
    {
        if(address.protocol() == QAbstractSocket::IPv4Protocol &&
           address.toString() != "127.0.0.1")
            return address.toString();
    }
    return 0;
}

QString MainWindow::getMessage()
{
    QString msg = ui->messageTextEdit->toHtml();
    ui->messageTextEdit->clear();
    ui->messageTextEdit->setFocus();
    return msg;
}

void MainWindow::closeEvent(QCloseEvent *e)
{
    QString fileName = "RECORD_GROUP";
    saveFile(fileName);
    sendMessage(LeftParticipant);
    QWidget::closeEvent(e);
}

void MainWindow::on_sendPushButton_clicked()
{
    sendMessage(Message);
}

void MainWindow::on_exitPushButton_clicked()
{
    QString fileName = "RECORD_GROUP";
    saveFile(fileName);
    close();
}

void MainWindow::on_sendToolBtn_clicked()
{
    if(ui->userTableWidget->selectedItems().isEmpty())
    {
        QMessageBox::warning(0,tr("选择用户"),tr("请从用户列表选择要传送的用户!"),QMessageBox::Ok);
        return;
    }
    server->show();
    server->initServer();
}

void MainWindow::on_readToolBtn_clicked()
{
    QString fileName = "RECORD_GROUP";
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
    his.setWindowTitle("群聊记录");
    his.show();
}

bool MainWindow::saveFile(const QString &fileName)
{
    QFile file(fileName);
    if(! file.open(QFile::WriteOnly | QFile::Text | QIODevice::Append))
    {
        QMessageBox::warning(this,tr("保存记录"),tr("无法保存记录 %1:\n").arg(fileName).arg(file.errorString()));
        return false;
    }
    QTextStream out(&file);
    out << ui->messageBrower->toPlainText() + "\n";
    return true;
}

void MainWindow::closeChatTo()
{
    delete privateChatTo;
}

void MainWindow::CloseChatFrom()
{
    delete privateChatFrom;
}

void MainWindow::on_userTableWidget_doubleClicked(const QModelIndex &index)
{
    if(ui->userTableWidget->item(index.row(),0)->text() == logusername &&
       ui->userTableWidget->item(index.row(),2)->text() == localIPaddress)
    {
        QMessageBox::warning(0,tr("警告"),tr("不可以和自己聊天"),QMessageBox::Ok);
        return ;
    }
    else
    {
        QString touser = ui->userTableWidget->item(index.row(),0)->text();
        QString toaddress = ui->userTableWidget->item(index.row(),2)->text();
        privateChatTo = new Chat(touser,toaddress,logusername,localIPaddress);
        connect(this->privateChatTo,SIGNAL(exitChat()),this,SLOT(closeChatTo()));

        QByteArray data;
        QDataStream out(&data,QIODevice::WriteOnly);
        QString localHostName = QHostInfo::localHostName();
        out << AskChat << logusername << localHostName << localIPaddress;

        udpSocket->writeDatagram(data,data.length(),QHostAddress(toaddress),port);

        privateChatTo->show();
        privateChatTo->setWindowTitle("私聊");
        privateChatTo->is_opend = true;
    }
}



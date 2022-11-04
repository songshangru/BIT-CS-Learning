#include "tcpclient.h"
#include "ui_tcpclient.h"



TcpClient::TcpClient(QWidget *parent) :
    QDialog(parent),
    tcpClient(nullptr),
    localFile(nullptr),
    TotalBytes(0),
    bytesReceived(0),
    fileNameSize(0),
    tcpPort(8719),
    ui(new Ui::TcpClient)
{
    ui->setupUi(this);
    tcpClient = new QTcpSocket(this);
    connect(tcpClient,SIGNAL(readyRead()),this,SLOT(readMessage()));
    connect(tcpClient,SIGNAL(error(QAbstractSocket::SocketError)),this,SLOT(displayError(QAbstractSocket::SocketError)));
}

TcpClient::~TcpClient()
{
    delete ui;
}

void TcpClient::setFileName(QString fileName)
{
    localFile = new QFile(fileName);
}

void TcpClient::setHostAddress(QHostAddress address)
{
    hostAddress = address;
    newConnect();
}

void TcpClient::newConnect()
{
    blockSize = 0;
    tcpClient->abort();
    tcpClient->connectToHost(hostAddress,tcpPort);
    time.start();
}

void TcpClient::readMessage()
{
    QDataStream in(tcpClient);
    in.setVersion(QDataStream::Qt_4_0);
    float useTime = time.elapsed();
    if(bytesReceived <= sizeof(qint64)*2)
    {
        if((tcpClient->bytesAvailable() >= sizeof(qint64)*2) && (fileNameSize ==0))
        {
            in >> TotalBytes >> fileNameSize;
            bytesReceived += sizeof(qint64)*2;
        }
        if((tcpClient->bytesAvailable() >= fileNameSize) && (fileNameSize!=0))
        {
            in >> fileName;
            bytesReceived += fileNameSize;
            if(! localFile->open(QFile::WriteOnly))
            {
                QMessageBox::warning(this,tr("警告"),tr("无法读取文件 %1:\n%2.").arg(fileName).arg(localFile->errorString()));
                return ;
            }
            else return ;
        }
    }
    if(bytesReceived < TotalBytes)
    {
        bytesReceived += tcpClient->bytesAvailable();
        inBlock = tcpClient->readAll();
        localFile->write(inBlock);
        inBlock.resize(0);
    }

    ui->progressBar->setMaximum(TotalBytes);
    ui->progressBar->setValue(bytesReceived);

    double speed = bytesReceived / useTime;
    ui->tcpClientStatusLabel->setText(tr("已接收 %1MB( %2MB/s)"
                                         "\n共%3MB 已用时:%4秒\n估计剩余时间:%5秒")
                                      .arg(bytesReceived / (1024*1024))
                                      .arg(speed *1000/(1024*1024),0,'f',2)
                                      .arg(TotalBytes / (1024*1024))
                                      .arg(useTime/1000,0,'f',0)
                                      .arg(TotalBytes/speed/1000 - useTime/1000,0,'f',0 ));
    if(bytesReceived == TotalBytes)
    {
       localFile ->close();
       tcpClient->close();
       ui->tcpClientStatusLabel->setText(tr("接收文件: %1完毕").arg(fileName));
    }
}

void TcpClient::displayError(QAbstractSocket::SocketError sockError)
{
    qDebug() << tcpClient->errorString();
}


void TcpClient::on_tcpClientCancleBtn_clicked()
{
    tcpClient->abort();
    if(localFile->isOpen())
    {
        localFile->close();
    }
    close();
    ui->~TcpClient();
}

void TcpClient::on_tcpClientCloseBtn_clicked()
{
    tcpClient->abort();
    if(localFile->isOpen())
    {
        localFile->close();
    }
    close();
    ui->~TcpClient();
}


void TcpClient::closeEvent(QCloseEvent *)
{
    on_tcpClientCloseBtn_clicked();
}

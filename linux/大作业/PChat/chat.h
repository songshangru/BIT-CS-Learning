#ifndef CHAT_H
#define CHAT_H

#include<QDialog>
#include"lib.h"
#include"tcpserver.h"
#include"tcpclient.h"
#include"history.h"

namespace Ui {
class Chat;
}

class Chat : public QDialog
{
    Q_OBJECT

public:
    Chat(QString passusername,QString passuserip,QString selfusername,QString selfip);
    ~Chat();
    QString opuserip;
    QString opusername;
    QUdpSocket *xchat;
    qint32 xport;
    bool is_opend ;
    void sendMessage(messageType type,QString serverAddress = "");

private slots:
    void processPendinDatagrams();
    void getSendFileName(QString);
    void on_sendToolButton_clicked();
    void on_closePushButton_clicked();
    void on_sendPushButton_clicked();
    void on_readToolButton_clicked();

signals:
    void exitChat();

private:
    Ui::Chat *ui;
    TcpServer *server;
    QString logusername;
    QString localIPaddress;
    History his;
    bool used;
    QString message;
    QString fileName;

    QString getMessage();
    void hasPendinFile(QString userName,QString serverAddress,QString clientAddress,QString filename);
    void userLeft(QString userName,QString localHostName,QString time);
    void saveFile(QString fileName);
    void closeEvent(QCloseEvent *);
};

#endif // CHAT_H

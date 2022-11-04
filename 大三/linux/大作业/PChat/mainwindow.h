#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QWidget>
#include"tcpclient.h"
#include"tcpserver.h"
#include"chat.h"
#include"lib.h"
#include"history.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QWidget
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:
    void closeChatTo();
    void CloseChatFrom();
    void setUserName(QString name);
    void processPendingDatagrams();
    void getSendFileName(QString);
    void on_sendPushButton_clicked();
    void on_exitPushButton_clicked();
    void on_sendToolBtn_clicked();
    void on_userTableWidget_doubleClicked(const QModelIndex &index);
    void on_readToolBtn_clicked();

private:
    Ui::MainWindow *ui;

    QUdpSocket *udpSocket;
    qint16 port;
    QString logusername;
    QString localhostname;
    QString localIPaddress;
    QString fileName;
    TcpServer *server;
    History his;
    Chat *privateChatTo;
    Chat *privateChatFrom;

    void newParticipant(QString userName,QString localHostName,QString ipAddress);
    void leftParticipant(QString userName,QString localHostName,QString time);
    void sendMessage(messageType type,QString serverAddress = "");
    QString getIP();
    QString getMessage();
    void hasPendingFile(QString userName,QString serverAddress,QString clientAddress,QString fileName);
    bool saveFile(const QString &fileName);
    void closeEvent(QCloseEvent *e);
};

#endif // MAINWINDOW_H

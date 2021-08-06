#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QDialog>
#include<QWidget>
#include"lib.h"

namespace Ui {
class TcpServer;
}

class TcpServer : public QDialog
{
    Q_OBJECT

public:
    explicit TcpServer(QWidget *parent = 0);
    ~TcpServer();
    void initServer();
    void refused();

protected:
    void closeEvent(QCloseEvent *);

signals:
    void sendFileName(QString);

private slots:

    void on_serverOpenBtn_clicked();
    void on_serverSendBtn_clicked();
    void on_serverCloseBtn_clicked();
    void sendFile();
    void updateClientProgress(qint64 );
private:
    Ui::TcpServer *ui;

    QTcpServer *tcpServer;
    QTcpSocket *clientConnection;
    qint16 tcpPort;
    QFile *localFile ;
    qint64 payloadSize ;
    qint64 TotalBytes ;
    qint64 bytesWritten ;
    qint64 bytestoWrite;
    QString theFileName;
    QString fileName;
    QTime time;
    QByteArray outBlock;

};

#endif // TCPSERVER_H

#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QDialog>
#include"lib.h"


namespace Ui {
class TcpClient;
}

class TcpClient : public QDialog
{
    Q_OBJECT

public:
    explicit TcpClient(QWidget *parent = 0);
    ~TcpClient();
    void setFileName(QString fileName);
    void setHostAddress(QHostAddress address);
    void closeEvent(QCloseEvent *);
    QFile *localFile;

private slots:
    void on_tcpClientCancleBtn_clicked();
    void on_tcpClientCloseBtn_clicked();
    void readMessage();
    void displayError(QAbstractSocket::SocketError);
    void newConnect();

private:
    Ui::TcpClient *ui;
    QTcpSocket *tcpClient;
    qint16  tcpPort ;
    QHostAddress hostAddress;
    qint64 TotalBytes ;
    qint64 bytesReceived;
    qint64 fileNameSize ;
    qint64 blockSize;
    QString fileName;
    QTime time;
    QByteArray inBlock;
};

#endif // TCPCLIENT_H

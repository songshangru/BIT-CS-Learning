#ifndef LIB_H
#define LIB_H

#include<QFile>

#include<QNetworkInterface>
#include<QUdpSocket>
#include<QTcpSocket>
#include<QTcpServer>
#include<QTextStream>
#include<QDataStream>
#include<QTime>
#include<QFont>
#include<QScrollBar>
#include<QString>
#include<QStringList>
#include<QDebug>
#include<QKeyEvent>
#include<QFileDialog>
#include<QCloseEvent>
#include<QHostAddress>
#include<QHostInfo>
#include<QMessageBox>
#include<QDateTime>


//信息类型,分别为普通消息,新加入用户,用户退出,发送文件,拒绝接受文件,发起私聊
enum messageType{
    Message,
    NewParticipant,
    LeftParticipant,
    RefuseFile,
    SendFileName,
    AskChat
};

#endif // LIB_H

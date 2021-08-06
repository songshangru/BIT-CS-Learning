#include "mainwindow.h"
#include "login.h"
#include <QApplication>
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QFont font;
    font.setFamily("黑体");
    a.setFont(font);

    Login log;
    MainWindow w;

    QObject::connect(&log,SIGNAL(LoginSuccess(QString)),&w,SLOT(setUserName(QString)));

    w.setWindowTitle("聊天室");
    log.setWindowTitle("登录");

    log.show();

    return a.exec();
}

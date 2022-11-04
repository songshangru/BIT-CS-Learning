#ifndef LOGIN_H
#define LOGIN_H

#include <QWidget>
#include "lib.h"

namespace Ui {
class Login;
}

class Login : public QWidget
{
    Q_OBJECT

public:
    explicit Login(QWidget *parent = 0);
    ~Login();

private slots:
    void on_login_btn_clicked();

signals:
    void LoginSuccess(QString username);

private:
    Ui::Login *ui;
};

#endif // LOGIN_H

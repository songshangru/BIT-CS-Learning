#include "login.h"
#include "ui_login.h"

Login::Login(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Login)
{
    ui->setupUi(this);
    QFile qssfile(":/qdarkgraystyle/style.qss");
    qssfile.open(QFile::ReadOnly);
    QTextStream filetext(&qssfile);
    QString stylesheet = filetext.readAll();
    this->setStyleSheet(stylesheet);
    qssfile.close();
}

Login::~Login()
{
    delete ui;
}

void Login::on_login_btn_clicked()
{
    if(ui->Username->text()!="")
    {
        emit LoginSuccess(ui->Username->text());
        this->close();
    }
}


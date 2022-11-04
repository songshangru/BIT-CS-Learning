#include "history.h"
#include "ui_history.h"

History::History(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::History)
{
    ui->setupUi(this);
    QFile qssfile(":/qdarkgraystyle/style.qss");
    qssfile.open(QFile::ReadOnly);
    QTextStream filetext(&qssfile);
    QString stylesheet = filetext.readAll();
    this->setStyleSheet(stylesheet);
    qssfile.close();
}

History::~History()
{
    delete ui;
}

void History::init(QString username, QString histext)
{
    ui->textHis->setText(histext);
}

#ifndef HISTORY_H
#define HISTORY_H

#include <QWidget>
#include <lib.h>

namespace Ui {
class History;
}

class History : public QWidget
{
    Q_OBJECT

public:
    explicit History(QWidget *parent = 0);
    void init(QString username,QString histext);
    ~History();

private:
    Ui::History *ui;
};

#endif // HISTORY_H

/********************************************************************************
** Form generated from reading UI file 'history.ui'
**
** Created by: Qt User Interface Compiler version 5.9.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_HISTORY_H
#define UI_HISTORY_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_History
{
public:
    QTextBrowser *textHis;

    void setupUi(QWidget *History)
    {
        if (History->objectName().isEmpty())
            History->setObjectName(QStringLiteral("History"));
        History->resize(400, 300);
        textHis = new QTextBrowser(History);
        textHis->setObjectName(QStringLiteral("textHis"));
        textHis->setGeometry(QRect(10, 10, 381, 281));

        retranslateUi(History);

        QMetaObject::connectSlotsByName(History);
    } // setupUi

    void retranslateUi(QWidget *History)
    {
        History->setWindowTitle(QApplication::translate("History", "Form", Q_NULLPTR));
    } // retranslateUi

};

namespace Ui {
    class History: public Ui_History {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_HISTORY_H

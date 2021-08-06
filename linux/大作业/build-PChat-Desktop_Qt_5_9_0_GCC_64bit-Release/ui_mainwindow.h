/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.9.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTableWidget>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QToolButton>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QTextBrowser *messageBrower;
    QToolButton *sendToolBtn;
    QTextEdit *messageTextEdit;
    QTableWidget *userTableWidget;
    QPushButton *sendPushButton;
    QPushButton *exitPushButton;
    QLabel *userNumLabel;
    QToolButton *readToolBtn;

    void setupUi(QWidget *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QStringLiteral("MainWindow"));
        MainWindow->resize(670, 440);
        MainWindow->setMinimumSize(QSize(670, 440));
        MainWindow->setMaximumSize(QSize(670, 440));
        messageBrower = new QTextBrowser(MainWindow);
        messageBrower->setObjectName(QStringLiteral("messageBrower"));
        messageBrower->setGeometry(QRect(200, 10, 451, 211));
        sendToolBtn = new QToolButton(MainWindow);
        sendToolBtn->setObjectName(QStringLiteral("sendToolBtn"));
        sendToolBtn->setGeometry(QRect(460, 230, 91, 30));
        sendToolBtn->setAutoFillBackground(false);
        sendToolBtn->setIconSize(QSize(20, 20));
        sendToolBtn->setAutoRaise(false);
        messageTextEdit = new QTextEdit(MainWindow);
        messageTextEdit->setObjectName(QStringLiteral("messageTextEdit"));
        messageTextEdit->setGeometry(QRect(200, 270, 451, 101));
        userTableWidget = new QTableWidget(MainWindow);
        if (userTableWidget->columnCount() < 3)
            userTableWidget->setColumnCount(3);
        QTableWidgetItem *__qtablewidgetitem = new QTableWidgetItem();
        userTableWidget->setHorizontalHeaderItem(0, __qtablewidgetitem);
        QTableWidgetItem *__qtablewidgetitem1 = new QTableWidgetItem();
        userTableWidget->setHorizontalHeaderItem(1, __qtablewidgetitem1);
        QTableWidgetItem *__qtablewidgetitem2 = new QTableWidgetItem();
        userTableWidget->setHorizontalHeaderItem(2, __qtablewidgetitem2);
        userTableWidget->setObjectName(QStringLiteral("userTableWidget"));
        userTableWidget->setGeometry(QRect(10, 10, 181, 361));
        userTableWidget->setSelectionMode(QAbstractItemView::SingleSelection);
        userTableWidget->setSelectionBehavior(QAbstractItemView::SelectRows);
        userTableWidget->setShowGrid(false);
        userTableWidget->setGridStyle(Qt::DashLine);
        sendPushButton = new QPushButton(MainWindow);
        sendPushButton->setObjectName(QStringLiteral("sendPushButton"));
        sendPushButton->setGeometry(QRect(570, 390, 80, 31));
        exitPushButton = new QPushButton(MainWindow);
        exitPushButton->setObjectName(QStringLiteral("exitPushButton"));
        exitPushButton->setGeometry(QRect(200, 390, 80, 31));
        userNumLabel = new QLabel(MainWindow);
        userNumLabel->setObjectName(QStringLiteral("userNumLabel"));
        userNumLabel->setGeometry(QRect(20, 390, 131, 26));
        readToolBtn = new QToolButton(MainWindow);
        readToolBtn->setObjectName(QStringLiteral("readToolBtn"));
        readToolBtn->setGeometry(QRect(560, 230, 91, 30));
        readToolBtn->setIconSize(QSize(20, 20));
        readToolBtn->setAutoRaise(false);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QWidget *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "Widget", Q_NULLPTR));
#ifndef QT_NO_TOOLTIP
        sendToolBtn->setToolTip(QApplication::translate("MainWindow", "\344\274\240\350\276\223\346\226\207\344\273\266", Q_NULLPTR));
#endif // QT_NO_TOOLTIP
        sendToolBtn->setText(QApplication::translate("MainWindow", "\346\226\207\344\273\266\344\270\212\344\274\240", Q_NULLPTR));
        QTableWidgetItem *___qtablewidgetitem = userTableWidget->horizontalHeaderItem(0);
        ___qtablewidgetitem->setText(QApplication::translate("MainWindow", "\347\224\250\346\210\267\345\220\215", Q_NULLPTR));
        QTableWidgetItem *___qtablewidgetitem1 = userTableWidget->horizontalHeaderItem(1);
        ___qtablewidgetitem1->setText(QApplication::translate("MainWindow", "\344\270\273\346\234\272\345\220\215", Q_NULLPTR));
        QTableWidgetItem *___qtablewidgetitem2 = userTableWidget->horizontalHeaderItem(2);
        ___qtablewidgetitem2->setText(QApplication::translate("MainWindow", "IP\345\234\260\345\235\200", Q_NULLPTR));
        sendPushButton->setText(QApplication::translate("MainWindow", "\345\217\221\351\200\201", Q_NULLPTR));
        exitPushButton->setText(QApplication::translate("MainWindow", "\351\200\200\345\207\272", Q_NULLPTR));
        userNumLabel->setText(QApplication::translate("MainWindow", "\345\234\250\347\272\277\347\224\250\346\210\267:", Q_NULLPTR));
#ifndef QT_NO_TOOLTIP
        readToolBtn->setToolTip(QApplication::translate("MainWindow", "\344\277\235\345\255\230\350\201\212\345\244\251\350\256\260\345\275\225", Q_NULLPTR));
#endif // QT_NO_TOOLTIP
        readToolBtn->setText(QApplication::translate("MainWindow", "\350\256\260\345\275\225\346\237\245\347\234\213", Q_NULLPTR));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H

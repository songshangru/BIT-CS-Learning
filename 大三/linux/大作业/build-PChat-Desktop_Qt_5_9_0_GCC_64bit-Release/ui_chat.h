/********************************************************************************
** Form generated from reading UI file 'chat.ui'
**
** Created by: Qt User Interface Compiler version 5.9.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_CHAT_H
#define UI_CHAT_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QDialog>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QToolButton>

QT_BEGIN_NAMESPACE

class Ui_Chat
{
public:
    QLabel *label;
    QTextBrowser *textBrowser;
    QToolButton *sendToolButton;
    QToolButton *readToolButton;
    QTextEdit *messageTextEdit;
    QPushButton *closePushButton;
    QPushButton *sendPushButton;

    void setupUi(QDialog *Chat)
    {
        if (Chat->objectName().isEmpty())
            Chat->setObjectName(QStringLiteral("Chat"));
        Chat->resize(530, 460);
        Chat->setMinimumSize(QSize(530, 460));
        Chat->setMaximumSize(QSize(530, 460));
        label = new QLabel(Chat);
        label->setObjectName(QStringLiteral("label"));
        label->setGeometry(QRect(40, 20, 441, 31));
        textBrowser = new QTextBrowser(Chat);
        textBrowser->setObjectName(QStringLiteral("textBrowser"));
        textBrowser->setGeometry(QRect(40, 50, 451, 211));
        sendToolButton = new QToolButton(Chat);
        sendToolButton->setObjectName(QStringLiteral("sendToolButton"));
        sendToolButton->setGeometry(QRect(290, 270, 91, 30));
        sendToolButton->setIconSize(QSize(20, 20));
        readToolButton = new QToolButton(Chat);
        readToolButton->setObjectName(QStringLiteral("readToolButton"));
        readToolButton->setGeometry(QRect(390, 270, 91, 30));
        readToolButton->setIconSize(QSize(20, 20));
        messageTextEdit = new QTextEdit(Chat);
        messageTextEdit->setObjectName(QStringLiteral("messageTextEdit"));
        messageTextEdit->setGeometry(QRect(40, 310, 451, 101));
        closePushButton = new QPushButton(Chat);
        closePushButton->setObjectName(QStringLiteral("closePushButton"));
        closePushButton->setGeometry(QRect(290, 420, 91, 31));
        closePushButton->setIconSize(QSize(25, 31));
        sendPushButton = new QPushButton(Chat);
        sendPushButton->setObjectName(QStringLiteral("sendPushButton"));
        sendPushButton->setGeometry(QRect(390, 420, 91, 31));

        retranslateUi(Chat);

        QMetaObject::connectSlotsByName(Chat);
    } // setupUi

    void retranslateUi(QDialog *Chat)
    {
        Chat->setWindowTitle(QApplication::translate("Chat", "Dialog", Q_NULLPTR));
        label->setText(QApplication::translate("Chat", "TextLabel", Q_NULLPTR));
        sendToolButton->setText(QApplication::translate("Chat", "\346\226\207\344\273\266\344\270\212\344\274\240", Q_NULLPTR));
        readToolButton->setText(QApplication::translate("Chat", "\350\256\260\345\275\225\346\237\245\347\234\213", Q_NULLPTR));
        closePushButton->setText(QApplication::translate("Chat", "\345\205\263\351\227\255", Q_NULLPTR));
        sendPushButton->setText(QApplication::translate("Chat", "\345\217\221\351\200\201", Q_NULLPTR));
    } // retranslateUi

};

namespace Ui {
    class Chat: public Ui_Chat {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_CHAT_H

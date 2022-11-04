/********************************************************************************
** Form generated from reading UI file 'login.ui'
**
** Created by: Qt User Interface Compiler version 5.9.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_LOGIN_H
#define UI_LOGIN_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Login
{
public:
    QWidget *Username_widget;
    QHBoxLayout *horizontalLayout_2;
    QLineEdit *Username;
    QLabel *Title;
    QPushButton *login_btn;

    void setupUi(QWidget *Login)
    {
        if (Login->objectName().isEmpty())
            Login->setObjectName(QStringLiteral("Login"));
        Login->resize(400, 244);
        Username_widget = new QWidget(Login);
        Username_widget->setObjectName(QStringLiteral("Username_widget"));
        Username_widget->setGeometry(QRect(10, 70, 371, 61));
        horizontalLayout_2 = new QHBoxLayout(Username_widget);
        horizontalLayout_2->setObjectName(QStringLiteral("horizontalLayout_2"));
        Username = new QLineEdit(Username_widget);
        Username->setObjectName(QStringLiteral("Username"));
        QSizePolicy sizePolicy(QSizePolicy::Expanding, QSizePolicy::Fixed);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(Username->sizePolicy().hasHeightForWidth());
        Username->setSizePolicy(sizePolicy);
        Username->setMinimumSize(QSize(0, 40));
        Username->setMaximumSize(QSize(16777215, 40));

        horizontalLayout_2->addWidget(Username);

        Title = new QLabel(Login);
        Title->setObjectName(QStringLiteral("Title"));
        Title->setGeometry(QRect(150, 30, 101, 41));
        login_btn = new QPushButton(Login);
        login_btn->setObjectName(QStringLiteral("login_btn"));
        login_btn->setGeometry(QRect(120, 150, 161, 51));

        retranslateUi(Login);

        QMetaObject::connectSlotsByName(Login);
    } // setupUi

    void retranslateUi(QWidget *Login)
    {
        Login->setWindowTitle(QApplication::translate("Login", "Form", Q_NULLPTR));
        Username->setPlaceholderText(QApplication::translate("Login", "\347\224\250\346\210\267\345\220\215", Q_NULLPTR));
        Title->setText(QApplication::translate("Login", "\350\264\246\345\217\267\347\231\273\345\275\225", Q_NULLPTR));
        login_btn->setText(QApplication::translate("Login", "\347\231\273\345\275\225", Q_NULLPTR));
    } // retranslateUi

};

namespace Ui {
    class Login: public Ui_Login {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_LOGIN_H

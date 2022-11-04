#-------------------------------------------------
#
# Project created by QtCreator 2021-07-07T12:26:20
#
#-------------------------------------------------

QT       += core gui network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = PChat
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += main.cpp\
    tcpserver.cpp \
    tcpclient.cpp \
    chat.cpp \
    mainwindow.cpp \
    history.cpp \
    login.cpp

HEADERS  += \
    tcpserver.h \
    tcpclient.h \
    chat.h \
    mainwindow.h \
    history.h \
    login.h \
    lib.h

FORMS    += \
    tcpserver.ui \
    tcpclient.ui \
    chat.ui \
    mainwindow.ui \
    history.ui \
    login.ui

RESOURCES += \
    qdarkgraystyle/style.qrc


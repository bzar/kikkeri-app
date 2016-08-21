QT += qml quick

CONFIG += c++11

HEADERS += src/key_emitter.h \
    src/raspberrybacklight.h
SOURCES += src/main.cpp \
    src/key_emitter.cpp \
    src/raspberrybacklight.cpp

RESOURCES += qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml

# Default rules for deployment.
include(deployment.pri)

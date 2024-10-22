QT       += core gui sql

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets quickwidgets

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    mainwindow.cpp \
    server.cpp

HEADERS += \
    mainwindow.h \
    server.h

FORMS += \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    qml.qrc

DISTFILES += \
    offline_tiles/osm_100-l-3-0-0-0.png \
    offline_tiles/osm_100-l-3-1-0-0.png \
    offline_tiles/osm_100-l-3-1-0-1.png \
    offline_tiles/osm_100-l-3-1-1-0.png \
    offline_tiles/osm_100-l-3-1-1-1.png \
    offline_tiles/osm_100-l-3-2-0-0.png \
    offline_tiles/osm_100-l-3-2-0-1.png \
    offline_tiles/osm_100-l-3-2-0-2.png \
    offline_tiles/osm_100-l-3-2-0-3.png \
    offline_tiles/osm_100-l-3-2-1-0.png \
    offline_tiles/osm_100-l-3-2-1-1.png \
    offline_tiles/osm_100-l-3-2-1-2.png \
    offline_tiles/osm_100-l-3-2-1-3.png \
    offline_tiles/osm_100-l-3-2-2-0.png \
    offline_tiles/osm_100-l-3-2-2-1.png \
    offline_tiles/osm_100-l-3-2-2-2.png \
    offline_tiles/osm_100-l-3-2-2-3.png \
    offline_tiles/osm_100-l-3-2-3-0.png \
    offline_tiles/osm_100-l-3-2-3-1.png \
    offline_tiles/osm_100-l-3-2-3-2.png \
    offline_tiles/osm_100-l-3-2-3-3.png

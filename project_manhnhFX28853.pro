QT += quickcontrols2 multimedia dbus xml
QT += location
CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
# getdata from dbus
DBUS_INTERFACES += Dbus/climate.xml
DEFINES += PROJECT_PATH=\"\\\"$${_PRO_FILE_PWD_}/\\\"\"

SOURCES += \
        App/Climate/climatemodel.cpp \
        App/Media/player.cpp \
        App/Media/playlistmodel.cpp \
        applicationsmodel.cpp \
        main.cpp \
        xmlreader.cpp

RESOURCES += \
            qml.qrc\

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Dbus/climate.xml \
    Dbus/desktop.ini \
    applications.xml

LIBS += -ltag

HEADERS += \
    App/Climate/climatemodel.h \
    App/Media/player.h \
    App/Media/playlistmodel.h \
    applicationsmodel.h \
    loghelper.h \
    xmlreader.h

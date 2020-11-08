QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += link_pkgconfig
PKGCONFIG += sdl SDL_mixer SDL_image SDL_Pango SDL_ttf librsvg-2.0 fribidi libpng16

DEFINES += "LOCALEDIR=/usr/local" \
    "IMDIR=\\\"./resource/im\\\"" \
    "DATA_PREFIX=\\\"./resource/\\\"" \
    "VER_VERSION=\\\"version\\\"" \
    "VER_DATE=\\\"version\\\"" \
    "MAGIC_PREFIX=\\\"version\\\"" \
    "DOC_PREFIX=\\\"version\\\"" \
    "LOCALEDIR=\\\"./resource/po/\\\"" \
    "CONFDIR=\\\"version\\\""

SOURCES += \
    src/*.c

HEADERS += \
    src/*.h

INCLUDEPATH += src/ src/mouse

message("os is: $${QMAKE_HOST.os}")

contains(QMAKE_HOST.os, "Linux") {
SOURCES += \
    src/unix/*.c

HEADERS += \
    src/unix/*.h

INCLUDEPATH += src/unix
LIBS += -limagequant -lpaper -lz

GPERF=/usr/bin/gperf
}

#pares-target.target = this
#pares-target.commands = $${GPERF} src/parse.gperf > src/parse_step1.c

#QMAKE_EXTRA_TARGETS += pares-target
#PRE_TARGETDEPS += this


#win32: {
#SOURCES += \
#    src/win32/*.c

#HEADERS += \
#    src/win32/*.h
#}

TRANSLATIONS += \
    tuxpaint-qt_zh_CN.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

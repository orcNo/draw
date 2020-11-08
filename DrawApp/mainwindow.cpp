#include <QHBoxLayout>
#include <QPushButton>
#include <QProcess>
#include <QDebug>

#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    auto w = new QWidget(this);
    auto layout = new QHBoxLayout;
    w->setLayout(layout);

    auto btn =new QPushButton(tr("Draw"));
    connect(btn, &QPushButton::clicked, this, [this](bool clicked) {
        Q_UNUSED(clicked)

        auto p = new QProcess(this);
        connect(p, &QProcess::started, this, [](){
            qDebug() << "process started: ";
        });
        connect(p, &QProcess::errorOccurred, this, [](QProcess::ProcessError err){
            qDebug() << "process error: " << err;
        });
        connect(p, &QProcess::readyReadStandardOutput, this, [p](){
            qDebug() << "run tuxpaint-qt output: " << p->readAllStandardOutput();
        });
        connect(p, &QProcess::readyReadStandardError, this, [p](){
            qDebug() << "run tuxpaint-qt error: " << p->readAllStandardError();
        });

        QStringList args;
        args << "--lang"
             << "simplified-chinese"
             << "--fullscreen"
             << "1";
        p->setWorkingDirectory("../tuxpaint-qt");
        p->start("../tuxpaint-qt/tuxpaint-qt", args);
        p->waitForStarted();
    });
    layout->addWidget(btn);

    setCentralWidget(w);
}

MainWindow::~MainWindow()
{
}


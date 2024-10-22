#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QQmlContext>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // ui->quickWidget->setSource(QUrl(QStringLiteral("qrc:/map.qml")));
    // ui->quickWidget->show();


    server = new Server();
    connect(ui->pb_server,&QPushButton::clicked,server,&Server::startServer);

    engine = new QQmlApplicationEngine();
    engine->rootContext()->setContextProperty("server",server);
    //engine->addImportPath(QDir(QCoreApplication::applicationDirPath()).filePath("qml"));
    engine->load(QUrl(QStringLiteral("qrc:/map.qml")));
    auto topLevelObject = engine->rootObjects().value(0);
    auto window = qobject_cast<QQuickWindow *>(topLevelObject);
    QWidget* container = QWidget::createWindowContainer(window);
    ui->verticalLayout->addWidget(container);

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::LongAndLatDataHandler(qreal x, qreal y)
{

}


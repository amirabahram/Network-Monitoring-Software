#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtSql>
#include <Server.h>
#include <qqmlapplicationengine.h>
QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
private:
    Server* server;
QQmlApplicationEngine* engine;
private slots:
    void LongAndLatDataHandler(qreal x,qreal y);

private:
    Ui::MainWindow *ui;

};
#endif // MAINWINDOW_H

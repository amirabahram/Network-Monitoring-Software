#ifndef SERVER_H
#define SERVER_H

#include <QObject>
#include <QQuickItem>
#include <QTcpServer>
#include <QVariantList>
class Server : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList getPositions READ getPositions NOTIFY sendLongitudeAndLatitude FINAL)

public:
    explicit Server(QObject *parent = nullptr);
    QVariantList  getPositions();

public slots:
    void startServer();
private:
    QTcpServer* _tcpServer;
    QTcpSocket* _socket;
    QList<QPointF> positions;
private slots:
    void onNewConnection();
    void readData(QTcpSocket* socket);
    void onReadyRead();
signals:
    void sendLongitudeAndLatitude();
};

#endif // SERVER_H

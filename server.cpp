#include "server.h"
#include <QTcpSocket>
#include <QPointF>
Server::Server(QObject *parent)
    : QObject{parent}
{
    _tcpServer = new QTcpServer();
    if(!_tcpServer->listen(QHostAddress::LocalHost,8080)){
        qDebug()<<"Server Could not start!";
    }else{
        qDebug() << "Server is Listening!";
        connect(_tcpServer,&QTcpServer::newConnection,this,&Server::onNewConnection);
    }

}

void Server::startServer()
{
    if(_tcpServer->isListening()){
        qDebug()<<"Server is Already Listening!";
        return;
    }
    if(_tcpServer->listen(QHostAddress::LocalHost,8080)){
        connect(_tcpServer,&QTcpServer::newConnection,this,&Server::onNewConnection);
        qDebug() << "Server is Listening!";
    }
}

QVariantList  Server::getPositions()
{
    QVariantList result;
    for (const QPointF &point : positions) {
        QVariantMap pointMap;
        pointMap["x"] = point.x();
        pointMap["y"] = point.y();
        result.append(pointMap);
    }
    return result;
}

void Server::onNewConnection()
{
    QTcpSocket* socket = _tcpServer->nextPendingConnection();
    connect(socket, &QTcpSocket::readyRead, this, &Server::onReadyRead);

}
void Server::readData(QTcpSocket* socket) {
    QDataStream stream(socket);
    stream.setVersion(QDataStream::Qt_DefaultCompiledVersion);

    // Read the number of positions first, if enough bytes are available
    if (socket->bytesAvailable() >= static_cast<int>(sizeof(quint32))) {
        quint32 numPositions;
        stream >> numPositions;
        positions.clear();
        // Read all positions as long as sufficient data is available for each pair of double values
        while (socket->bytesAvailable() >= static_cast<int>(sizeof(double) * 2)) {
            double longitude, latitude;
            stream >> longitude >> latitude;
            positions.append(QPointF(longitude, latitude));
        }

        // Emit signal after all positions are read
        emit sendLongitudeAndLatitude();
    }
}


void Server::onReadyRead()
{
    _socket = dynamic_cast<QTcpSocket*>(sender());
    if(_socket){
        readData(_socket);
    }
}

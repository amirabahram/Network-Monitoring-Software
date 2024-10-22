import QtQuick 2.15
import QtPositioning 5.11
import QtLocation 5.11
import QtQuick.Controls 2.15

ApplicationWindow {
    id: appWindow
    width: 800
    height: 600
    title: "Map with Points"

    Map {
        id: map
        anchors.fill: parent
        activeMapType: map.supportedMapTypes[1]
        zoomLevel: 10
        plugin: Plugin {
            name: 'osm'
            PluginParameter {
                name: 'osm.mapping.offline.directory'
                value: ':/offline_tiles/'
            }
        }
        Repeater {
            id: pointRepeater
            model: server.getPositions ? server.getPositions.length : 0

            // onCountChanged: {
            //     console.log("Number of points painted: ", count);
            // }

            delegate: MapQuickItem {
                coordinate: QtPositioning.coordinate(server.getPositions[index].y, server.getPositions[index].x)
                onCoordinateChanged: {
                    console.log("Painting point at latitude: " + server.getPositions[index].y +
                                ", longitude: " + server.getPositions[index].x);
                }
                anchorPoint.x: icon.width / 2
                anchorPoint.y: icon.height
                sourceItem: Image {
                    id: icon
                    source: "blue_symbol.png"
                    width: 24
                    height: 24
                }
            }
        }
    }

    // Connections to the C++ server object for updating positions
    Connections {
        target: server
        function onSendLongitudeAndLatitude() {
            console.log("onSend: Updating map points");
            pointRepeater.model = server.getPositions ? server.getPositions.length : 0;

            if (server.getPositions && server.getPositions.length > 0) {
                let firstPosition = server.getPositions[0];
                let centerCoordinate = QtPositioning.coordinate(firstPosition.y, firstPosition.x);
                map.center = centerCoordinate;
            }
        }
    }
}

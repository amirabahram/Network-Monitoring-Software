import QtQuick 2.15
import QtPositioning 5.11
import QtLocation 5.11
import QtQuick.Controls 2.15

ApplicationWindow {
    id: appWindow
    width: 800
    height: 600
    title: "Map with Points"
    property  Component locationmarker: locmarker
    property var currentMarkers: []  // List to store current markers

    Map {
        id: mapview
        anchors.fill: parent
        activeMapType: mapview.supportedMapTypes[1]
        zoomLevel: 10  // Starting zoom level
        minimumZoomLevel: 2  // Minimum allowed zoom level
        maximumZoomLevel: 20  // Maximum allowed zoom level
        plugin: Plugin {
            name: 'osm'
            PluginParameter {
                name: 'osm.mapping.offline.directory'
                value: ':/offline_tiles/'
            }
        }

        Component
        {
            id:locmarker
            MapQuickItem{
                id:markerImg
                anchorPoint.x: image.width/4
                anchorPoint.y: image.height
                coordinate: position
                sourceItem: Image {
                    id: image
                    source: "qrc:/blue_symbol.png"

                    // Dynamically adjust size based on zoom level
                    width: 24 * (mapview.zoomLevel / 10)  // Adjust scaling factor as needed
                    height: 24 * (mapview.zoomLevel / 10)

                    // onStatusChanged: {
                    //     if (status == Image.Error) {
                    //         console.log("Error loading image: " + source);
                    //     } else if (status == Image.Ready) {
                    //         console.log("Image loaded successfully: " + source);
                    //     }
                    // }
                }
            }
        }
    }
    function setLocationMarker(lat,lon){
        var item = locationmarker.createObject(appWindow,{
                                                   coordinate:QtPositioning.coordinate(lat,lon)
                                               })
        mapview.addMapItem(item);
        currentMarkers.push(item);
        console.log("setLocationMarker at latitude: " + lat +
                    ", longitude: " + lon);
    }
    function clearMarkers() {
        // Loop over the current markers and remove them from the map
        for (var i = 0; i < currentMarkers.length; i++) {
            var marker = currentMarkers[i];
            mapview.removeMapItem(marker);
            marker.parent = null;
            marker.destroy();  // Destroy the marker
            console.log("Marker Destroyed");
        }
        currentMarkers = [];  // Clear the list of markers
    }
    // Connections to the C++ server object for updating positions
    Connections {
        target: server
        function onSendLongitudeAndLatitude() {
            if (server.getPositions && server.getPositions.length > 0) {
clearMarkers();
                       // Center the map on the first position
                       let firstPosition = server.getPositions[0];
                       let centerCoordinate = QtPositioning.coordinate(firstPosition.y, firstPosition.x);
                       mapview.center = centerCoordinate;

                       // Loop through the received positions and set location markers
                       for (var i = 0; i < server.getPositions.length; i++) {
                           let position = server.getPositions[i];
                           setLocationMarker(position.y, position.x); // Assuming y is latitude and x is longitude
                       }
                   }

        }
    }
}

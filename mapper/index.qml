import QtQuick 2.0

Item {
    id: mainView
    
    property string title: 'Mapper';

    property int imageFileIndex: 0

    // Default image name. Filenames should be this.png and thisn.png for normal mapped version
    property string imageFile: imageFiles[0]

    // List of all images. Add more if wanted and change current image from top-left corner
    property variant imageFiles: ["heart", "ape", "quit", "qt"]

    QtObject {
        id: settings
        property real diffuseBoost: 0.0;
        property real lightIntensity: 0.2;
        property real itemScale: 1.0;
        property bool switchX: false
        property bool switchY: false
        property bool caveMode: false
    }

    width: 1280
    height: 720

    ContentArea {
        anchors.right: parent.right
        anchors.left: panel.right
        height: parent.height
    }

    Panel {
        id: panel
    }
}

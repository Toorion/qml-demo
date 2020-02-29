import QtQuick 2.0

Item {
    id: root
    width: 300
    height: parent.height
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#c0c0c0" }
            GradientStop { position: 0.4; color: "#e0e0e0" }
            GradientStop { position: 1.0; color: "#a0a0a0" }
        }
        border.color: "#808080"
        border.width: 2
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        font.pixelSize: 12
        color:"#e0e0e0"
        text: "NMapper (c) 2012 QUIt Coding"
    }

    Column {
        width: parent.width
        y: 16
        spacing: parent.height * 0.01

        Item {
            width: parent.width - 16
            x: 8
            height: 140
            Image {
                width: parent.width * 0.48
                height: parent.height
                source: "images/image_box.png"
                Image {
                    id: image
                    anchors.fill: parent
                    anchors.margins: 4
                    fillMode: Image.PreserveAspectFit
                    source: "images/" + imageFile + ".png"
                }
                Text {
                    y: 2
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideLeft
                    text: imageFile + ".png"
                    font.pixelSize: 18
                    style: Text.Raised
                    color: "#ffffff"
                }
            }
            Image {
                width: parent.width * 0.48
                height: parent.height
                anchors.right: parent.right
                source: "images/image_box.png"
                Image {
                    id: image_normals
                    anchors.fill: parent
                    anchors.margins: 4
                    fillMode: Image.PreserveAspectFit
                    source: "images/" + imageFile + "n.png"
                }
                Text {
                    y: 2
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideLeft
                    text: imageFile + "n.png"
                    font.pixelSize: 18
                    style: Text.Raised
                    color: "#ffffff"
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    imageFileIndex++;
                    if (imageFileIndex >= imageFiles.length) imageFileIndex = 0;
                    imageFile = imageFiles[imageFileIndex];
                }
            }

        }

        Slider {
            id: lightSlider
            caption: "Light intensity"
            minimum: 0.05
            maximum: 1.0
            value: settings.lightIntensity
            onValueChanged: settings.lightIntensity = value;
        }

        Slider {
            id: diffuseSlider
            caption: "Diffuse boost"
            maximum: 4.0
            value: settings.diffuseBoost
            onValueChanged: settings.diffuseBoost = value;
        }

        Slider {
            id: scaleSlider
            caption: "Item scale"
            minimum: 0.1
            maximum: 4.0
            value: settings.itemScale
            onValueChanged: settings.itemScale = value;
        }

        Switch {
            id: xCoordSwitch
            text: "Switch x :"
            checked: settings.switchX
            onCheckedChanged: {
                settings.switchX = checked;
            }
        }

        Switch {
            id: yCoordSwitch
            text: "Switch y :"
            checked: settings.switchY
            onCheckedChanged: {
                settings.switchY = checked;
            }
        }

        Switch {
            id: caveSwitch
            text: "Cave mode :"
            checked: settings.caveMode
            onCheckedChanged: {
                settings.caveMode = checked;
            }
        }
    }

}

import QtQuick 2.0

Item {
    id: slider

    property real value: 1
    property real maximum: 1
    property real minimum: 0
    property string caption: ""
    property bool pressed: mouseArea.pressed

    width: parent.width
    height: 56

    function updatePos() {
        if (maximum > minimum) {
            var pos = (track.width - 10) * (value - minimum) / (maximum - minimum) - 5;
            return Math.min(Math.max(pos, 5), track.width - 5) - 10;
        } else {
            return 5;
        }
    }

    Text {
        id: captionText
        x: 20
        text: slider.caption + ' : ' + slider.value.toFixed(2)
        font.pixelSize: 20
        color: "#202020"
    }

    Item {
        id: track
        height: 20
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 22
        anchors.right: parent.right
        anchors.rightMargin: 22

        BorderImage {
            source: "images/slider_track.png"
            anchors.left: parent.left
            anchors.right: parent.right
            border.right: 2
        }

        BorderImage {
            id: trackFilled
            anchors.left: minimum == -maximum ? (value < 0 ? handle.horizontalCenter : parent.horizontalCenter) : parent.left
            anchors.right: minimum == -maximum && value < 0 ? parent.horizontalCenter : handle.horizontalCenter
            source: "images/slider_track_filled.png"
            border.left: 3
            border.right: 3
        }

        Image {
            id: handle
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -2
            smooth: true
            source: "images/slider_thumb.png"
            x: updatePos()
        }

        MouseArea {
            id: mouseArea
            anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter }
            height: 60
            preventStealing: true

            onPressed: {
                var handleX = Math.max(0, Math.min(mouseX, mouseArea.width))
                var realValue = (maximum - minimum) * handleX / mouseArea.width + minimum;
                value = realValue;
            }

            onPositionChanged: {
                if (pressed) {
                    var handleX = Math.max(0, Math.min(mouseX, mouseArea.width))
                    var realValue = (maximum - minimum) * handleX / mouseArea.width + minimum;
                    value = realValue;
                }
            }
        }
    }
}

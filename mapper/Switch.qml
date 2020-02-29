import QtQuick 2.0

Item {
    id: root

    property alias text: textItem.text
    property bool checked: false
    property string onText: "On"
    property string offText: "Off"

    QtObject {
        id: priv
        function releaseSwitch() {
            // Don't switch if we are in correct side
            if ((knob.x == -2 && !checked) || (knob.x == 48 && checked)) {
                return;
            }
            checked = !checked;
        }
    }

    width: parent ? parent.width : 200
    height: 50

    MouseArea {
        width: parent.width
        height: parent.height
        onClicked: {
            root.checked = !root.checked
        }
    }

    Text {
        id: textItem
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 22
        anchors.right: switchBackgroundImage.left
        elide: Text.ElideRight
        font.pixelSize: 20
        color: "#202020"
    }

    Image {
        id: switchBackgroundImage
        source: "images/switch_background.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 22
    }
    Image {
        id: switchFrameImage
        source: "images/switch_frame.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 21
        z: 10
    }

    Item {
        id: switchItem
        anchors.fill: switchBackgroundImage

        Image {
            id: switchOnImage
            anchors.right: knob.right
            anchors.rightMargin: 2
            source: "images/switch_on.png"
            opacity: knob.x / 48
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: knob.left
            anchors.rightMargin: 6
            color: "#000000"
            font.pixelSize: 18
            font.bold: true
            text: onText
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: knob.right
            anchors.leftMargin: 4
            color: "#202020"
            font.pixelSize: 18
            font.bold: true
            text: offText
        }

        Image {
            id: knob
            source: "images/switch_thumb.png"
            x: checked ? 48 : -2
            opacity: 0.4
            MouseArea {
                anchors.fill: parent
                drag.target: knob; drag.axis: Drag.XAxis; drag.minimumX: -2; drag.maximumX: 48
                onClicked: checked = !checked
                onReleased: priv.releaseSwitch();
            }
            Behavior on x {
                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
            }
        }
    }

    // Mask out switch parts which should be hidden
    ShaderEffect {
        id: shaderItem
        property variant source: ShaderEffectSource { sourceItem: switchItem; hideSource: true }
        property variant maskSource: ShaderEffectSource { sourceItem: switchBackgroundImage; hideSource: true }

        anchors.fill: switchBackgroundImage

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform sampler2D source;
            uniform sampler2D maskSource;
            void main(void) {
                gl_FragColor = texture2D(source, qt_TexCoord0.st) * (texture2D(maskSource, qt_TexCoord0.st).a) * qt_Opacity;
            }
        "
    }
}

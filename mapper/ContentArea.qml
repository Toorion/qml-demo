import QtQuick 2.0

Item {
    id: root

    Image {
        anchors.fill: parent
        source: "images/background_lab.png"
        visible: !settings.caveMode
    }

    NMapLightSource {
        id: lightSource
        z: 10
        lightIntensity: settings.lightIntensity
        // Animate pos in cave mode
        SequentialAnimation on lightTranslateX {
            running: settings.caveMode
            loops:Animation.Infinite
            NumberAnimation { to:8; duration: 200; easing.type: Easing.InOutQuad }
            NumberAnimation { to:-8; duration: 350; easing.type: Easing.OutBack }
        }
        SequentialAnimation on lightTranslateY {
            running: settings.caveMode
            loops:Animation.Infinite
            NumberAnimation { to:6; duration: 500; easing.type: Easing.InBack }
            NumberAnimation { to:-6; duration: 1200; easing.type: Easing.OutBounce }
        }
    }

    NMapEffect {
        id: caveBackground
        anchors.fill: parent
        sourceImage: "images/background_cave.png"
        normalsImage: "images/background_caven.png"
        lightSource: lightSource
        diffuseBoost: settings.diffuseBoost
        visible: settings.caveMode
    }
    NMapEffect {
        id: nMapEffect
        anchors.centerIn: parent
        sourceImage: "images/" + imageFile + ".png"
        normalsImage: "images/" + imageFile + "n.png"
        lightSource: lightSource
        diffuseBoost: settings.diffuseBoost
        switchX: settings.switchX
        switchY: settings.switchY
        width: nMapEffect.originalWidth * settings.itemScale
        height: nMapEffect.originalHeight * settings.itemScale
    }

    // NOTE: Add more NMapEffects here if wanted

    Light {
        id: light
    }

    MouseArea {
        anchors.fill: parent

        function updatePos(mouseX, mouseY) {
            lightSource.setLightPos(mouseX, mouseY);
            light.lightPosX = mouseX;
            light.lightPosY = mouseY;
        }

        onPressed: updatePos(mouseX, mouseY);
        onPositionChanged: updatePos(mouseX, mouseY);
    }
}

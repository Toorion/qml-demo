import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    id: root

    // Position of the light bulb / torch
    property real lightPosX: root.width/2
    property real lightPosY: root.height/2

    anchors.fill: parent

    Image {
        x: lightPosX - width/2
        y: lightPosY - height/2
        source: "images/light_bulb_off.png"
        visible: !settings.caveMode
        Image {
            source: "images/light_bulb_on.png"
            opacity: 0.4 + settings.lightIntensity * 0.6
        }
    }

    Image {
        x: lightPosX - width * 0.68
        y: lightPosY - height * 0.8
        source: "images/torch.png"
        visible: settings.caveMode
    }

    ParticleSystem {
        anchors.fill: parent
        visible: settings.caveMode

        Turbulence {
            id: turb
            anchors.fill: parent
            strength: 32
            NumberAnimation on strength {
                from: 16
                to: 64
                easing.type: Easing.InOutBounce
                duration: 1800
                loops: Animation.Infinite
            }
        }

        ImageParticle {
            groups: ["smoke"]
            source: "images/particle.png"
            color: "#11111111"
            colorVariation: 0
        }
        ImageParticle {
            groups: ["flame"]
            source: "images/particle.png"
            color: "#20ff800f"
            colorVariation: 0.2
        }
        Emitter {
            group: "flame"
            x: lightPosX  - 15
            y: lightPosY  - 50
            emitRate: 20 + settings.lightIntensity * 100
            lifeSpan: 500
            size: 48
            endSize: 8
            sizeVariation: 16
            acceleration: PointDirection { y: -250; yVariation: 200 }
            velocity: AngleDirection { angle: 270; magnitude: 20; angleVariation: 22; magnitudeVariation: 5 }
            enabled: settings.caveMode
        }
        TrailEmitter {
            group: "smoke"
            follow: "flame"
            emitRatePerParticle: 1
            lifeSpan: 2400
            lifeSpanVariation: 400
            size: 64
            sizeVariation: 32
            endSize: 128
            acceleration: PointDirection { y: -40 }
            velocity: AngleDirection { angle: 270; magnitude: 40; angleVariation: 22; magnitudeVariation: 5 }
        }
    }
}

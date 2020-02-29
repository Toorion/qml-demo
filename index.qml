import QtQuick 2.2
import QtQuick.Controls 2.14
import "service.js" 1.0 as Service

Rectangle {
    width: 640
    height: 480
    visible: true

    ListModel {
        id: menuModel
/*
        ListElement {
            name:'abc'
            url:'http://qml.my/3dbars'
        }
        ListElement {
            name:'efg'
            url:'http://qml.my/222'
        }
        ListElement {
            name:'xyz'
            url:'http://qml.my/333'
        }
        */
        Component.onCompleted: {
            Service.ajaxGet(tabLoader.source + 'rest', function(json) {
                const data = JSON.parse(json);
                var item;
                for(var n in data.items) {
                    item = data.items[n];
                    append({ name: item.name, url: tabLoader.source + item.url })
                }
            });
        }
    }

    ListView {
        id: list
        anchors.fill: parent
        model: menuModel
        delegate: Item {
            id:component;
            height: 72;
            width: parent.width;
//            property variant myData: model
            Rectangle {
                //color: index % 2 ? "#f0f0f0" : "#e0e0e0"
                //color: list.isCurrentItem ? "#f0f0f0" : "white"
                color: "transparent"
                width: parent.width
                height: parent.height
                Column {
                    anchors.centerIn: parent
                    Text { 
                        text: 'Name:' + name 
                        
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
//                    onClicked: list.currentIndex = index
                    onDoubleClicked: {
//                        list.currentIndex = index
                        //console.log(model.get(list.currentIndex).name + ' pushed')
                        console.log(index, menuModel.get(index).url);
                        QApi.open(menuModel.get(index).url);
                    }
                    onPositionChanged: {
                        list.currentIndex = index
                    }
                }
            }
        }
        highlight: Rectangle {
            color: "lightblue"
            z: .5
//            Text {
//                anchors.centerIn: parent
//                text: 'Hello ' + model.get(list.currentIndex).name
//                color: 'white'
//            }
        }
        focus: true
        onCurrentItemChanged: console.log(menuModel.get(list.currentIndex).name + ' selected')
    }
}

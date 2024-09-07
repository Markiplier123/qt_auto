import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
    MouseArea {
    id: root
    implicitWidth: 316 / 1.5
    implicitHeight: 604/ 1.5
    property string icon : ""
    property string title: ""
    Image {
        id: idBackgroud
        width: root.width
        height: root.height
        source: icon + "_n.png"
        fillMode: Image.PreserveAspectCrop
    }

    Text {
        id: appTitle
        anchors.horizontalCenter: parent.horizontalCenter
        y: 350/ 1.5
        text: title
        font.pixelSize: 36/ 1.5
        color: "white"
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_n.png"
            }
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased: {
        root.focus = true
        root.state = "Focus"
    }
    onContainsPressChanged: {
        idBackgroud.source = containsPress ? icon + "_p.png" : icon + "_n.png"
    }

    onFocusChanged: {
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }


    Component.onCompleted:
        console.log("create button")


}

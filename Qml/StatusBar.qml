import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.1

Item {
    width: 1280
    height: 52
    signal bntBackClicked
    property bool isShowBackBtn: false



    AppButton {

        anchors.left: parent.left
        icon: "qrc:/Img/StatusBar/btn_top_back_n.png"
        width: 135/ 2
        height: 101 /2
        z: 4

        onClicked: bntBackClicked()
        visible: isShowBackBtn
    }

    Item {
        id: clockArea
        x: 490
        width: 300 / 2
        height: parent.height

        Image {
            anchors.left: parent.left
            height: 104 / 2
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
        Text {
            id: clockTime
            text: "10:28"
            color: "white"
            font.pixelSize: 72 / 2
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104 / 2
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }
    Item {
        id: dayArea
        anchors.left: clockArea.right
        width: 300 / 2
        height: parent.height
        Text {
            id: day
            text: "Jun. 24"
            color: "white"
            font.pixelSize: 72 / 2
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
        Image {
            anchors.right: parent.right
            height: 104 / 2
            source: "qrc:/Img/StatusBar/status_divider.png"
        }
    }

    QtObject {
        id: time
        property var locale: Qt.locale()
        property date currentTime: new Date()

        Component.onCompleted: {
            clockTime.text = currentTime.toLocaleTimeString(locale, "hh:mm");
            day.text = currentTime.toLocaleDateString(locale, "MMM. dd");
        }
    }

    Timer{
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            time.currentTime = new Date()
            clockTime.text = time.currentTime.toLocaleTimeString(time.locale, "hh:mm");
            day.text = time.currentTime.toLocaleDateString(time.locale, "MMM. dd");
        }

    }

}

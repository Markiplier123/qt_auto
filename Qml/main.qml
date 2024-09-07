import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.4

ApplicationWindow {
    id:root
    width: 1280
    height: 800
    visible: true
    title: qsTr("Hello World")


    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/Img/bg_full.png"
        fillMode: Image.PreserveAspectFit
    }

    StatusBar {
        id: statusBar
         onBntBackClicked: stackView.pop()
         isShowBackBtn: stackView.depth === 1 ? false : true
    }

    StackView {
        id: stackView
        width: 1920
        anchors.top: statusBar.bottom
        initialItem: HomeWidget{}
        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -1920
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
    }


}

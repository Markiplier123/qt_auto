import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1

Item {
    id: root
    width: 1280
    height: 748
    function openApplication(url){
        parent.push(url)
    }



    ListView {
        id: lvWidget
        spacing: 7
        orientation: ListView.Horizontal
        width: 1280
        height: 380
        interactive: false


        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }


        model: DelegateModel {
            id: visualModelWidget
            model: ListModel {
                id: widgetModel
                ListElement { type: "map" }
                ListElement { type: "climate" }
                ListElement { type: "media" }
            }

            delegate: DropArea {
                id: delegateRootWidget
                width: 635 /1.5; height: 380
                keys: ["widget"]

                onEntered: {
                    visualModelWidget.items.move(drag.source.visualIndex, iconWidget.visualIndex)
                    iconWidget.item.enabled = false
                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: iconWidget; property: "visualIndex"; value: visualIndex }
                onExited: iconWidget.item.enabled = true
                onDropped: {
                    console.log(drop.source.visualIndex)
                }

                Loader {
                    id: iconWidget
                    property int visualIndex: 0
                    width: 635 /1.5; height: 380
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    sourceComponent: {
                        switch(model.type) {
                        case "map": return mapWidget
                        case "climate": return climateWidget
                        case "media": return mediaWidget
                        }
                    }

                    Drag.active: iconWidget.item.drag.active
                    Drag.keys: "widget"
                    Drag.hotSpot.x: delegateRootWidget.width/2
                    Drag.hotSpot.y: delegateRootWidget.height/2

                    states: [
                        State {
                            when: iconWidget.Drag.active
                            ParentChange {
                                target: iconWidget
                                parent: root
                            }

                            AnchorChanges {
                                target: iconWidget
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }

//                      Rectangle {
//                height : parent.height
//                color : "blue"
//                width :635 /1.5
//                opacity: .2
//                }
            }
        }

        Component {
            id: mapWidget
            MapWidget{
                 onClicked: openApplication("qrc:/App/Map/Map.qml")
            }
        }
        Component {
            id: climateWidget
            ClimateWidget {
            }
        }
        Component {
            id: mediaWidget
            MediaWidget{
                onClicked: openApplication("qrc:/App/Media/Media.qml")
            }
        }
    }



    // application button area
    ListView {
        id:listViewId
        x: 0
        y:/*570 / 1.5*/ 390
        width: 1280; height: 604 /1.5
        orientation: ListView.Horizontal
        interactive: false
        spacing: 5 /1.5

        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }


        ScrollBar.horizontal: ScrollBar {
            orientation: Qt.Horizontal
            size: listViewId.width / listViewId.contentWidth
            anchors.top: listViewId.top
            anchors.topMargin: -10
            anchors.left: listViewId.left
            visible: listViewId.count > 6
        }




        model: DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                id: delegateRoot
                width: 316 /1.5; height: 604/1.5
                keys: "AppButton"


                onEntered:{
                    console.log("DelegateModel onEntered")
                    visualModel.items.move(drag.source.visualIndex, icon.visualIndex)
                }
                onActiveFocusChanged: {
                    console.log(" DelegateModel onActiveFocusChanged")
                    app.focus = true
                    app.state = "Focus"

                }
                onExited: {
                    console.log("DelegateModel onExited")
                    listViewId.focus = true
                    appsModel.updateDataFromQML(drag.source.visualIndex, icon.visualIndex)
                }

                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: icon; property: "visualIndex"; value: visualIndex }
//                Rectangle {
//                    anchors.fill: parent
//                    color : "red"
//                    opacity: .5
//                }

                Item {
                    id: icon
                    property int visualIndex: 0
                    width: 316/1.5; height: 604/1.5


                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    AppButton{
                        id: app
                        anchors.fill: parent
                        title: model.title
                        icon: model.iconPath
                        drag.axis: Drag.XAxis
                        drag.target: app.stateDrag ? icon : undefined

                        property bool  stateDrag : false
                        property string urlAppItem: model.url

                        onClicked: openApplication(model.url)
                        onPressAndHold: {
                            console.log("AppButton onPressAndHold")
                            stateDrag = true
                        }
                        onReleased: {
                            console.log("AppButton onRelease")
                            console.log(icon.visualIndex)
                            app.focus = true
                            app.state = "Focus"
                            for (var index = 0; index < visualModel.items.count;index++){
                                if (index !== icon.visualIndex)
                                    visualModel.items.get(index).focus = false
                                else
                                    visualModel.items.get(index).focus = true
                            }
                        }




                    }

                    onFocusChanged: app.focus = icon.focus

                    Drag.active: app.drag.active
                    Drag.keys: "AppButton"
                    Drag.hotSpot.x: width /2
                    Drag.hotSpot.y: height /2

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]

                }
            }
        }

    }

}

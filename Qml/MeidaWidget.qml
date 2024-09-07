import QtQuick 2.0
import QtGraphicalEffects 1.0

MouseArea {
    id: root
    implicitWidth: 635/ 1.5
    implicitHeight: 570/ 1.5
    Rectangle {
        anchors{
            fill: parent
            margins: 10/ 1.5
        }
        opacity: 0.7
        color: "#111419"
    }
    Image {
        id: bgBlur
        x:10/ 1.5
        y:10/ 1.5
        width: 615/ 1.5
        height: 550/ 1.5
        source: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    FastBlur {
        anchors.fill: bgBlur
        source: bgBlur
        radius: 18/ 1.5
    }
    Image {
        id: idBackgroud
        source: ""
        width: root.width
        height: root.height
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40/ 1.5
        text: "USB Music"
        color: "white"
        font.pixelSize: 34/ 1.5
    }
    Image {
        id: bgInner
        x:201/ 1.5
        y:119/ 1.5
        width: 258/ 1.5
        height: 258/ 1.5
        source: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    Image{
        x:201/ 1.5
        y:119/ 1.5
        width: 258/ 1.5
        height: 258/ 1.5
        source: "qrc:/Img/HomeScreen/widget_media_album_bg.png"
    }
    Text {
        id: txtSinger
        x: 42/ 1.5
        y: (56+343)/ 1.5
        width: 551/ 1.5
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
        }
        color: "white"
        font.pixelSize: 30/ 1.5
    }
    Text {
        id: txtTitle
        x: 42/ 1.5
        y: (56+343+55)/ 1.5
        width: 551/ 1.5
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
        }
        color: "white"
        font.pixelSize: 48/ 1.5
    }
    Image{
        id: imgDuration
        x: 62/ 1.5
        y: (56+343+55+62)/ 1.5
        width: 511/ 1.5
        source: "qrc:/Img/HomeScreen/widget_media_pg_n.png"
    }
    Image{
        id: imgPosition
        x: 62/ 1.5
        y: (56+343+55+62)/ 1.5
        width: 0
        source: "qrc:/Img/HomeScreen/widget_media_pg_s.png"
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: ""
            }
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased:{
        root.focus = true
        root.state = "Focus"
    }
    onFocusChanged: {
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }

    Connections{
        target: player.playlist
        onCurrentIndexChanged:{
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex) {
                bgBlur.source = myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
                bgInner.source = myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
                txtSinger.text = myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
                txtTitle.text = myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
            }
        }
    }

    Connections{
        target: player
        onDurationChanged:{
            imgDuration.width = 511/ 1.5
        }
        onPositionChanged: {
            imgPosition.width = (player.position / player.duration)*(511)/ 1.5;
        }
    }
}

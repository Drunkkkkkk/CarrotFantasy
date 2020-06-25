import QtQuick 2.0


Rectangle{
    width: 25
    height: 25
    signal click();

    anchors.right: parent.gameWindowAnchorItem.right
    anchors.top: parent.gameWindowAnchorItem.top
    anchors.rightMargin: 10
    anchors.topMargin: 10
    color: "#00000000"
    Image {
        anchors.fill: parent
        source: "../../assets/gameScene/Back.png"
    }
    MouseArea{
        anchors.fill: parent
        onClicked: click();
    }
}

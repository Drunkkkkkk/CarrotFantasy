import QtQuick 2.0

Rectangle{
    property alias upSource: up.source
    property alias downSource: dowm.source
    color: "#00000000"
    width: up.width
    height: up.height

    signal click();
    Image{
        id: up
        visible: true;
    }
    Image {
        id: dowm
        visible: false;
    }
    MouseArea{
        anchors.fill: parent
        onClicked: click();

        onPressed: {
            up.visible = false
            dowm.visible = true
        }
        onReleased: {
            up.visible = true
            dowm.visible = false
        }
    }
}

import QtQuick 2.0

Image {
    id: cannon
    width: parent.width/2;
    height: parent.height/2

    signal click();

    property string enSourse;
    property string unSourse;
    property bool enable: true
    property int dividing: -100000//设一个小的值，保持enable

    state: "enable"
    states: [
        State{
            name: "enable"
            when: gameScene.gold >= dividing
            PropertyChanges { id: _1; target: cannon; source :enSourse}
        },
        State{
            name: "nuenable"
            when: gameScene.gold < dividing
            PropertyChanges { id: _2; target: cannon; source :unSourse }
        }
    ]
    MouseArea{
        anchors.fill: parent
        onClicked: {
            if(cannon.state === "enable") click();
        }
    }
}

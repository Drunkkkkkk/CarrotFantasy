import QtQuick 2.0
import Felgo 3.0

Rectangle{
    property int type;

    signal builtBotang(int dx, int dy);

    width: 32
    height: 32
    color: "#00000000"
    TexturePackerAnimatedSprite{
        id: img
        anchors.fill: parent
        source: "../../assets/routes/route.json"
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            if(type === 20){
                builtBotang(parent.x, parent.y)
            }

        }
    }

    Component.onCompleted: {
        if(type <= 10 && type >= 1)
            img.frameNames = "route"+ boxType +".png";
        else if(type === 20){
            img.frameNames = ["blank1.png", "blank2.png"]
            img.frameRate = 5
        }
    }
}

//creatEntit()

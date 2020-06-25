import Felgo 3.0
import QtQuick 2.0

import "../common"

SceneItem{
    property bool run: parent.activeScene === menuScene
    property bool isplayBg: mouse.play
    signal startGame();

    //background
    Image {
        anchors.fill: parent.gameWindowAnchorItem
        smooth: true
        source: "../../assets/mainInterface/background.png"
    }
    Image {
        x: 186
        y: 80
        z: 3
        smooth: true
        source: "../../assets/mainInterface/radishBody.png"
    }
    Image {
        id: leaf1
        x: 175
        y: 32
        smooth: true
        source: "../../assets/mainInterface/radishLeaf1.png"
        transformOrigin: Item.BottomRight

        SequentialAnimation{
            id:anim1
            loops: 2
            RotationAnimation{
                target: leaf1
                to: -15;
                duration: 1000
                direction: RotationAnimation.Counterclockwise
            }
            RotationAnimation{
                target: leaf1
                to: 0;
                duration: 500
            }
        }
    }
    Image {
        id: leaf2
        x: 214
        y: 6
        z: 2
        smooth: true
        source: "../../assets/mainInterface/radishLeaf2.png"
        transformOrigin: Item.Bottom
        SequentialAnimation{
            id:anim2
            loops: 2
            RotationAnimation{
                target: leaf2
                to: -15;
                duration: 300
                direction: RotationAnimation.Counterclockwise
            }
            RotationAnimation{
                target: leaf2
                to: 15;
                duration: 700
            }
            RotationAnimation{
                target: leaf2
                to: 0;
                duration: 400
            }
        }
    }
    Image {
        id: leaf3
        x: 266
        y: 29
        smooth: true
        source: "../../assets/mainInterface/radishLeaf3.png"
        transformOrigin: Item.BottomLeft

        SequentialAnimation{
            id:anim3
            loops: 2
            RotationAnimation{
                target: leaf3
                to: 15;
                duration: 350
            }
            RotationAnimation{
                target: leaf3
                to: 0;
                duration: 300
            }
        }
    }
    Image {
        x:106
        y:97
        smooth: true
        z:4
        source: "../../assets/mainInterface/title.png"
    }

    MyButton{
        x:166
        y:264
        scale: 0.7
        upSource: "../../assets/mainInterface/startButton.png"
        downSource: "../../assets/mainInterface/startButton_down.png"
        onClick: {
            console.log("start")
            seleWav.play()
            startGame();
        }
    }
    Rectangle{
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 10
        width: soundBgm.width
        height: soundBgm.height
        color: "#00000000"
        Image{
            width: 50;
            height: 24
            id: soundBgm
            source: "../../assets/mainInterface/soundfx_on_CN.png"
        }
        MouseArea{
            id: mouse
            property bool play: true
            anchors.fill: parent
            onClicked: {
                if(play = !play){
                    soundBgm.source = "../../assets/mainInterface/soundfx_on_CN.png"
                    bgMusic.play()
                }
                else
                {
                    soundBgm.source = "../../assets/mainInterface/soundfx_off_CN.png"
                    bgMusic.stop()
                }
            }
        }
    }
    
    TexturePackerAnimatedSprite {
        id: nailgunSprite
        source: "../../assets/mainInterface/huowu.json"
        frameNames: ["huowu1.png","huowu2.png"]
        frameRate: 2
        scale: 0.8
        x: 50;
        y: 20
        MouseArea{
            anchors.fill: parent
            onClicked: SequentialAnimation{
                id:huowuAnim
                loops: Animation.Infinite
                PropertyAnimation{
                    target: nailgunSprite
                    property: "y"
                    to: 60;
                    duration: 5000
                }
                PropertyAnimation{
                    target: nailgunSprite
                    property: "y"
                    to: 20;
                    duration: 5000
                }
            }
        }
    }

    Timer{
        id: timer
        repeat: true;
        interval: 3500
        running: gameWindow.activeScene === menuScene
        onTriggered:{
            var ind = parseInt(Math.random()*3);
            switch(ind){
            case 0:
                anim1.start()
                break;
            case 1:
                anim2.start()
                break;
            case 2:
                anim3.start()
                break;
            }
        }
        onRunningChanged: {
            if(running)
                huowuAnim.start()
        }
    }

    onBackButtonPressed: Qt.quit();
}

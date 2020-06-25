import QtQuick 2.0
import Felgo 3.0

EntityBase{
    id: master
    entityType: "monster"

    width: 32
    height: 32;

    property alias frameNames: nailgunSprite.frameNames
    property alias path: pathAnim.path //路线
    property int lv//等级
    property int blood;
    property int fullblood;

    onEntityCreated: {
        fullblood = blood = blood + lv * 10
        bloobRect.visible = false;
    }

    TexturePackerAnimatedSprite {
        id: nailgunSprite
        source: "../../../assets/gameScene/monster_all.json"
        anchors.fill: collider
        frameRate: 2
    }
    Rectangle{
        id: bloobRect
        width: 34;
        height: 8
        visible: false
        Image {
            id: bloodImg
            anchors.fill: parent
            source: "../../../assets/gameScene/blood.png"
        }
        Image {
            width: 31 * (1-blood/fullblood)
            height: 5
            anchors.top: bloobRect.top
            anchors.right: bloobRect.right
            anchors.topMargin: 1
            anchors.rightMargin: 1
            source: "../../../assets/gameScene/blood_n.png"
        }
    }
    Timer{
        id: bloodChangeTimer
        interval: 2000;
        onTriggered: {
            bloobRect.visible = false;
        }
    }

    BoxCollider {
        id: collider

        categories: Box.Category1
//        collidesWith: Box.Category2
        collisionTestingOnlyMode: true
    }

    onBloodChanged: {
        if(blood <= 0){
            gameScene.gold += 14
            gameScene.score++;
            gameScene.dealMonsetNum++
            gameScene.mDeathMp3.play()
            master.removeEntity();
        }
        bloodChangeTimer.running = true;
        bloobRect.visible = true;
    }

    PathAnimation{
        id:pathAnim
        target: master
        anchorPoint: getAnchorPoint()
        duration: 35 * 1000

        onStopped:{
            master.removeEntity();
            gameScene.health--;
            gameScene.dealMonsetNum++
            gameScene.mSurviveMp3.play()
        }
    }

    function beHurt(hurt){
        blood -= hurt
    }

    function getAnchorPoint(){
        return String(master.width/2 + "," + master.height/2);
    }

    Component.onCompleted: {
        pathAnim.start()
    }
}

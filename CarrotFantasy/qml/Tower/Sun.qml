import Felgo 3.0
import QtQuick 2.0

import "../common"

//太阳是范围攻击类，暂时没有实现基类

EntityBase{
    id: sun
    entityType: "range"

    property real colliderRadius: 50
    property int damage: 30
    property int spead: 700

    Sunsprite{
        id:sunSprite
    }
    MouseArea{
        x:-19;y:-19
        width: 38;height: 38
        anchors.centerIn: parent
        onClicked: {
            sunTopLv.open()
            attRadius.visible = true;
        }
    }

    Timer {
        id: shootTimer
        interval: spead
        repeat: true
        triggeredOnStart: true //启动时立即触发计时器
        onTriggered:  findScopeEntries()
    }

    CircleCollider{
        id: collider
        radius: colliderRadius
        x:-colliderRadius
        y:-colliderRadius

        categories: Box.Category2
        collidesWith: Box.Category1

        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            shootTimer.running = true;
        }
    }

    SoundEffect {
        id: sunShoot
        source: "../../assets/music/Sun.wav"
    }

    function findScopeEntries(){
        var entries = entityManager.getEntityArrayByType("monster")
        if(entries.length <= 0)
            shootTimer.running = false

        for(var i=0; i<entries.length; i++){

            var dx = entries[i].x+16;
            var dy = entries[i].y+16;

            if(Math.abs(x-dx) > colliderRadius || Math.abs(y-dy) > colliderRadius){
                continue;
            }
            else{
                var r2 = Math.pow(x-dx,2) + Math.pow(y-dy,2)
                if(r2 < 48*48){
                    sunSprite.playShootAnimation();
                    sunShoot.play()
                    entries[i].beHurt(damage)
                }
            }
        }
    }



    Rectangle{//攻击半径显示
        id: attRadius;
        anchors.centerIn: parent
        color: "black"
        opacity: 0.35
        width: colliderRadius*2
        height: colliderRadius*2
        radius: colliderRadius
        visible: false
    }
    MenuBu{
        id:sunTopLv
        anchors.centerIn: parent
        enSourse1: "../../assets/botany/upgrade_0.png"
        enSourse2: "../../assets/botany/sell_128.png"
        unSourse2: "../../assets/botany/sell_128.png"
        dividing2: 128
        rotation: -parent.rotation
        onClickBu1: {
            attRadius.visible = false
        }
        onClickBu2: {
            gameScene.gold += dividing2;
            removeEntity();
        }
        onCancel: {
            attRadius.visible = false
        }
    }
}

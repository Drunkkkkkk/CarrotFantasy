import QtQuick 2.0
import Felgo 3.0

import "../common"

TowerBase{
    id:peashooter
    //为单体攻击
    entityType: "single"

    property int damage: 30 //子弹伤害，shoot()里面设置伤害
    property int spead: 500//速率

    property int lv: 1

    MouseArea{
        width: 38;height: 38
        anchors.centerIn: parent
        onClicked: {
            attRadius.x = parent.x;
            attRadius.y = parent.y;
            attRadius.visible = true
            if(lv === 1) peaUpBu.open()
            else peaTopLv.open()
        }
    }

    PeaSprite {
        id: sprite
        anchors.fill: parent
    }

    SoundEffect {
        id: peashShoot
        source: "../../assets/music/Bottle.wav"
    }

    Timer {
        id: shootTimer
        interval: spead
        repeat: true
        triggeredOnStart: true //启动时立即触发计时器
        onTriggered: {
            shoot();
        }
    }

    onAimingAtTargetChanged: {
        if(aimingAtTarget && !shootTimer.running) {
            shootTimer.running = true;
        }
    }
    onTargetRemoved: {
        shootTimer.running = false;
    }
    onEntityDestroyed: {
        shootTimer.running = false;
    }
    function shoot() {
        if(!targetEntity) {
            shootTimer.running = false;
            return;
        }
        sprite.playShootAnimation();
        targetEntity.beHurt(damage);
        peashShoot.play()
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
        id : peaUpBu
        anchors.centerIn: parent
        enSourse1: "../../assets/botany/upgrade_180.png"
        unSourse1:"../../assets/botany/upgrade_-180.png.png"
        enSourse2:"../../assets/botany/sell_80.png"
        unSourse2:"../../assets/botany/sell_80.png"
        dividing1: 180
        dividing2: 80
        rotation: -parent.rotation
        onClickBu1: {
            sprite.gunScouce = "../../assets/Tower/gun2.png"
            attRadius.visible = false
            damage = 40
            spead = 300;
            lv++;
            gameScene.gold -= dividing1;
        }
        onClickBu2: {
            gameScene.gold += dividing2;
            removeEntity();
        }
        onCancel: {
            attRadius.visible = false
        }
    }
    MenuBu{
        id:peaTopLv
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

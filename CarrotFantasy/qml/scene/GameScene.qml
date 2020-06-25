import Felgo 3.0
import QtQuick 2.0

import "../common"
import "../Level"
import "../entries"
import "../Tower"

SceneItem{
    id: gameScene

    property alias mDeathMp3: mDeathMp3
    property alias mSurviveMp3: mSurviveMp3

    property int wareNum//当前地几波兵
    property int currentMonsterNum//当前关卡生成怪物数量
    property int dealMonsetNum//当前关卡生成怪物数量
    property bool wareStart//开始生成小怪

    property int level;
    property int health//生命值
    property int gold//金币
    property int score: 0

    signal gamePass();//游戏全通过
    signal gameOver();//游戏失败

    BackgroundMusic{
        id: gameBackMuic
        source: "../../assets/music/BGgame.mp3"
        autoPlay : false
    }
    BackgroundImage{
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/gameScene/gameBg.png"
    }

    Image {
        id : topItem
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: -10
        source: "../../assets/gameScene/head.png"
        scale: 0.7
        Text {
            id: goldText
            x : 50
            width: 65
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 10
            text: gold
            color: "white"
        }
        Image{
            id:luobImage
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 50
            anchors.left: goldText.right
            scale: parent.height / height
            source: "../../assets/gameScene/luob.png"
        }
        Text {
            id: healthText
            anchors.left: luobImage.right
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 10
            width: 25
            anchors.leftMargin: 5
            color: "white"
            text: health
        }
        Text {
            id: passText
            anchors.left: healthText.right
            anchors.leftMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 10
            color: "yellow"
            text: (wareNum+1) + "/"+ loader.item.master.length + "波"
        }
        Image {
            id: backImg
            anchors.left: healthText.right

            anchors.leftMargin: 86
            anchors.verticalCenter: parent.verticalCenter
            scale: 0.1
            source: "../../assets/gameScene/Back.png"
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    gameWindow.state = "selectLevel"
                    back()
                    seleWav.play()
                }
            }
        }
    }

    Rectangle{
        id: ready
        anchors.fill: parent.gameWindowAnchorItem
        color: "#00000000"
        z : 100
        Image {
            id :img
            property int imageType: 0
            anchors.centerIn: parent
            source: "../../assets/gameScene/go.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                ready.visible = false
                if(img.imageType === 0)
                    wareStart = true
                else{
                    gameWindow.state = "selectLevel"
                    back()
                }

            }
        }
    }

    Grid{
        id:grid
        columns: 12
        rows: 7
        anchors.centerIn: parent
        Repeater {
            id:latticeView
            Lattice{
                type: boxType
                onBuiltBotang: {
                    selectBotany.x = dx + grid.x - 9
                    selectBotany.y = dy + grid.y - 9
                    selectBotany.open()
                    seleWav.play()
                }
            }
        }
    }
    Loader{
        id:loader
        onLoaded: {
            latticeView.model = item.boxModel
        }
    }

    Timer{//控制怪物生成
        id:timer1
        interval:1500
        running: wareStart
        repeat: true
        onTriggered: {
            if(currentMonsterNum < loader.item.master[wareNum][1]){
                creatEntity(loader.item.master[wareNum][0])
                currentMonsterNum++;
            }
            else {
                wareStart = false
                timer2.running = true
                currentMonsterNum = 0   //当前怪物清0
            };
        }
    }
    Timer{//控制没波怪物开始
        id:timer2
        interval:15000
        onTriggered: {
            if(wareNum+1 < loader.item.master.length){
                wareNum++
                wareStart = true
            }
        }
    }

    SoundEffect {
        id: mDeathMp3
        source: "../../assets/music/monster.wav"
    }
    SoundEffect {
        id: mSurviveMp3
        source: "../../assets/music/carrot.wav"
    }

    onBackButtonPressed: {
        gameWindow.state = "selectLevel"
        back()
        seleWav.play()
    }

    onScoreChanged: {
        if(score - health + 10 >= loader.item.monsterNum)
            gamePass();
    }
    onHealthChanged: {
        if(health <= 0) gameOver();
    }
    onGameOver: {
        currentMonsterNum = 100;//
        wareStart = false;//停止生成怪物

        img.source = "../../assets/gameScene/gameOver.png"
        ready.visible = true
        img.imageType = 1;
    }
    onGamePass: {
        recordScore();
        img.source = "../../assets/gameScene/pass.png"
        if(level <  5)  selectLevelScene.passModel.setProperty(level+1, "pass", 1)
        ready.visible = true
        img.imageType = 1;
    }
    onDealMonsetNumChanged: {
        if(dealMonsetNum >= loader.item.monsterNum)
            gamePass();
    }

    function back(){
        //销毁所有实体
        entityManager.removeAllEntities();
        img.source        = "../../assets/gameScene/go.png"
        loader.source     = "";
        wareStart         = false
        ready.visible     = true
        selectBotany.close()
        if(menuScene.isplayBg) bgMusic.play()
        gameBackMuic.stop()
    }
    function creatEntity(type){
        var newProperty = {
            x: loader.item.posXY[0]*32 + grid.x,
            y: loader.item.posXY[1]*32 + grid.y,
            lv : wareNum,
            path: loader.item.path,
        }
        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../entries/monster/" + type), newProperty);
    }
    function init(levelUrl, lev){
        //加载关卡信息
        gameBackMuic.play()
        loader.source     = levelUrl;
        level             = lev;
        //初始游戏数据
        img.imageType     = 0;
        health            = 10;
        gold              = 550
        currentMonsterNum = 0;
        score             = 0;
        wareStart         = false;
        wareNum           = 0;
        dealMonsetNum     = 0;
        entityManager.removeAllEntities();
    }
    function recordScore(){
        var grade = score*10 + health*100;
        if(grade > rankScene.rankGrade.get(level).grade)
            rankScene.rankGrade.setProperty(level, "grade", grade)
    }

    MenuBu{
        id: selectBotany
        enSourse1: "../../assets/botany/cannon.png"
        unSourse1:"../../assets/botany/cannon_no.png"
        enSourse2:"../../assets/botany/sun.png"
        unSourse2:"../../assets/botany/sun_no.png"
        dividing1: 100
        dividing2: 180

        onClickBu1: {
            var newProperty = {
                x: selectBotany.x + 25,
                y: selectBotany.y + 25
            }
            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("../Tower/PeaShooter.qml"), newProperty);
            gold -= dividing1;
        }
        onClickBu2: {
            var newProperty = {
                x: selectBotany.x + 25,
                y: selectBotany.y + 25
            }
            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("../Tower/Sun.qml"), newProperty);
            gold -= 180;
        }
    }
}

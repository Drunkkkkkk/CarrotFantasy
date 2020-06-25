import Felgo 3.0
import QtQuick 2.0

//import an.qt.jsonIO 1.0
import "../common"

SceneItem {
    id: selectLevelScene

    property alias passModel: passModel
    signal levelPressed(string selectedLevel, int level)
    signal openRank();

    BackgroundImage{
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/rank/selectBg.png"
    }

    BackButton{
        onClick: {
            gameWindow.state = "menu"
            seleWav.play()
        }
    }

    MyButton{
        anchors.bottom: parent.bottom
        anchors.right : parent.horizontalCenter
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        scale: 0.8
        upSource: "../../assets/rank/rank.png"
        downSource: "../../assets/rank/rand_down.png"
        onClick:{
            openRank()
            seleWav.play()
        }
    }
    MyButton{
        anchors.bottom: parent.bottom
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        scale: 0.8
        upSource: "../../assets/rank/save.png"
        downSource: "../../assets/rank/save_down.png"
        onClick: {
            saveGameDate()
            seleWav.play()
        }
    }

    Grid {
        anchors.centerIn: parent
        spacing: 10
        columns: 5

        Repeater{
            model: passModel
            delegate: component
        }
        Repeater{
            model: 10
            delegate: componentNull
        }
    }

    Component{
        id:component;
        Rectangle{
            width: 50
            height: 50
            color: "#00000000"
            BackgroundImage{
                anchors.fill: parent
                source: "../../assets/rank/selectBox.png"
            }
            Text {
                font.bold: true
                font.pointSize: 8
                anchors.centerIn: parent
                text: index+1
                color: "#b51a1a"
            }
            Rectangle{
                id : enRect
                visible: pass !== 1
                anchors.fill: parent
                radius: 8
                color: "#6b6060"
                opacity: 0.5
            }

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if(!enRect.visible){
                        levelPressed("../Level/Lavel_"+ (index+1) +".qml",index)
                        seleWav.play()
                    }
                }
            }
        }
    }
    Component{
        id:componentNull;
        Image {
            width: 50
            height: 50
            id: name
            source: "../../assets/rank/selectBox.png"
            Rectangle{
                id : enRect
                anchors.fill: parent
                radius: 8
                color: "#6b6060"
                opacity: 0.5
            }
        }
    }

    ListModel{
        id: passModel
        ListElement{ pass : 1}
        ListElement{ pass : 0}
        ListElement{ pass : 0}
        ListElement{ pass : 0}
        ListElement{ pass : 0}
    }

    Component.onCompleted: {
        var arr = dataio.readJson("pass")
        for(var i=0; i<arr.length; i++){
            passModel.setProperty(i, "pass", arr[i]);
        }
    }

    function saveGameDate(){
        var arrP = new Array
        for(var i=0; i<passModel.count; i++)
            arrP.push(passModel.get(i).pass)
        var arrG = new Array
        for(var i=0; i<rankScene.rankGrade.count; i++)
            arrG.push(rankScene.rankGrade.get(i).grade)
        dataio.writeJson(arrP, arrG)
    }

    onBackButtonPressed: {
        gameWindow.state = "menu"
        saveGameDate()
    }

}

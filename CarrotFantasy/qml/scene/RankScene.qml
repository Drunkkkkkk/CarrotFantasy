import Felgo 3.0
import QtQuick 2.0

import "../common"

SceneItem{
    id : rankScene
    property var rankGrade: rankModel

    BackgroundImage{
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/rank/rankBg.jpg"
    }
    Image {
        anchors.fill: parent
        source: "../../assets/rank/banzi.png"
    }
    BackButton{
        onClick: {
            gameWindow.state = "selectLevel"
            seleWav.play()
        }
    }

    ListView{
        id:list
        height: 200
        x: 120; y: 70
        model: rankModel
        delegate: Row{
            Text {
                width: 100
                font.pointSize: 8
                text: qsTr(setPassName(index))
                color: "#cfa91f"
            }
            Text {
                font.pointSize: 8
                width: 50
            }
            Text {
                font.pointSize: 8
                text: qsTr(setGrade(grade))
                color: "#605454"
            }
        }
    }
    ListModel{
        id:rankModel
        ListElement{ grade: 0 }
        ListElement{ grade: 0 }
        ListElement{ grade: 0 }
        ListElement{ grade: 0 }
        ListElement{ grade: 0 }
    }

    onBackButtonPressed: gameWindow.state = "selectLevel";

    Component.onCompleted: {
        var arr = dataio.readJson("grade")
        for(var i=0; i<arr.length; i++){
            rankModel.setProperty(i, "grade", arr[i]);
        }
    }
    function setGrade(grade){
        return (grade===0)? "no grade" : grade + " grade"
    }
    function setPassName(index){
        switch(index){
        case 0: return "First pass";
        case 1: return "Second Pass";
        case 2: return "Third Pass";
        case 3: return "Fourth Pass";
        case 4: return "Fifth Pass";
        }
    }
}

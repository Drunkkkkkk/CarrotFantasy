import QtQuick 2.0

Item {

    property alias boxModel: model
    property alias path: path
    property int boxWidt: 32//每格宽度

    property var posXY: [0,0]//*32
    property int monsterNum: 40
    property var map: [//7 * 12
        [4,10,10,10,10,10,10, 7, 0, 0, 0, 0],//0
        [0,20, 0, 0, 0, 0,20, 5, 0, 0, 0, 0],//1
        [9,10,10,10,10,10,10, 1, 0, 0, 0, 0],//2
        [5,20, 0, 0,20, 0, 0,20, 0, 0, 0, 0],//3
        [3,10,10,10,10,10, 7, 0, 0, 0, 0, 0],//4
        [0, 0, 0,20, 0,20, 5, 0, 0, 0, 0, 0],//5
        [0, 4,10,10,10,10, 1,20, 0, 0, 0, 0]//6
    ]
    //8426上下左右;7913四个拐角，10,5横竖,炮塔位置：20
    //空0
    property var master: [//每波怪物类型和数量
        ["MBig_oldboss.qml",10],
        ["MFly_boss_yellow.qml",10],
        ["MFly_yellow.qml",10],
        ["MLand_boss_star.qml",10]
    ]

    ListModel{
        id:model //Type:value
    }

    Path{
        id:path
        PathLine{
            relativeX:boxWidt*7
            relativeY:0
        }
        PathLine{
            relativeX:0
            relativeY:boxWidt*2
        }
        PathLine{
            relativeX:-boxWidt*7
            relativeY:0
        }
        PathLine{
            relativeX:0
            relativeY:boxWidt*2
        }
        PathLine{
            relativeX:boxWidt*6
            relativeY:0
        }
        PathLine{
            relativeX:0
            relativeY:boxWidt*2
        }
        PathLine{
            relativeX:-boxWidt*5
            relativeY:0;
        }
    }

    Component.onCompleted: {
        for(var i=0; i<7; i++){
            for(var j=0; j<12; j++){
                model.append({"boxType": map[i][j]})
            }
        }
    }
    function setStartPos(x,y){
        path.startX = x;
        path.startY = y;
    }
}

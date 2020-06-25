import QtQuick 2.0

Item {

    property alias boxModel: model
    property alias path: path
    property int boxWidt: 32//每格宽度

    property var posXY: [0,5]//*32
    property int monsterNum: 76
    property var map: [//7 * 12
        [9, 10,10,10,10,7, 0, 0, 9,10,10, 7],//0
        [5,20, 0, 0,20, 5, 0, 0, 5,20, 0, 5],//1
        [5, 9,10,10,10, 1, 0, 0, 5, 0,20, 5],//2
        [5, 5,20, 0, 0,20, 0,20, 5, 0, 0, 5],//3
        [5, 3,10,10,10,10,10,10, 1, 0, 0, 5],//4
        [2,20, 0, 0, 0,20, 0, 0,20, 0,20, 5],//5
        [0, 0, 0, 0, 4,10,10,10,10,10,10, 1]//6
    ]
    //路径元素  8426上下左右;7913四个拐角，10,5横竖
    //可装炮塔位置：20
    //空：，0
    property var master: [//每波怪物数量和类型
        ["MBig_oldboss.qml",12],
        ["MFly_yellow.qml",12],
        ["MFly_boss_yellow.qml",12],
        ["MLand_boss_star.qml",12],
        ["MBig_oldboss.qml",14],
        ["MFly_boss_yellow.qml",14],
    ]

    ListModel{
        id:model //Type:value
    }

    Path{
        id:path
        //0,0
        PathLine{
            relativeX:0
            relativeY:-boxWidt*5
        }
        PathLine{
            relativeX:boxWidt*5
            relativeY:0
        }
        PathLine{
            relativeX:0
            relativeY:boxWidt*2
        }
        PathLine{
            relativeX:-boxWidt*4
            relativeY:0
        }
        PathLine{
            relativeX:0
            relativeY:boxWidt*2
        }
        PathLine{
            relativeX:boxWidt*7
            relativeY:0
        }
        PathLine{
            relativeX:0
            relativeY:-boxWidt*4
        }
        PathLine{
            relativeX:boxWidt*3
            relativeY:0;
        }
        PathLine{
            relativeX:0
            relativeY:boxWidt*6
        }
        PathLine{
            relativeX:-boxWidt*7
            relativeY:0
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



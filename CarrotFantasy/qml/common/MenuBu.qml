import QtQuick 2.0

//游戏中的选择菜单
Rectangle{
    id: root
    color: "#00000000"
    visible: false;
    width: 50;
    height: 50;

    property alias enSourse1: button1.enSourse
    property alias unSourse1: button1.unSourse
    property alias enSourse2: button2.enSourse
    property alias unSourse2: button2.unSourse
    property alias dividing1: button1.dividing
    property alias dividing2: button2.dividing

    signal clickBu1();
    signal clickBu2();
    signal cancel();

    GameButton{
        id:button1
        onClick: {
            close()
            seleWav.play()
            clickBu1();
        }
    }
    GameButton{
        id:button2
        anchors.left: button1.left
        anchors.top: button1.bottom
        onClick:{
            close()
            seleWav.play()
            clickBu2();
        }
    }
    GameButton{
        anchors.left: button1.right
        anchors.verticalCenter: button1.bottom
        enSourse: "../../assets/botany/chacha.png"
        onClick: {
            close()
            seleWav.play()
            cancel()
        }
    }

    function open(){
        root.visible = true;
    }
    function close(){
        root.visible = false;
    }
}

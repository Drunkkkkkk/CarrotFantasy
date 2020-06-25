import Felgo 3.0
import QtQuick 2.0

Item {
    id:sunSprit
    property alias running : sunTPSprite.running

    MultiResolutionImage {
        width: 32;height: 32
        source: "../../assets/Tower/sun.png"
        anchors.centerIn: parent
    }

    TexturePackerAnimatedSprite
    {
        id:sunTPSprite
        running: false

        loops: 1
        anchors.centerIn: parent

        source: "../../assets/Tower/sunshoot.json"
        frameNames: ["0.png","1.png", "2.png", "3.png", "4.png", "5.png","6.png"]
        frameRate: 15
    }

    function playShootAnimation() {
        sunTPSprite.running=true
    }
}

import QtQuick 2.0
import Felgo 3.0

Item {
    id: towerBaseSprite
    //抵消角度
    property int rotationOffset: 90

    //parent:gun 设置枪管与旋转线对其，底座不旋转
    rotation: -parent.rotation+rotationOffset

    //外部设置枪管的类型
    property string spriteSheetSource

    //底座的图片
    MultiResolutionImage {
        source: towerBaseSprite.spriteSheetSource
        anchors.centerIn: parent
    }
}

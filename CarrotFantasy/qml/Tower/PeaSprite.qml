import QtQuick 2.0
import Felgo 3.0

TowerBaseSprite {
  id: peasprite

  spriteSheetSource: "../../assets/Tower/gunbase.png"
  property alias running: spritesequence.running
  property alias gunScouce: spritesequence.defaultSource

  SpriteSequence {
      id: spritesequence
      rotation: peasprite.parent.rotation

      anchors.centerIn: parent
      defaultSource: "../../assets/Tower/gun.png"


      Sprite {
          name: "ready"
          frameWidth: 32
          frameHeight: 32

          startFrameColumn: 1
          frameDuration: 100000
      }

      Sprite {
          name: "shoot"
          frameWidth: 32
          frameHeight: 32

          frameCount: 4
          startFrameColumn: 1
          frameRate: 16
          to: {"ready": 1}
      }
  }

  function playShootAnimation() {
    spritesequence.jumpTo("shoot");
  }
}

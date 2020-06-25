import Felgo 3.0
import QtQuick 2.0
import an.qt.jsonIO 1.0

import "scene"

GameWindow {
    id: gameWindow
    landscape:true

    screenWidth: 960
    screenHeight: 640

    EntityManager {
      id: entityManager
      entityContainer: gameScene
    }
    BackgroundMusic{
        id:bgMusic
        volume: 0.8
        source: "../assets/music/BGMusic.mp3"
    }
    SoundEffect {
        id: seleWav
        volume: 1.5
        source: "../assets/music/Select.wav"
    }

    MenuScene{
        id:menuScene
        onStartGame: {
            gameWindow.state = "selectLevel"
        }
    }
    GameScene{
        id:gameScene
        PhysicsWorld{
            debugDrawVisible : false
        }
    }
    SelectLevelScene{
        id: selectLevelScene
        onLevelPressed: {
            gameScene.init(selectedLevel, level);
            bgMusic.pause()
            timer.running = true
        }
        onOpenRank: {
            gameWindow.state = "rank";
        }
    }
    RankScene{
        id: rankScene
    }

    state: "menu"
    activeScene: menuScene

    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: menuScene}
        },
        State {
            name: "selectLevel"
            PropertyChanges {target: selectLevelScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: selectLevelScene}
        },
        State {
            name: "rank"
            PropertyChanges {target: rankScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: rankScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: gameScene}
        }
    ]

    GameDataIO{
        id: dataio
        fileName: "./gameData.json"
    }
    Timer{
        id: timer
        interval: 500
        onTriggered: gameWindow.state = "game";
    }
}

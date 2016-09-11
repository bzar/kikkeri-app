import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

import "config.js" as Config

ApplicationWindow {
  id: window
  visible: true
  width: 800
  height: 480
  title: qsTr("Kikkeri")

  property color goforeOrange: "#FF8551"
  property color goforeBlue: "#343F68"

  Material.theme: Material.Dark
  Material.accent: goforeOrange
  Material.background: goforeBlue

  Shortcut {
    sequence: "Ctrl+M"
    onActivated: window.close()
  }

  KikkeriClient {
    id: client
    siteUrl: Config.SITE_URL
    onError: console.log("ERROR " + code + ": " + cause)

    Timer {
      interval: 1000*60*5
      running: true
      triggeredOnStart: true
      repeat: true
      onTriggered: {
        client.updateLatestGames()
      }
    }
    Timer {
      interval: 1000*60*60*24
      running: true
      triggeredOnStart: true
      repeat: true
      onTriggered: {
        client.updatePlayers()
        client.updateTags()
      }
    }
  }

  SwipeView {
    id: swipeView
    anchors.fill: parent
    currentIndex: tabBar.currentIndex

    RecordPage {

    }

    BrowsePage {
    }
  }

  footer: TabBar {
    id: tabBar
    currentIndex: swipeView.currentIndex
    TabButton {
      text: qsTr("Kirjaa")
    }
    TabButton {
      text: qsTr("Selaa")
    }
  }

  Timer {
    id: backlightTimer
    interval: 1000*60*5
    onTriggered: backlight.state = false
    running: backlight.state
    repeat: false
  }

  MouseArea {
    id: wakeupOverlay
    anchors.fill: parent
    onPressed: {
      backlight.state = true;
      backlightTimer.restart();
      mouse.accepted = false;
    }
  }

  Keyboard {
    id: keyboard
    property real hiddenY: parent.height
    property real showY: parent.height - height
    width: parent.width
    height: 200
    y: hiddenY
    NumberAnimation on y {
      id: showKeyboardAnimation
      to: keyboard.showY
      duration: 200
      running: false
    }
    NumberAnimation on y {
      id: hideKeyboardAnimation
      to: keyboard.hiddenY
      duration: 200
      running: false
    }

    Rectangle {
      width: 60
      height: width
      radius: width / 2
      z: -1
      anchors.verticalCenter: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      color: "#eee"
      MouseArea {
        anchors.fill: parent
        drag {
          target: keyboard
          axis: Drag.YAxis
          minimumY: keyboard.showY
          maximumY: keyboard.hiddenY
        }

        onClicked: {
          if(keyboard.y > keyboard.showY) {
            showKeyboardAnimation.restart();
          } else {
            hideKeyboardAnimation.restart();
          }
        }
      }
      Text {
        text: "⌨"
        color: "#aaa"
        font.pixelSize: 24
        anchors.bottom: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
      }

    }
  }
}

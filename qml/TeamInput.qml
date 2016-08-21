import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
  height: list.height
  property alias players: players
  signal playerSelect()

  ListModel {
    id: players
  }

  Flow {
    id: list
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 4
    Repeater {
      model: players
      delegate: Button {
        text: name
        onClicked: players.remove(index)
      }
    }
    Button {
      text: "+"
      onClicked: playerSelect()
      width: height
    }
  }


}

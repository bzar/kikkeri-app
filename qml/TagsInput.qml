import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
  height: list.height
  property alias tags: tags
  signal tagSelect()

  ListModel {
    id: tags
  }

  Flow {
    id: list
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 4
    Repeater {
      model: tags
      delegate: Button {
        text: name
        onClicked: tags.remove(index)
      }
    }
    Button {
      text: "+"
      onClicked: tagSelect()
      width: height
    }
  }


}

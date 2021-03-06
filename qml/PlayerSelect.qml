import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
  id: playerSelect
  color: window.goforeBlue
  signal select(string name)
  onVisibleChanged: playerInput.text = ""

  Row {
    id: input
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: 16
    spacing: 8
    TextField {
      id: playerInput
      width: parent.width - addButton.width
    }
    Button {
      id: addButton
      text: qsTr("Lisää")
      onClicked: select(playerInput.text)
    }
  }
  GridView {
    id: grid
    anchors.top: input.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 16
    cellWidth: width / 3
    cellHeight: 64

    clip: true

    Connections {
      target: client
      onPlayersChanged: model.populate()
    }
    Connections {
      target: playerInput
      onTextChanged: model.populate()
    }
    model: ListModel {
      id: model
      function populate() {
        clear();
        var re = new RegExp(playerInput.text, 'i')
        for(var i = 0; i < client.players.length; ++i) {
          var name = client.players[i];
          if(re.test(name)) {
            append({name: name});
          }
        }
      }
    }
    delegate: Item {
      width: grid.cellWidth
      height: grid.cellHeight
      Button {
        text: modelData
        anchors.fill: parent
        anchors.leftMargin: 4
        anchors.rightMargin: 4
        onClicked: select(modelData)
      }
    }

  }
}

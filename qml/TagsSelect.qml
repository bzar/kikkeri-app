import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
  id: tagSelect
  color: window.goforeBlue
  signal select(var names)
  onVisibleChanged: tagInput.text = ""

  Row {
    id: input
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: 16
    spacing: 8

    TextField {
      id: tagInput
      width: parent.width - addButton.width

    }
    Button {
      id: addButton
      text: qsTr("Lisää")
      onClicked: select(tagInput.text.split(" ").filter(function(x) { return x; }))
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
      target: tagInput
      onTextChanged: model.populate()
    }
    model: ListModel {
      id: model

      property variant sortedTags: {
        var tagCounts = {};
        var tags = [];
        for(var i = 0; i < client.tags.length; ++i) {
          for(var j = 0; j < client.tags[i].length; ++j) {
            var name = client.tags[i][j];
            if(tagCounts.hasOwnProperty(name) && typeof(tagCounts[name]) === "number") {
              tagCounts[name] += 1;
            } else {
              tagCounts[name] = 0;
              tags.push(name);
            }
          }
        }
        tags.sort(function(a, b) { return tagCounts[b] - tagCounts[a] });
        return tags;
      }

      function populate() {
        clear();
        for(var i = 0; i < sortedTags.length; ++i) {
          var name = sortedTags[i];
          append({name: name});
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
        onClicked: tagInput.text += " " + modelData
      }
    }
  }
}

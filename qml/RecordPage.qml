import QtQuick 2.0
import QtQuick.Controls 2.0

Page {
  Rectangle {
    id: modalLayer
    color: Qt.rgba(0,0,0,0.5)
    visible: false
    anchors.fill: parent
    z: 99

    onVisibleChanged: {
      if(!visible) {
        playerSelect.visible = false
        tagsSelect.visible = false
      }
    }

    MouseArea {
      anchors.fill: parent
      onClicked: parent.visible = false
    }

    PlayerSelect {
      id: playerSelect
      property QtObject caller
      function activate(c) {
        caller = c;
        visible = true;
        modalLayer.visible = true;
      }
      visible: false
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: 32
      anchors.bottomMargin: 32
      width: 600

      onSelect: {
        caller.players.append({name: name})
        visible = false;
        modalLayer.visible = false;
      }
    }
    TagsSelect {
      id: tagsSelect
      property QtObject caller
      function activate(c) {
        caller = c;
        visible = true;
        modalLayer.visible = true;
      }
      visible: false
      anchors.top: parent.top
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: 32
      anchors.bottomMargin: 32
      width: 600

      onSelect: {
        for(var i = 0; i < names.length; ++i) {
          caller.tags.append({name: names[i]});
        }
        visible = false;
        modalLayer.visible = false;
      }
    }

  }
  Item {
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: sidebar.left

    Flickable {
      anchors.fill: parent
      contentHeight: recordForm.height
      interactive: contentHeight > height

      Column {
        id: recordForm
        height: childrenRect.height
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 32
        spacing: 4
        Label {
          text: qsTr("Joukkue 1")
          font.pixelSize: 24
          anchors.left: parent.left
          anchors.right: parent.right

          ScoreSlider {
            id: score1
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
          }
        }

        TeamInput {
          id: team1
          anchors.left: parent.left
          anchors.right: parent.right
          onPlayerSelect: playerSelect.activate(team1)
        }
        Label {
          text: qsTr("Joukkue 2")
          font.pixelSize: 24
          anchors.left: parent.left
          anchors.right: parent.right

          ScoreSlider {
            id: score2
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
          }
        }

        TeamInput {
          id: team2
          anchors.left: parent.left
          anchors.right: parent.right
          onPlayerSelect: playerSelect.activate(team2)
        }

        Label {
          text: qsTr("Tagit")
          font.pixelSize: 24
          anchors.left: parent.left
          anchors.right: parent.right
        }
        TagsInput {
          id: tags
          anchors.left: parent.left
          anchors.right: parent.right
          onTagSelect: tagsSelect.activate(tags)
        }
        Button {
          text: qsTr("Lähetä")
          anchors.right: parent.right
          enabled: team1.players.count > 0 && team2.players.count > 0 && (score1.score > 0 || score2.score > 0)
          onClicked: {
            var game = {
              teams: [
                {
                  score: score1.score,
                  players: namesToArray(team1.players)
                },
                {
                  score: score2.score,
                  players: namesToArray(team2.players)
                }
              ],
              tags: namesToArray(tags.tags)
            };

            score1.setScore(0);
            score2.setScore(0);

            client.submit(game);

            function namesToArray(model) {
              var array = []
              for(var i = 0; i < model.count; ++i) {
                array.push(model.get(i).name.toString());
              }
              return array;
            }
          }
        }
      }
    }

  }

  Item {
    id: sidebar
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.topMargin: 16
    anchors.bottomMargin: 16
    width: 320

    Rectangle {
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      width: 1
      color: "gray"

    }

    LatestGames {
      anchors.fill: parent
      anchors.leftMargin: 8
    }
  }

}

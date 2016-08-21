import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Page {
  FilteredGames {
    id: games
    Component.onCompleted: update()
    players: playersInput.text
    tags: tagsInput.text
    since: sinceInput.text
    until: untilInput.text
    numPlayers: numPlayersInput.intValue
  }
  Frame {
    id: filterForm
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    anchors.margins: 16
    width: 320

    ColumnLayout {
      id: filterInput
      anchors.fill: parent
      TextField {
        id: playersInput
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Pelaaja, +Pelaaja, -Pelaaja")
      }
      TextField {
        id: tagsInput
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Tagi, +Tagi, -Tagi")
      }
      TextField {
        id: sinceInput
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Alkupäivämäärä")
      }
      TextField {
        id: untilInput
        anchors.left: parent.left
        anchors.right: parent.right
        placeholderText: qsTr("Loppupäivämäärä")
      }
      Slider  {
        id: numPlayersInput
        property int intValue: (to - from) * position + from
        from: 0
        to: 8
        value: 2
        stepSize: 1
        snapMode: Slider.SnapAlways
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: numPlayersLabel.width
        Label {
          id: numPlayersLabel
          text: parent.intValue > 0 ? parent.intValue : "*"
          font.pixelSize: 24
          anchors.left: parent.right
          anchors.verticalCenter: parent.verticalCenter
        }
      }
      Button {
        id: filterButton
        anchors.right: parent.right
        text: qsTr("Hae")
        onClicked: games.update()
      }
    }

  }

  ListView {
    anchors.top: parent.top
    anchors.left: filterForm.right
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 16
    model: games.results
    delegate: GameItem {
      anchors.left: parent.left
      anchors.right: parent.right
      team1: modelData.teams[0]
      team2: modelData.teams[1]
      timestamp: modelData.timestamp
      tags: modelData.tags
    }
  }
}

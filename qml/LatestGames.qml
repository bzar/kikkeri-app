import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
  Label {
    id: label
    text: "Viimeisimmät tulokset"
    font.pixelSize: 16
  }

  ListView  {
    anchors.top: label.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.topMargin: 8

    clip: true
    spacing: 4
    model: client.latestGames
    delegate: GameItem {
      team1: modelData.teams[0]
      team2: modelData.teams[1]
      timestamp: modelData.timestamp
      tags: modelData.tags
      anchors.left: parent.left
      anchors.right: parent.right
    }
  }
}

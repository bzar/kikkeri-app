import QtQuick 2.0
import QtQuick.Controls 2.0
import "util.js" as Util

Item {
  property var team1
  property var team2
  property date timestamp
  property var tags
  height: players.height + 4
  Label {
    id: score
    anchors.left: parent.left
    anchors.verticalCenter:  players.verticalCenter
    text: team1.score + " - " + team2.score
    font {
      bold: true
      pixelSize: 20
    }
  }
  Column {
    id: players
    anchors.left: score.right
    anchors.right: info.left
    anchors.top: parent.top
    anchors.leftMargin: 8
    height: childrenRect.height

    Label {
      anchors.left: parent.left
      anchors.right: parent.right
      text: team1.players.join(", ")
      wrapMode: Text.WordWrap
    }
    Label {
      anchors.left: parent.left
      anchors.right: parent.right
      text: team2.players.join(", ")
      wrapMode: Text.WordWrap
    }
  }

  Column {
    id: info
    anchors.right: parent.right
    anchors.verticalCenter: players.verticalCenter
    Label {
      text: tags.map(function(t) { return "#" + t; }).join(", ")
      anchors.right: parent.right
      wrapMode: Text.WordWrap
    }
    Label {
      text: Util.fuzzysince(timestamp)
      anchors.right: parent.right
    }

  }


  Rectangle {
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 1
    color: "gray"
  }
}

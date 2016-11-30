import QtQuick 2.0
import QtQuick.Controls 2.0
import "util.js" as Util

Item {
  property var team1
  property var team2
  property date timestamp
  property var tags
  height: Math.max(players.height, info.height) + 4
  Label {
    id: score
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: -2
    text: team1.score + " - " + team2.score
    font {
      bold: true
      pixelSize: 20
    }
  }
  Column {
    id: players
    anchors.left: score.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: -2
    anchors.leftMargin: 8
    height: childrenRect.height
    width: childrenRect.width

    Label {
      anchors.left: parent.left
      text: team1.players.join(", ")
      wrapMode: Text.WordWrap
    }
    Label {
      anchors.left: parent.left
      text: team2.players.join(", ")
      wrapMode: Text.WordWrap
    }
  }

  Column {
    id: info
    anchors.right: parent.right
    anchors.left: players.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: -2
    anchors.rightMargin: 4
    Label {
      text: tags.map(function(t) { return "#" + t; }).join(", ")
      anchors.right: parent.right
      anchors.left: parent.left
      horizontalAlignment: Text.AlignRight
      wrapMode: Text.WordWrap
    }
    Label {
      text: Util.fuzzysince(timestamp)
      anchors.right: parent.right
      anchors.left: parent.left
      horizontalAlignment: Text.AlignRight
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

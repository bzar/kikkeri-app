import QtQuick 2.0

Rectangle {
  property color unpressedColor: "gray"
  property color pressedColor: "lightgray"
  property alias pressed: ma.pressed
  property alias text: label.text
  property real size: 1

  signal clicked()

  width: 24
  height: 32
  color: pressed ? pressedColor : unpressedColor

  MouseArea {
    id: ma
    anchors.fill: parent
    onClicked: parent.clicked()
  }

  Text {
    id: label
    font.bold: true
    color: "white"
    antialiasing: true
    style: Text.Raised
    anchors.centerIn: parent
  }
}

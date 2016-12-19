import QtQuick 2.0
import QtQuick.Controls 2.0

Row {
  property int score: slider.position * 10
  function setScore(value) {
    slider.value = value;
  }

  Slider {
    id: slider
    from: 0
    to: 10
    snapMode: Slider.SnapAlways
    stepSize: 1.0
    width: 200
  }
  Label {
    font.pixelSize: 24
    text: score
    width: 30
  }
}

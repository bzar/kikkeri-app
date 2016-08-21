import QtQuick 2.0

Row {
  onChildrenChanged: relayout()
  onWidthChanged: relayout()
  onHeightChanged: relayout()
  property real size: 1
  spacing: 1

  function relayout() {
    var totalSize = 0;
    for(var i = 0; i < children.length; ++i) {
      var c = children[i];
      var size = c.size ? c.size : 1;
      totalSize += size;
    }
    var totalWidth = width - (children.length - 1) * spacing;
    for(var i = 0; i < children.length; ++i) {
      var c = children[i];
      var size = c.size ? c.size : 1;
      c.width = totalWidth * size / totalSize;
      c.height = height;
    }
  }
}

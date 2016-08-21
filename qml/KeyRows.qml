import QtQuick 2.0

Column {
  onChildrenChanged: relayout()
  onWidthChanged: relayout()
  spacing: 1

  function relayout() {
    var totalSize = 0;
    for(var i = 0; i < children.length; ++i) {
      var c = children[i];
      var size = c.size ? c.size : 1;
      totalSize += size;
    }
    var totalHeight = height - (children.length - 1) * spacing;
    for(var i = 0; i < children.length; ++i) {
      var c = children[i];
      var size = c.size ? c.size : 1;
      c.height = totalHeight * size / totalSize;
    }
  }
}

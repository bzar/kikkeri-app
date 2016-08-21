import QtQuick 2.0

KeyboardKey {
  property int key
  property string letter
  text: keyboard.shift ? letter.toUpperCase() : letter
  onClicked: vkey.emitKey(key, keyboard.shift);
}

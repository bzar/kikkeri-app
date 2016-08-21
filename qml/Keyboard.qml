import QtQuick 2.0

Rectangle {
  id: keyboard
  property bool shift: false
  color: "darkgray"
  KeyRows {
    anchors.fill: parent
    KeyRow {
      anchors.left: parent.left
      anchors.right: parent.right

      LetterKey {key: Qt.Key_1; letter: "1"}
      LetterKey {key: Qt.Key_2; letter: "2"}
      LetterKey {key: Qt.Key_3; letter: "3"}
      LetterKey {key: Qt.Key_4; letter: "4"}
      LetterKey {key: Qt.Key_5; letter: "5"}
      LetterKey {key: Qt.Key_6; letter: "6"}
      LetterKey {key: Qt.Key_7; letter: "7"}
      LetterKey {key: Qt.Key_8; letter: "8"}
      LetterKey {key: Qt.Key_9; letter: "9"}
      LetterKey {key: Qt.Key_0; letter: "0"}
      LetterKey {key: Qt.Key_Backspace; letter: "⌫"; size: 1}
    }

    KeyRow {
      anchors.left: parent.left
      anchors.right: parent.right

      LetterKey {key: Qt.Key_Q; letter: "q"}
      LetterKey {key: Qt.Key_W; letter: "w"}
      LetterKey {key: Qt.Key_E; letter: "e"}
      LetterKey {key: Qt.Key_R; letter: "r"}
      LetterKey {key: Qt.Key_T; letter: "t"}
      LetterKey {key: Qt.Key_Y; letter: "y"}
      LetterKey {key: Qt.Key_U; letter: "u"}
      LetterKey {key: Qt.Key_I; letter: "i"}
      LetterKey {key: Qt.Key_O; letter: "o"}
      LetterKey {key: Qt.Key_P; letter: "p"}
      LetterKey {key: Qt.Key_Aring; letter: "å"}
    }

    KeyRow {
      anchors.left: parent.left
      anchors.right: parent.right

      LetterKey {key: Qt.Key_A; letter: "a"}
      LetterKey {key: Qt.Key_S; letter: "s"}
      LetterKey {key: Qt.Key_D; letter: "d"}
      LetterKey {key: Qt.Key_F; letter: "f"}
      LetterKey {key: Qt.Key_G; letter: "g"}
      LetterKey {key: Qt.Key_H; letter: "h"}
      LetterKey {key: Qt.Key_J; letter: "j"}
      LetterKey {key: Qt.Key_K; letter: "k"}
      LetterKey {key: Qt.Key_L; letter: "l"}
      LetterKey {key: Qt.Key_Odiaeresis; letter: "ö"}
      LetterKey {key: Qt.Key_Adiaeresis; letter: "ä"}
    }

    KeyRow {
      anchors.left: parent.left
      anchors.right: parent.right

      LetterKey {key: Qt.Key_Z; letter: "z"}
      LetterKey {key: Qt.Key_X; letter: "x"}
      LetterKey {key: Qt.Key_C; letter: "c"}
      LetterKey {key: Qt.Key_V; letter: "v"}
      LetterKey {key: Qt.Key_B; letter: "b"}
      LetterKey {key: Qt.Key_N; letter: "n"}
      LetterKey {key: Qt.Key_M; letter: "m"}
      LetterKey {key: Qt.Key_Comma; letter: ","}
      LetterKey {key: Qt.Key_Plus; letter: "+"}
      LetterKey {key: Qt.Key_Minus; letter: "-"}
      KeyboardKey {
        text: "⇑"
        onClicked: shift = !shift
        unpressedColor: shift ? "#aaa" : "gray"
      }
    }
    KeyRow {
      anchors.left: parent.left
      anchors.right: parent.right
      LetterKey {key: Qt.Key_Space; letter: " "; size: 1}
    }
  }


}

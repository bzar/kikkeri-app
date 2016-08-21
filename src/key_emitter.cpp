#include <QCoreApplication>
#include <QGuiApplication>
#include <QKeyEvent>
#include <QQuickItem>
#include "key_emitter.h"

KeyEmitter::KeyEmitter()
{
}

KeyEmitter::~KeyEmitter()
{
}

void KeyEmitter::emitKey(Qt::Key key, bool shift)
{
	QQuickItem* receiver = qobject_cast<QQuickItem*>(QGuiApplication::focusObject());
	if(!receiver) {
		return;
  }

  Qt::KeyboardModifiers modifiers = Qt::NoModifier;
  QString text;
  if(key != Qt::Key_Space) {
    text = QKeySequence(key).toString();
  } else {
    text = " ";
  }

  if(shift) {
    modifiers |= Qt::ShiftModifier;
  } else {
    text = text.toLower();
  }

  QKeyEvent pressEvent = QKeyEvent(QEvent::KeyPress, key,  modifiers, text);
  QKeyEvent releaseEvent = QKeyEvent(QEvent::KeyRelease, key, modifiers);
	QCoreApplication::sendEvent(receiver, &pressEvent);
	QCoreApplication::sendEvent(receiver, &releaseEvent);
}

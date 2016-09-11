#include "raspberrybacklight.h"
#include <QFileSystemWatcher>
#include <QFile>
#include <QDebug>

QString const RaspberryBacklight::BACKLIGHT_FILE = QString("/sys/class/backlight/rpi_backlight/bl_power");

RaspberryBacklight::RaspberryBacklight(QObject *parent) : QObject(parent), state(true)
{
  QFileSystemWatcher* watcher = new QFileSystemWatcher(this);
  watcher->addPath(BACKLIGHT_FILE);
  connect(watcher, &QFileSystemWatcher::fileChanged, this, &RaspberryBacklight::reloadState);
  reloadState();
}

bool RaspberryBacklight::getState() const
{
  return state;
}

void RaspberryBacklight::setState(bool value)
{
  QFile file(BACKLIGHT_FILE);
  file.open(QFile::WriteOnly);
  if(file.isOpen()) {
    file.write(value ? "0" : "1");
    file.close();
    reloadState();
  }
}

void RaspberryBacklight::reloadState()
{
  QFile file(BACKLIGHT_FILE);
  file.open(QFile::ReadOnly);
  if(file.isOpen()) {
    QByteArray content = file.read(1);
    bool newState = !content.startsWith("1");
    if(state != newState) {
      state = newState;
      emit stateChanged(state);
    }
  }
}

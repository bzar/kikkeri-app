#ifndef RASPBERRYBACKLIGHT_H
#define RASPBERRYBACKLIGHT_H

#include <QObject>

class RaspberryBacklight : public QObject
{
  Q_OBJECT
  Q_PROPERTY(bool state READ getState WRITE setState NOTIFY stateChanged)
public:
  explicit RaspberryBacklight(QObject *parent = 0);

signals:
  void stateChanged(bool state);
public slots:
  bool getState() const;
  void setState(bool value);
private slots:
  void reloadState();

private:
  bool state;
  static QString const BACKLIGHT_FILE;
};

#endif // RASPBERRYBACKLIGHT_H

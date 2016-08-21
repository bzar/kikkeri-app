#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCursor>

#include "key_emitter.h"
#include "raspberrybacklight.h"


int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QGuiApplication app(argc, argv);

#ifdef Q_PROCESSOR_ARM
  app.setOverrideCursor(QCursor(Qt::BlankCursor));
#endif

  QQmlApplicationEngine engine;
  QObject::connect(&engine, &QQmlApplicationEngine::quit, &app, QGuiApplication::quit);

  QQmlContext* ctx = engine.rootContext();

  KeyEmitter keyEmitter;
  ctx->setContextProperty("vkey", &keyEmitter);

  RaspberryBacklight backlight;
  ctx->setContextProperty("backlight", &backlight);

  engine.load(QUrl(QLatin1String("qrc:/main.qml")));

  return app.exec();
}

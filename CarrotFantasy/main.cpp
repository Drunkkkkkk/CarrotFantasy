#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
#include "datajson.h"
int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    FelgoApplication felgo;
    QQmlApplicationEngine engine;

    qmlRegisterType<DataJson>("an.qt.jsonIO", 1, 0, "GameDataIO");

    felgo.initialize(&engine);
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
    engine.load(QUrl(felgo.mainQmlFileName()));

    return app.exec();
}

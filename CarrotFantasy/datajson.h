#ifndef DATAJSON_H
#define DATAJSON_H

#include <QObject>


#include <QVariantList>
#include <QVariantHash>

class DataJson : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString fileName READ getFile WRITE setFile)
public:
    explicit DataJson(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList readJson(QString str);
    Q_INVOKABLE bool writeJson(QVariantList passList,QVariantList gradeList);

    void setFile(QString readFile);
    QString getFile();
private:
    QString j_file;

};

#endif // DATAJSON_H

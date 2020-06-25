#include "datajson.h"

#include <QJsonDocument>
#include <QJsonParseError>
#include <QFile>
#include <QJsonObject>
#include <QDebug>
#include <QJsonArray>

#include <QDebug>

DataJson::DataJson(QObject *parent) : QObject(parent)
{

}

void DataJson::setFile(QString readFile)
{
    j_file = readFile;
}

QString DataJson::getFile()
{
    return j_file;
}

QVariantList DataJson::readJson(QString str)
{
    if(j_file.isEmpty()){
        qDebug() << "file is empty";
        return QVariantList();
    }

    QFile file(j_file);
    if(!file.open(QIODevice::ReadOnly)){
        qDebug() << "could't open projects json";
        return QVariantList();
    }

    QByteArray data = file.readAll();
    file.close();

    QJsonParseError json_error;
    QJsonDocument jsonDoc(QJsonDocument::fromJson(data, &json_error));

    if(json_error.error != QJsonParseError::NoError)
    {
        qDebug() << "json error!";
        return QVariantList();
    }

    QJsonObject rootObj = jsonDoc.object();

    if(rootObj.contains(str)) {
        QJsonObject jsonObj = rootObj.value(str).toObject();
        QVariantList list;
        for (int i=0; i<jsonObj.length(); i++) {
            QString objstr = QString("%1%2").arg(str).arg(i+1);
            list.append(jsonObj.value(objstr).toInt());
        }
        return list;
    }
    return QVariantList();
}
//pass,grade
bool DataJson::writeJson(QVariantList passList,QVariantList gradeList)
{
    QJsonObject data_1;
    for (int i=0; i<passList.length(); i++)
        data_1.insert(QString("pass%1").arg(i+1), passList[i].toInt());
    QJsonObject data_2;
    for (int i=0; i<gradeList.length(); i++)
        data_2.insert(QString("grade%1").arg(i+1), gradeList[i].toInt());

    QVariantHash w_data;
    w_data.insert("pass", data_1);
    w_data.insert("grade", data_2);

    QJsonObject rootObj = QJsonObject::fromVariantHash(w_data);
    QJsonDocument document;
    document.setObject(rootObj);

    QByteArray byte_array = document.toJson(QJsonDocument::Compact);
    QString json_str(byte_array);
    //根据实际填写路径
    QFile file(j_file);

    if(!file.open(QIODevice::ReadWrite|QIODevice::Text))
    {
       qDebug() << "file error!";
       return false;
    }
    QTextStream in(&file);
    in << json_str;

    file.close();   // 关闭file
    return true;
}

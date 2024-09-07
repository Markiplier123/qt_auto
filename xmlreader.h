#ifndef XMLREADER_H
#define XMLREADER_H
#include <QtXml>
#include <QFile>
#include <QList>
#include <QObject>
#include <QVariant>
#include "applicationsmodel.h"

class XmlReader
{

public:
    explicit XmlReader(QString filePath, ApplicationsModel &model);
    void XmlUpdateData(QList<ApplicationItem> list);
    bool ReadXmlFile(QString filePath);
    void PaserXml(ApplicationsModel &model);

private:
    QDomDocument m_xmlDoc; //The QDomDocument class represents an XML document.
    ApplicationsModel m_model;


};

#endif // XMLREADER_H

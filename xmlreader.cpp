#include "xmlreader.h"
#include "loghelper.h"
#include <QDebug>
XmlReader::XmlReader(QString filePath, ApplicationsModel &model)
{
    ReadXmlFile(filePath);
    PaserXml(model);
}

bool XmlReader::ReadXmlFile(QString filePath)
{
    LOG_INFO <<filePath;

    // Load xml file as raw data
    QFile f(filePath);
    if (!f.open(QIODevice::ReadOnly ))
    {
        // Error while loading file
        LOG_INFO << "CAN'T READ XML FILE";
        return false;
    }
    // Set data into the QDomDocument before processing
    m_xmlDoc.setContent(&f);
    LOG_INFO << !m_xmlDoc.isNull();
    f.close();
    return true;
}

void XmlReader::PaserXml(ApplicationsModel &model)
{
    LOG_INFO << "START";
    // Extract the root markup
    QDomElement root=m_xmlDoc.documentElement();
    LOG_INFO << !m_xmlDoc.isNull();
    LOG_INFO << !root.isNull();

    // Get the first child of the root (Markup COMPONENT is expected)
    QDomElement Component=root.firstChild().toElement();

    // LOG_INFO << !Component.isNull();

    // Loop while there is a child
    while(!Component.isNull())
    {

        // Check if the child tag name is COMPONENT
        if (Component.tagName()=="APP")
        {

            // Read and display the component ID
            // QString ID=Component.attribute("ID","No ID");

            // Get the first child of the component
            QDomElement Child=Component.firstChild().toElement();

            QString title;
            QString url;
            QString iconPath;

            // Read each child of the component node
            while (!Child.isNull())
            {
                // Read Name and value
                if (Child.tagName()=="TITLE") title = Child.firstChild().toText().data();
                if (Child.tagName()=="URL") url = Child.firstChild().toText().data();
                if (Child.tagName()=="ICON_PATH") iconPath = Child.firstChild().toText().data();

                // Next child
                Child = Child.nextSibling().toElement();
            }
            ApplicationItem item(title,url,iconPath);
            model.addApplication(item);
        }

        // Next component
        Component = Component.nextSibling().toElement();

    }



}

//void XmlReader::updateDataFromQML(int to, int from)
//{
//    LOG_INFO << "START";
//    LOG_INFO << "from: " << from << " to: " << to;
//    m_model.moveItem(from, to);
//    XmlUpdateData(m_model.getListApp());
//    LOG_INFO << "END";
//}

void XmlReader::XmlUpdateData(QList<ApplicationItem> list)
{
    // Extract the root markup
    QDomNodeList application = m_xmlDoc.elementsByTagName("APP");
    for (int i = 0; i < application.size(); i++) {
        QDomNode n = application.item(i);
        QDomElement title = m_xmlDoc.createElement("TITLE");
        title.appendChild(m_xmlDoc.createTextNode(list.at(i).title()));
        QDomElement url = m_xmlDoc.createElement("URL");
        url.appendChild(m_xmlDoc.createTextNode(list.at(i).url()));
        QDomElement path = m_xmlDoc.createElement("ICON_PATH");
        path.appendChild(m_xmlDoc.createTextNode(list.at(i).iconPath()));
        if (title.isNull() || url.isNull() || path.isNull())
        {
            //if new element is null, then continue
            continue;
        }
        n.replaceChild(title ,n.firstChildElement("TITLE"));
        n.replaceChild(url,n.firstChildElement("URL"));
        n.replaceChild(path,n.firstChildElement("ICON_PATH"));


    }


    QFile file("applications.xml");
    if(!file.open(QIODevice::WriteOnly | QIODevice::Text ))
    {
        return;
    }
    QTextStream out(&file);
    out << m_xmlDoc.toString();
    file.close();
}

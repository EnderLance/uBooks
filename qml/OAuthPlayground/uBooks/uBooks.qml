import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.OnlineAccounts 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 0.1 as Popups
import Ubuntu.Components.Extras.Browser 0.1
import "JSONListModel" as JSON
import "components"

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer..uBooks"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(100)
    height: units.gu(75)

    Component
    {
        id: loginPopup

        Popups.Dialog
        {
            id: loginPopupDialog
            anchors.fill: parent

            UbuntuWebView
            {
                id: loginWebView

                anchors.fill: parent

                url: "https://www.googleapis.com/auth/books"
            }
        }
    }

    PageStack
    {
        id: pageStack
        width: parent.width
        height: parent.height
        Component.onCompleted: {
            PopupUtils.open(loginPopup)
            pageStack.push(library)
        }

        Page {
            id: library
            title: i18n.tr("Library")

            Column {
                spacing: units.gu(1)
                anchors {
                    margins: units.gu(2)
                    fill: parent
                }

                Text
                {
                    text: "hi"
                }
            }
        }
    }
}

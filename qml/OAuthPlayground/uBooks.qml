import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.OnlineAccounts 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 0.1 as Popups
import Ubuntu.Components.Extras.Browser 0.1
import OAuth2 0.1
import QtWebKit 3.0
import "JSONListModel" as JSON

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.enderlance.uBooks"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(100)
    height: units.gu(75)

    PageStack
    {
        id: pageStack
        width: parent.width
        height: parent.height
        Component.onCompleted: {
            pageStack.push(google_oauth)
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

                ListView
                {
                    height: parent.height
                    width: parent.width

                    JSON.JSONListModel {
                        id: jsonData
                        source: "GET https://www.googleapis.com/books/v1/mylibrary/bookshelves?key=AIzaSyA7hmQmXo2ytuPSMDj-sG65c5oRSJXaaz8"
                        query: '"reason": "badParam"'
                    }

                    model: jsonData.model

                    delegate: ListItem.Standard
                    {
                        id: book
                        progression: true
                        text: "Book title: "+model.title
                    }
                }
            }
        }

        Page{
            id: google_oauth
            title: "Google Accounts"
            OAuth2{
                id: oauth2
                clientId:  "66359834989.apps.googleusercontent.com";
                clientSecert:  "MvsqL3I02g6SbVGkuzBdZTMY";

                // do not use the other one does not return code return copy and paste tab
                redirectURI : "https://localhost"


                endPoint: "https://accounts.google.com/o/oauth2/auth";

                // The Scopes that you want to USE
                scopes: "email+openid+https://www.googleapis.com/auth/books";

                onLoginDone:{
                    //maybe make a pagestack here
                    loginView.visible = false
                    /*
                    console.log("Access Token =\t " + oauth2.getaccessToken) + "\n"

                    console.log("Token Type =\t" + oauth2.getTokenType) + "\n"

                    console.log("Experation Time =\t" +oauth2.getExperationTime) + "\n"

                    console.log("Token Id =\t" +oauth2.getTokenId) + "\n"

                    console.log("Refresh Token =\t" +oauth2.getRefreshToken) + "\n"
                    */
                    //         This is where you would fill the database whatever it is


                    //maybe make a pagestack here
                    loginView.visible = false

                    pageStack.push(library)
                }
            }
            WebView {
                id: loginView
                width: google_oauth.width
                height: google_oauth.height
                url: oauth2.getloginUrl();
                onUrlChanged:{
                    oauth2.urlChanged(url)
                }
            }
            ActivityIndicator {
                id: busy
                running: loginView.loadProgress < 70 ? true : false
                anchors.centerIn:  loginView;
            }
        }
    }
}

import QtQuick 2.0
import QtWebKit 3.0
//Ubuntu
import Ubuntu.Components 0.1
//Local
import OAuth2 0.1

Page{
    id: google_oauth
    width: parent.height
    height: parent.height
    title: "Google Accounts"
    property int g: 1
    OAuth2{
        id: oauth2
        clientId:  "*********************************";
        clientSecert:  "*************************";
        redirectURI : "http://localhost"
        endPoint: "https://accounts.google.com/o/oauth2/auth";
        scopes: "email+openid+https://www.googleapis.com/auth/plus.login";
        onLoginDone:{
        //fill the databases
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


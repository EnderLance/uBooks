/*
 * Copyright (C) 2012-2013 Joseph Mills.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

//QT
import QtQuick 2.0
import QtWebKit 3.0
//Ubuntu
import Ubuntu.Components 0.1
//Local
import OAuth2 0.1
MainView {
    id: mainViewer
    objectName: "mainView"
    applicationName: "apps.oath2.playground"
    automaticOrientation: true
    anchorToKeyboard: true
    width: units.gu(40)
    height: units.gu(71)
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

                console.log("Access Token =\t " + oauth2.getaccessToken) + "\n"

                console.log("Token Type =\t" + oauth2.getTokenType) + "\n"

                console.log("Experation Time =\t" +oauth2.getExperationTime) + "\n"

                console.log("Token Id =\t" +oauth2.getTokenId) + "\n"

                console.log("Refresh Token =\t" +oauth2.getRefreshToken) + "\n"

                //         This is where you would fill the database whatever it is


                //maybe make a pagestack here
                loginView.visible = false
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

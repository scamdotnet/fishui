/*
 * Copyright (C) 2021 CutefishOS Team.
 *
 * Author:     revenmartin <revenmartin@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import FishUI 1.0 as FishUI

Window {
    id: control
    visible: false
    color: "transparent"

    property string popupText
    property point position: Qt.point(0, 0)
    property alias backgroundOpacity: _background.backgroundOpacity
    property alias backgroundColor: _background.color

    flags: Qt.WindowStaysOnTopHint | Qt.WindowDoesNotAcceptFocus | Qt.ToolTip
    width: label.implicitWidth + FishUI.Units.largeSpacing * 1.5
    height: label.implicitHeight + FishUI.Units.largeSpacing * 1.5

    FishUI.WindowShadow {
        view: control
        geometry: Qt.rect(control.x, control.y, control.width, control.height)
        radius: _background.radius
    }

    FishUI.WindowBlur {
        view: control
        enabled: true
        windowRadius: _background.radius
        geometry: Qt.rect(_background.x, _background.y, _background.width, _background.height)
    }

    FishUI.RoundedRect {
        id: _background
        anchors.fill: parent

        Label {
            id: label
            anchors.centerIn: parent
            text: control.popupText
            color: FishUI.Theme.textColor
        }
    }

    onPositionChanged: adjustCorrectLocation()

    function adjustCorrectLocation() {
        var posX = control.position.x
        var posY = control.position.y

        // left
        if (posX < 0)
            posX = FishUI.Units.smallSpacing

        // top
        if (posY < 0)
            posY = FishUI.Units.smallSpacing

        // right
        if (posX + control.width > Screen.width)
            posX = Screen.width - control.width - 1

        // bottom
        if (posY > control.height > Screen.width)
            posY = Screen.width - control.width - 1

        control.x = posX
        control.y = posY
    }

    function show() {
        if (control.popupText)
            control.visible = true
    }

    function hide() {
        control.visible = false
    }
}

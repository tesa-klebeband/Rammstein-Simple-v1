import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
using Toybox.Time;
using Toybox.Time.Gregorian;

const NUM_DATAFIELDS = 3;

var fontResources = {
    208 => Rez.Fonts.Font208,
    218 => Rez.Fonts.Font218,        
    240 => Rez.Fonts.Font240,
    260 => Rez.Fonts.Font260,
    280 => Rez.Fonts.Font280,
    360 => Rez.Fonts.Font360,
    390 => Rez.Fonts.Font390,
    416 => Rez.Fonts.Font416,
    454 => Rez.Fonts.Font454
};

var logoResourcesRed = {
    208 => Rez.Drawables.Logo208,
    218 => Rez.Drawables.Logo218,        
    240 => Rez.Drawables.Logo240,
    260 => Rez.Drawables.Logo260,
    280 => Rez.Drawables.Logo280,
    360 => Rez.Drawables.Logo360,
    390 => Rez.Drawables.Logo390,
    416 => Rez.Drawables.Logo416,
    454 => Rez.Drawables.Logo454
};

var logoResourcesWhite = {
    208 => Rez.Drawables.Logo208w,
    218 => Rez.Drawables.Logo218w,        
    240 => Rez.Drawables.Logo240w,
    260 => Rez.Drawables.Logo260w,
    280 => Rez.Drawables.Logo280w,
    360 => Rez.Drawables.Logo360w,
    390 => Rez.Drawables.Logo390w,
    416 => Rez.Drawables.Logo416w,
    454 => Rez.Drawables.Logo454w
};

var logo;
var font;
var width;
var height;
var settingsChanged;
var logoColor;
var timeColor;

var dataFieldPosX;
var dataFieldPosY;
var dataFieldColor as Array<Number> = new [NUM_DATAFIELDS];
var dataField as Array<Number> = new [NUM_DATAFIELDS];

class Rammstein_WatchfaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        width = dc.getWidth();
        height = dc.getHeight();
    }

    function onShow() as Void {
        loadResources();
        settingsChanged = false;
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        if (settingsChanged) {
            settingsChanged = false;
            loadResources();
        }
        
        dc.drawBitmap((width / 2) - (logo.getWidth() / 2), logo.getHeight() * 0.25, logo);

        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var timeString = today.hour.format("%02d") + ":" + today.min.format("%02d");

        if (timeColor == 0xFFFFFF) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        } else {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        }
        dc.drawText(
            width / 2,
            height * 0.67,
            font,
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        for (var i = 0; i < NUM_DATAFIELDS; i++) {
            var dataFieldString = "";

            if (dataFieldColor[i] == 0xFFFFFF) {
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
            } else {
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
            }

            switch (dataField[i]) {
                case 0: {
                    dataFieldString = today.day.format("%02d") + "." + today.month.format("%02d") + ".";
                    break;
                }
                case 1: {
                    dataFieldString = ActivityMonitor.getInfo().steps.format("%d");
                    break;
                }
                case 2: {
                    var heartRate = Activity.getActivityInfo().currentHeartRate;
                    if (heartRate != null) {
                        dataFieldString = heartRate.format("%d");
                    } else {
                        dataFieldString = "--";
                    }
                    break;
                }
                case 3: {
                    dataFieldString = (System.getSystemStats().battery+.5).format("%d") + "%";
                }
            }

            dc.drawText(dataFieldPosX[i], dataFieldPosY[i], Graphics.FONT_SMALL, dataFieldString, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }

    function onHide() as Void {
        
    }

    function onExitSleep() as Void {
    }

    function onEnterSleep() as Void {
    }

    function loadResources() as Void {
        logoColor = Application.Properties.getValue("LogoColor") as Number;
        timeColor = Application.Properties.getValue("TimeColor") as Number;
        dataFieldColor[0] = Application.Properties.getValue("CenterFieldColor") as Number;
        dataField[0] = Application.Properties.getValue("CenterField") as Number;
        dataFieldColor[1] = Application.Properties.getValue("LeftFieldColor") as Number;
        dataField[1] = Application.Properties.getValue("LeftField") as Number;
        dataFieldColor[2] = Application.Properties.getValue("RightFieldColor") as Number;
        dataField[2] = Application.Properties.getValue("RightField") as Number;
        dataFieldPosX = [width / 2, width * 0.17, width * 0.83];
        dataFieldPosY = [height * 0.83, height * 0.54, height * 0.54];

        font = Toybox.WatchUi.loadResource(fontResources.get(height));

        if (logoColor == 0xFF0000) {
            logo = Toybox.WatchUi.loadResource(logoResourcesRed.get(height));
        } else {
            logo = Toybox.WatchUi.loadResource(logoResourcesWhite.get(height));
        }
    }

}

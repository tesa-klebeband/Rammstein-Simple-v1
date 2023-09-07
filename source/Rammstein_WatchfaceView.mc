import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
using Toybox.Time;
using Toybox.Time.Gregorian;

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
var field0Color;
var field0;

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
        
        dc.drawBitmap((width / 2) - (logo.getWidth() / 2), logo.getHeight() / 4, logo);

        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var timeString = today.hour.format("%02d") + ":" + today.min.format("%02d");

        if (timeColor == 0xFFFFFF) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        } else {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        }
        dc.drawText(
            width / 2,
            height - (height / 3),
            font,
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        var field0String = "";

        if (field0Color == 0xFFFFFF) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        } else {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        }

        switch (field0) {
            case 0: {
                field0String = today.day.format("%02d") + "." + today.month.format("%02d") + ".";
                break;
            }
            case 1: {
                field0String = ActivityMonitor.getInfo().steps.format("%d");
                break;
            }
            case 2: {
                var heartRate = Activity.getActivityInfo().currentHeartRate;
                if (heartRate != null) {
                    field0String = heartRate.format("%d");
                } else {
                    field0String = "--";
                }
                break;
            }
        }

        dc.drawText(width / 2, height - (height / 6), Graphics.FONT_XTINY, field0String, Graphics.TEXT_JUSTIFY_CENTER);
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
        field0Color = Application.Properties.getValue("Field0Color") as Number;
        field0 = Application.Properties.getValue("Field0") as Boolean;

        font = Toybox.WatchUi.loadResource(fontResources.get(width));

        if (logoColor == 0xFF0000) {
            logo = Toybox.WatchUi.loadResource(logoResourcesRed.get(width));
        } else {
            logo = Toybox.WatchUi.loadResource(logoResourcesWhite.get(width));
        }
    }

}

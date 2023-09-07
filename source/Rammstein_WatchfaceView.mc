import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
using Toybox.Time;
using Toybox.Time.Gregorian;

var logo;
var font;
var width;
var height;
var settingsChanged;
var logoColor;
var timeColor;
var dateColor;
var displayDate;

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

        if (displayDate) {
            var dateString = today.day.format("%02d") + "." + today.month.format("%02d") + ".";
            if (dateColor == 0xFFFFFF) {
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
            } else {
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
            }
            dc.drawText(
                width / 2,
                height - (height / 6),
                Graphics.FONT_XTINY,
                dateString,
                Graphics.TEXT_JUSTIFY_CENTER
            );   
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
        dateColor = Application.Properties.getValue("DateColor") as Number;
        displayDate = Application.Properties.getValue("DisplayDate") as Boolean;

        switch(width) {
            case 208:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font208);
                break;
            case 218:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font218);
                break;
            case 240:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font240);
                break;
            case 260:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font260);
                break;
            case 280:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font280);
                break;
            case 360:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font360);
                break;
            case 390:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font390);
                break;
            case 416:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font416);
                break;
            case 454:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font454);
                break;
            default:
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font240);
                break;
        }

        switch(logoColor) {
            case 0xFF0000: {
                switch(width) {
                    case 208:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo208);
                        break;
                    case 218:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo218);
                        break;
                    case 240:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo240);
                        break;
                    case 260:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo260);
                        break;
                    case 280:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo280);
                        break;
                    case 360:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo360);
                        break;
                    case 390:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo390);
                        break;
                    case 416:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo416);
                        break;
                    case 454:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo454);
                        break;
                    default:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo240);
                        break;
                }
                break;
            }
            case 0xFFFFFF: {
                switch(width) {
                    case 208:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo208w);
                        break;
                    case 218:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo218w);
                        break;
                    case 240:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo240w);
                        break;
                    case 260:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo260w);
                        break;
                    case 280:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo280w);
                        break;
                    case 360:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo360w);
                        break;
                    case 390:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo390w);
                        break;
                    case 416:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo416w);
                        break;
                    case 454:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo454w);
                        break;
                    default:
                        logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo240w);
                        break;
                }
                break;
            }
        }
    }

}

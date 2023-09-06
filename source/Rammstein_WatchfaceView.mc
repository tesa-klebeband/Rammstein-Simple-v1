import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;

var logo;
var font;
var width;
var height;

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
        switch(width) {
            case 208:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo208);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font208);
                break;
            case 218:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo218);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font218);
                break;
            case 240:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo240);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font240);
                break;
            case 260:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo260);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font260);
                break;
            case 280:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo280);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font280);
                break;
            case 360:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo360);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font360);
                break;
            case 390:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo390);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font390);
                break;
            case 416:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo416);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font416);
                break;
            case 454:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo454);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font454);
                break;
            default:
                logo = Toybox.WatchUi.loadResource(Rez.Drawables.Logo240);
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font240);
                break;
        }
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        dc.drawBitmap((width / 2) - (logo.getWidth() / 2), logo.getHeight() / 4, logo);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        var currentTime = System.getClockTime(); 
        var timeString = currentTime.hour.format("%02d") + ":" + currentTime.min.format("%02d");
        dc.drawText(
            width / 2,
            height - (height / 3),
            font,
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    function onHide() as Void {
    }

    function onExitSleep() as Void {
    }

    function onEnterSleep() as Void {
    }

}

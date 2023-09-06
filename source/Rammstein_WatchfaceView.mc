import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;

var logo;
var font;

class Rammstein_WatchfaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));

        switch(dc.getWidth()) {
            case 208:
                logo = Application.loadResource(Rez.Drawables.Logo208) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font208);
                break;
            case 218:
                logo = Application.loadResource(Rez.Drawables.Logo218) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font218);
                break;
            case 240:
                logo = Application.loadResource(Rez.Drawables.Logo240) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font240);
                break;
            case 260:
                logo = Application.loadResource(Rez.Drawables.Logo260) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font260);
                break;
            case 280:
                logo = Application.loadResource(Rez.Drawables.Logo280) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font280);
                break;
            case 360:
                logo = Application.loadResource(Rez.Drawables.Logo360) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font360);
                break;
            case 390:
                logo = Application.loadResource(Rez.Drawables.Logo390) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font390);
                break;
            case 416:
                logo = Application.loadResource(Rez.Drawables.Logo416) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font416);
                break;
            case 454:
                logo = Application.loadResource(Rez.Drawables.Logo454) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font454);
                break;
            default:
                logo = Application.loadResource(Rez.Drawables.Logo240) as BitmapResource;
                font = Toybox.WatchUi.loadResource(Rez.Fonts.Font240);
                break;
        }
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        dc.drawBitmap((dc.getWidth() / 2) - (logo.getWidth() / 2), logo.getHeight() / 4, logo);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        var currentTime = System.getClockTime(); 
        var timeString = currentTime.hour.format("%02d") + ":" + currentTime.min.format("%02d");
        dc.drawText(
            dc.getWidth() / 2,
            dc.getHeight() - (dc.getHeight() / 3),
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

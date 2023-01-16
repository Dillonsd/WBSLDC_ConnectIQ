import Toybox.Lang;
import Toybox.WatchUi;

class WBSLDC_ConnectIQDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new WBSLDC_ConnectIQMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}
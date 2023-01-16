import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class WBSLDC_App extends Application.AppBase {

  private var _channel;
  private var _view;

  function initialize() {
    AppBase.initialize();
    _view = new WBSLDC_View();
  }

  // onStart() is called on application start up
  function onStart(state as Dictionary?) as Void {
    _channel = new WBSLDC_AntChannel();
    _channel.open();
  }

  // onStop() is called when your application is exiting
  function onStop(state as Dictionary?) as Void {
  }

  // Return the initial view of your application here
  function getInitialView() as Array<Views or InputDelegates>? {
    return [ _view ] as Array<Views or InputDelegates>;
  }

  public function onTranslation(data) {
    _view.onTranslation(data);
  }

}

function getApp() as WBSLDC_App {
  return Application.getApp() as WBSLDC_App;
}
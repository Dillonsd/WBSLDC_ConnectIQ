import Toybox.Graphics;
import Toybox.WatchUi;

class WBSLDC_View extends WatchUi.View {

  private var _data;
  private var _strings;
  private var _promptLabel;

  function initialize() {
    View.initialize();
    _data = new WBSLDC_Data();
    _strings = [
      WatchUi.loadResource(Rez.Strings.NoDevicePrompt),
      WatchUi.loadResource(Rez.Strings.WaitingPrompt)
    ];
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.MainLayout(dc));
    _promptLabel = findDrawableById("PromptLabel");
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    var status = _data.getStatus();
    if(status == null) {
      _promptLabel.setText(_strings[0]);
    } else if (!status) {
      _promptLabel.setText(_strings[1]);
    }

    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {
  }

  public function onTranslation(data) {
    _data = data;
    WatchUi.requestUpdate();
  }

}

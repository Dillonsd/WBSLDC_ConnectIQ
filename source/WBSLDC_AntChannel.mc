import Toybox.Ant;
import Toybox.WatchUi;

class WBSLDC_AntChannel extends Ant.GenericChannel {
  private const DEVICE_TYPE = 2;
  private const TRANS_TYPE = 1;
  private const PERIOD = 4096;
  private const RADIO_FREQUENCY = 66;

  private var _chanAssign;
  private var _data;
  private var _searching;
  private var _deviceCfg;
  private var _translationCallback;

  public function initialize() {
    // Get the channel
    _chanAssign = new Ant.ChannelAssignment(
      Ant.CHANNEL_TYPE_RX_NOT_TX, // bidirectional listener
      Ant.NETWORK_PUBLIC);
    GenericChannel.initialize(method(:onMessage), _chanAssign);

    // Set the configuration
    _deviceCfg = new Ant.DeviceConfig({
      :deviceNumber => 0, // Wildcard for search
      :deviceType => DEVICE_TYPE,
      :transmissionType => TRANS_TYPE,
      :messagePeriod => PERIOD,
      :radioFrequency => RADIO_FREQUENCY,
      :searchTimeoutLowPriority => 12,
      :searchThreshold => 0,
      :networkKey64Bit => [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
      });
    GenericChannel.setDeviceConfig(_deviceCfg);
    _data = new WBSLDC_Data();
    _searching = true;
  }

  public function open() {
    // Open the channel
    GenericChannel.open();
    _searching = true;
    return true;
  }

  public function onMessage(msg as Ant.Message) as Void {
    // Parse the payload
    var payload = msg.getPayload();

    if (msg.deviceType == DEVICE_TYPE) {
      if (_searching) {
        // We found a device, so stop searching
        _deviceCfg = new Ant.DeviceConfig( {
          :deviceNumber => msg.deviceNumber,
          :deviceType => DEVICE_TYPE,
          :transmissionType => 0,
          :messagePeriod => PERIOD,
          :radioFrequency => RADIO_FREQUENCY,
          :searchTimeoutLowPriority => 12,    //Timeout in 30s
          :searchThreshold => 0} );           //Pair to all transmitting sensors
        GenericChannel.setDeviceConfig(_deviceCfg);
        _searching = false;
      }
      processTranslation(payload);
    }
  }

  public function setTranslationCallback(callback) {
    _translationCallback = callback;
  }

  public function processTranslation(payload) {
    _data.parsePayload(payload);
    _translationCallback.invoke(_data);
  }
}
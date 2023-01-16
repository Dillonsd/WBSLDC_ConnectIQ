class WBSLDC_Data {
  private var _status;
  private var _seqNum;
  private var _translation;

  public function initialize() {
    _status = null;
    _seqNum = 0;
    _translation = "";
  }

  public function parsePayload(payload) {
    _status = payload[1] & 0x01;
  }

  public function getStatus() {
    return _status;
  }
}
import Toybox.Lang;
import Toybox.System;

class WBSLDC_Data {
  private var _status;
  private var _seqNum;
  private var _translation;
  private var _currentTranslation;

  public function initialize() {
    _status = null;
    _seqNum = 0;
    _translation = "";
    _currentTranslation = "";
  }

  public function getCharacter(index) {
    //var charArray = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
    if (index == 62) {
      return ' ';
    } else if (index == 63) {
      return null;
    } else if (index < 26) {
      return 'A' + index;
    } else {
      System.println("Invalid character");
      return null;
    }
  }

  public function parsePayload(payload) {
    _status = payload[0] & 0x01;
    //var translationArray = [];
    var temp = 0;
    var tempArray = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    temp = ((payload[0] & 0xC0) >> 6) | ((payload[1] & 0x0F) << 2);
    tempArray[0] = temp;
    temp = ((payload[1] & 0xF0) >> 4) | ((payload[2] & 0x03) << 4);
    tempArray[1] = temp;
    temp = ((payload[2] & 0xFC) >> 2);
    tempArray[2] = temp;
    temp = (payload[3] & 0x3F); 
    tempArray[3] = temp;
    temp = ((payload[3] & 0xC0) >> 6) | ((payload[4] & 0x0F) << 2);
    tempArray[4] = temp;
    temp = ((payload[4] & 0xF0) >> 4) | ((payload[5] & 0x03) << 4);
    tempArray[5] = temp;
    temp = ((payload[5] & 0xFC) >> 2);
    tempArray[6] = temp;
    temp = (payload[6] & 0x3F);
    tempArray[7] = temp;
    temp = ((payload[6] & 0xC0) >> 6) | ((payload[7] & 0x0F) << 2);
    tempArray[8] = temp;

    for(var i = 0; i < tempArray.size(); i++) {
      var tempChar = getCharacter(tempArray[i]);
      if (tempChar != null) {
        _currentTranslation += tempChar;
      } else {
        _translation = _currentTranslation;
        _currentTranslation = "";
        return;
      }
    }
  }

  public function getStatus() {
    return _status;
  }

  public function getTranslation() {
    return _translation;
  }
}

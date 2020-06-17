

class WinCheck {
  checkForWin(List<int> values){
    bool meWin = false;
    if(values != null){
      if((values[0] == values[1]) && (values[0] == values[2]) && (values[1] != 0)){
        meWin = true;
      }
      else if((values[3] == values[4]) && (values[3] == values[5]) && (values[3] != 0)){
        meWin = true;
      }
      else if((values[6] == values[7]) && (values[6] == values[8]) && (values[6] != 0)){
        meWin = true;
      }
      else if((values[0] == values[3]) && (values[0] == values[6]) && (values[0] != 0)){
        meWin = true;
      }
      else if((values[1] == values[4]) && (values[1] == values[7]) && (values[1] != 0)){
        meWin = true;
      }
      else if((values[2] == values[5]) && (values[2] == values[8]) && (values[2] != 0)){
        meWin = true;
      }
      else if((values[0] == values[4]) && (values[0] == values[8]) && (values[0] != 0)){
        meWin = true;
      }
      else if((values[2] == values[4]) && (values[2] == values[6]) && (values[2] != 0)){
        meWin = true;
      }
    }
    return meWin;
  }
}
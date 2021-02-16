String toTime(int k) {
  bool hourcheck = (k > 3600);
  String sec = (k % 60).floor().toString().padLeft(2, '0');
  String min = ((k / 60) % 60).floor().toString().padLeft(2, '0');
  String hour = (k / 3600).floor().toString().padLeft(2, '0');
  if (hourcheck) {
    return '$hour:$min:$sec';
  }

  return '$min:$sec';
}

class Time {
  int works;
  int rests;
  int times;
  Time(this.works, this.rests, this.times);
  void toStr(time) {
    time.floor().toString().padLeft(2, '0');
  }

  void copy(Time x) {
    this.works = x.works;
    this.rests = x.rests;
    this.times = x.times;
  }

  void minCheck() {
    this.works = this.works * 60;
    this.rests = this.rests * 60;
  }
}

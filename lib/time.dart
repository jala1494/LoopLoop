

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

  void reset() {
    this.works = 45;
    this.rests = 15;
    this.times = 5;
  }
}

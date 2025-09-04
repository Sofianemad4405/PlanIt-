enum FocusMode { focus, breakTime }

class SessionService {
  static int sessions = 0;

  static void increment() {
    sessions++;
  }

  static void reset() {
    sessions = 0;
  }
}

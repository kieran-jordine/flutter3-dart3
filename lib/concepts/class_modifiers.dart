abstract class Vehicle1 {
  String move1();
  String move2() { return 'move 2 in Vehicle1'; }
}
class Car1 extends Vehicle1 {
  @override
  String move1() { return 'move1 in Car1'; }
}
class Car2 implements Vehicle1 {
  @override
  String move1() { return 'move1 in Car2'; }
  @override
  String move2() { return 'move2 in Car2'; }
}

// sub-types must be base, final or sealed
base class Vehicle2 {
  String method() { return 'method in Vehicle2'; }
}
base class Car3 extends Vehicle2 { }
base class Car4 implements Vehicle2 {
  @override
  String method() { return 'method in Car4'; }
}

// cannot have abstract methods
// cannot be extended outside library
interface class Vehicle3 {
  String method1() { return 'method1 in Vehicle3'; }
}
class Car5 extends Vehicle3 { }
class Car6 implements Vehicle3 {
  @override
  String method1() { return 'method in Car6'; }
}

abstract interface class Vehicle4 {
  String method1() { return 'method1 in Vehicle4'; }
  String method2();
}
class Car7 extends Vehicle4 {
  @override
  String method2() { return 'method2 in Car7'; }
}
class Car8 implements Vehicle4 {
  @override
  String method1() { return 'method1 in Car8'; }
  @override
  String method2() { return 'method2 in Car8'; }
}

// sub-types must be base, final or sealed
// cannot be extended or implemented outside library
final class Vehicle5 {
  String method1() { return 'method1 in Vehicle5'; }
}
final class Car9 extends Vehicle5 { }
final class Car10 implements Vehicle5 {
  @override
  String method1() { return 'method1 in Car10'; }
}

// enumerable set of sub-types
// cannot be extended or implemented outsode library
// implicitly abstract
// can have factory constructors
// can define constructors for subclasses to use
sealed class Vehicle6 { }
class Car11 extends Vehicle6 { }
class Car12 extends Vehicle6 { }
class Car13 extends Vehicle6 { }
String what(Vehicle6 v6) {
  return switch(v6) {
    Car11() || Car13() => 'Car11',
    Car12() => 'Car12',
    _ => 'Car13'
  };
}
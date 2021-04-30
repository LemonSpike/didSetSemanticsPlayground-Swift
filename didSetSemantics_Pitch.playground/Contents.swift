import UIKit

//Example 1

class Foo {
  var bar: Int {
    didSet {
      print("didSet called")
    }
  }


  init(bar: Int) { self.bar = bar }
}

let foo = Foo(bar: 0)
// This calls the getter on 'bar' to get
// the 'oldValue', even though we never
// refer to the oldValue inside bar's 'didSet'
foo.bar = 1

//Example 2

struct Container {
  var items: [Int] = .init(repeating: 1, count: 100) {
    didSet {
      print("entered didSet")
    }
  }

  mutating func update() {
    for index in 0..<items.count {
      items[index] = index + 1
    }
  }
}


var container = Container()
container.update()

// Example 3

@propertyWrapper
struct Delayed<Value> {
  var wrappedValue: Value {
    get {
      guard let value = value else {
        preconditionFailure("Property \(String(describing: self)) has not been set yet")
      }
      return value
    }


    set {
      guard value == nil else {
        preconditionFailure("Property \(String(describing: self)) has already been set")
      }
      value = newValue
    }
  }

  private var value: Value?
}


class Foo {
  @Delayed var bar: Int {
    didSet { print("didSet called") }
  }
}


let foo = Foo()
foo.bar = 1

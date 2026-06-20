import UIKit

var greeting = "Hello, playground"

class AutoMobile {
    var name:String
    init(name:String) { // whenever create variable then always assign at into init method
        self.name = name // self is replace to This keyword in other programming language
    }
    func display(){
        print(name)
        print("*************")
    }
}

class Motorcycle: AutoMobile {
    var price : Double
    init(name:String,price:Double){
        self.price = price
        super.init(name:name)
    }
    
//    func show() {
//        print("name: ",super.name)
//        print("price: ",price)
//        //  super.display(name)
//    }
    
    override func display() {
        print("name: ",super.name)
        print("price: ",price)
    }
}

struct Cycle {
  var name:String
    var price:Double
    func show() {
        print(name,price)
    }
}


let obj = AutoMobile(name:"Toyota")
let obj1 = Motorcycle(name: "TATA", price: 56.80)
let obj2 = Cycle(name: "ABC",price: 50000)
//obj.display()
obj1.display()
obj2.show()

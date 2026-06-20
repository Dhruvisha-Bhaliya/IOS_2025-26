//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)



print("DataTypes")

print("--------------------Integer DataType---------------------- ")


//create Integer type variable

let n:Int = 40
print("Integer Datatype = \(n)")

print(" ")

print("--------------------String DataType---------------------- ")



// create string type variable

let language: String = "swift"
print("String Datatype = \(language)")

print(" ")

print("--------------------Bool DataType---------------------- ")


// create boolean type variable

let passCheck: Bool = true
print("Boolean Datatype = \(passCheck)")

let failCheck: Bool = false
print("Boolean Datatype = \(failCheck)")

print(" ")

let res1:Bool = true
let res2:Bool = false
let res3:Bool = res1 && res2
print("Bool value is : \(res3)")

print(" ")


print("--------------------Character DataType---------------------- ")


// create character type variable

var letter: Character = "A"

print("character Datatype = \(letter)")

print(" ")

// next character print via ASCII value

print("--------------------ASCII VALUE next letter DataType---------------------- ")


let nextCharValue = letter.asciiValue
print(nextCharValue!) // ForceUnrepping

let nCharValue =
Character(UnicodeScalar(
    (letter.asciiValue ?? 65
     ) + 1))
print(nCharValue)

print(" ")
print("--------------------Unsigned Integer DataType---------------------- ")


// create UInt type variable

let  uint:UInt = 10

print(" ")

print("--------------------Float DataType---------------------- ")


// create Float type variable

let x1:Float = 10.20
let x2:Float = 20.20
print("Float sum = \(x1+x2)")

print(" ")

print("--------------------Double DataType---------------------- ")


// create Double type variable

let x3:Double = 10.20
let x4:Double = 20.20
print("Double sum = \(x3+x4)")

print(" ")

print("--------------------Greater Integer Number DataType---------------------- ")


// Greater Number via Integer Datatype

let a = 20
let b = 10
if(a > b){
    print("Greater Number is : \(a)")
}  else{
    print("2")
}
print(" ")

print("--------------------Int Convert Into Double DataType---------------------- ")


// Int Convert Into Double Datatype

let a1 = 20
let b1 = 10.30
//let sum1 = a1 + Int(b1)
let sum1 = Double(a1) + b1
print(sum1)

print(" ")

print("--------------------Double Convert Into Integer DataType---------------------- ")


// Double Convert Into Integer Datatype

let s1 = 20
let s2 = 10.30
let sum2 = s1 + Int(s2)
//let sum1 = Double(a1) + b1
print(sum2)

print(" ")

print("--------------------string concatination---------------------- ")

//string concatination

var var1 = "welcome"
var var2 = "IOS Programming"
print(var1 + " " + var2) // first way
print("\(var1) \(var2)") // second way
print("/(var1) /(var2)") // second way older Xcode version

print(" ")

print("--------------------string interpolation---------------------- ")


print("my string is \(var1) \(var2)") // string interpolation

print(" ")

print("--------------------optional Data type---------------------- ")

// optional Data type

var firstname : String = "IOS Programming"
var lastname : String?
var uname : String?
print(firstname)
print(lastname)
print(uname)

print(" ")

print("-------------------- Force Unwarapping---------------------- ")


// Force Unwarapping

var fname : String?
fname = "Dhruvisha"
if fname != nil {
    print("FirstName is \(fname!)") // without optional value using exclamation sign(!)
   // print("FirstName is \(fname)") // Optional value

}else{
    print("No FirstName")
}

print(" ")

print("-------------------- Automatic Unwarapping---------------------- ")

// Automatic Unwrapping

var name : String!
name = "Dhruvisha"
if let str4 = name {
    print("FirstName is \(str4)")

}else{
    print("No FirstName")
}

print(" ")

print("-------------------- If-else Statement ---------------------- ")


let f1 = 704
if (f1 == 0){
    print("zero")
}
else if(f1%2 == 0){
    print("even")}
else{
    print("Odd")
}

print(" ")

print("-------------------- Tuple ---------------------- ")

print(" ")


print("-------------------- Unnamed Tuple---------------------- ")

let userInfo = ("Dhruvisha Bhaliya",21) // unnamed tuple
print("Unnamed Tuple : \(userInfo)")

print(" ")

print("-------------------- named Tuple---------------------- ")

let userInfo1:(String,Int) = ("Dhruvisha Bhaliya",21) // named tuple
print("named Tuple : \(userInfo1)")

print(" ")

print("--------------------Key-Value pair named Tuple---------------------- ")

let userInfo2 = (name : "Dhruvisha Bhaliya",age : 21) // Key-Value pair named Tuple
print("named Tuple : \(userInfo2)")

print(" ")

print("--------------------Constructing Tuple Value---------------------- ")

print(userInfo2.name)
print(userInfo.1)

print(" ")

print("-------------------- For In Loop ---------------------- ")

var lsnum = [10,20,30,40,50]
for index in lsnum{
    print("\(index)",terminator:" ")
}

print(" ")

var lsNames = ["D","H","R","U","V","I"]
for intt in lsNames {
    print("\(intt)",terminator:" ")
}

print(" ")



print("-------------------- While Loop ---------------------- ")

var i = 1
while i < 15{
    print(i)
    i = i + 2
}

print(" ")


print("-------------------- Pattern ---------------------- ")

for i in 1...5{
    for j in 1...i{
        print("*",terminator: " ")
    }
    print()
}

print(" ")


print("-------------------- 30/12/2025 ---------------------- ")


print("-------------------- Factorial ---------------------- ")

let fact = 6
var counter = 1
var factorial  = 1
repeat{
    factorial *= counter
    counter += 1
    print(factorial)
}while counter <= fact

print(" ")


print("-------------------- Array ---------------------- ")

var array1 = [10,20,40,60]
var array2 :[Int] = []
print(array1)
print(array2)

print(" ")


print("-------------------- Empty Array ---------------------- ")


var intvals = Array<Int>()
var intarr = [Int]()
print(intvals)
print(intarr)

if(intvals.isEmpty){
    print("Empty")
}else{
    print("not")
}

print(" ")


print("-------------------- Empty Ternary Array ---------------------- ")

intarr.isEmpty ? true : false
print(intarr)


print(" ")


print("-------------------- Array Length ---------------------- ")

print("array length : ",array1.count,intarr.count)

print(" ")


print("-------------------- Array concatination ---------------------- ")

var arr1:[String] = ["Dhruvi"]
var arr2:[String] = ["dvfdv"]
print("concat array :  \(arr1 + arr2)")

var arr11 = ["Dhruvi"]
var arr22 = ["dvfdv"]
print("concat array :  \(arr11 + arr22)")

print(" ")


print("-------------------- Array sort ---------------------- ")

var arra = [56,102,78,90]
arra.sort()
print("sort: \(arra)")

print(" ")


print("-------------------- Array sorted ---------------------- ")

var arra1 = [56,102,78,90]
var so = arra1.sorted(by : >)
print("sorted: \(so)")

print(" ")


print("-------------------- Array Access By Index ---------------------- ")

print("Access By Index: \(arra1[0])")


print(" ")


print("-------------------- Array Append---------------------- ")

arra1.append(200) // Single value add at the end of array
print(arra1)

arra1.append(contentsOf: [400,500]) // Multiple value add at the end of array
print(arra1)

print(" ")


print("-------------------- Array Insert ---------------------- ")

arra1.insert(100, at: 2) // Single value insert at specific position
print("Insert Array : \(arra1)")

print(" ")


print("-------------------- Array Insert contentOf ---------------------- ")

arra1.insert(contentsOf:[3,4], at: 1) // multiple value insert at specific position
print(arra1)

print(" ")


print("-------------------- Array Remove ---------------------- ")


arra1.remove(at: 2)
print("Remove: \(arra1)")

arra1.removeAll()
print("Remove All: \(arra1)")

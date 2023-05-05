






func helloWorld(){
    print("HelloWorld")
}

// eger degiskenlerin onune _ koyarsak bu sayede fonksiyonu cagirdigimiz yerde tekrardan parametrelerin aciklamalarini yazmamiza gerek kalmaz
func addNumbers(_ num1:Int, _ num2:Int){
    print(num1+num2)
}

// Swiftte, geriye deger donduren fonksiyonun tipi ->Int seklinde gosterilir. C dilinde fonksiyonun onune yaziyorduk vay be.
func addNumbersAndSet(num1:Int, num2:Int)->Int{
    return num1+num2
}

helloWorld()

//addNumbers(num1:10, num2:5)
addNumbers(10,5)

var result = addNumbersAndSet(num1: 8, num2: 3)
print(result)

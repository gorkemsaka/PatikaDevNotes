for i  in 1 ... 100{ //  1..<100 | 100'u dahil etme demek
    print("Number \(i)")
}

var i = 0
while i < 10 {
    print("Number \(i)")
    i += 1
}

var numbers = [1,2,34,5,6,7,8,9]


for number in numbers {
    print(number)
}

for (i, number) in numbers.enumerated() { //.enumerated kullanilan bi fonksiyondur. degeri ve indexi verir.
    print("\(i). index, \(number)")
}



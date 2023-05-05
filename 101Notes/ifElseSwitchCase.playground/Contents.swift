var password = 10


if password == 28 {
    print("sifre dogru")
}else{
    print("sifre yanlis")
}


//basit bir enum ornegi. VB10'dan hatirlarsin. (VB10ISLIFE)
enum PasswordOption{
    case low
    case med
    case high
}

var passwordTest : PasswordOption = .high


switch passwordTest{
    
case .low:
    print("low")
case .med:
    print("med")
case .high:
    print("high")
//default:
//    print("not valid")
}
 

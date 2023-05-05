import UIKit

var array = ["Elma", "Muz", "Cilek"]

//ici bos olan array olusturma, fakat initialize edilmistir yani bellekte yer kaplar. () ile initialize edildigini anlayabiliriz
var ar2 = [Int]()

//ici bos olan array olusturma, fakat bu daha initialize olmamis.
var ar3: Array<Float> = [] //Daha sonradan = ve [] ekleyerek initialize edilmistir.
 
ar2.append(10)
ar2.removeAll()//tum listeyi siler
//ar2.remove(at: 2)//2. indexi siler

let lastItem = ar2.popLast() // Son degeri siler ve listeyi ayni sekilde geri dondurur.

var dict = ["Ali" : 3, "Kerem" : 8, "Kaan" : 7]
var dict2 = [String:Float]()
var dict3: Dictionary <String,Float>

//dict2.removeValue(forKey: "Ali")

dict["Gorkem"] = 9

//dict.removeValue(forKey: "Kaan")
dict["Gorkem"] = nil // silmenin baska bir yontemi
dict.removeAll()



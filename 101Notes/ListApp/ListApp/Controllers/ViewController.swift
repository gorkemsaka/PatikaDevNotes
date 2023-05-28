//
//  ViewController.swift
//  ListApp
//
//  Created by Gorkem Saka on 5/13/23.
//

import UIKit
import CoreData


// burada UIViewController sinifindan, ViewController olusturduk ve bu sinifUITableViewDelegate ve UITableViewDataSource protokollerini kullaniyor fakat bu protokolleri yazdigimiz extensionsta kullandik
class ViewController: UIViewController{
    @IBOutlet weak var tableView : UITableView!
    
    // alertController'i bilerek globalde tanimladik. Bu sayede fonksiyonlar ihtiyac duydugunda erisebilecek
    var alertController = UIAlertController()
    
    // data, info icinde olusturdugumuz local veritabanindan gelecek
    var data = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView'in delegate metodu UITableViewDelegate sinifindan conform olacak
        tableView.delegate = self
        //tableView'in datasource metodu UITableViewDataSource sinifindan conform olacak
        tableView.dataSource = self
        fetch()
    }
    
    
    
    
    
    @IBAction func didAddBarButtonTapped(_ sender : UIBarButtonItem){
        presentAddAlert()
       
    }
    
    @IBAction func didRemoveBarButtonTapped(_ sender : UIBarButtonItem){
        
        prototypeAlert(title: "Silmek Istediginize Emin Misiniz?",
                       message: nil,
                      defaultButtonTitle: "Evet",
                       cancelButtonTitle: "Vazgec",
                       defaultButtonHandler: {_ in
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedObjectContext = appDelegate?.persistentContainer.viewContext
            
            
            // tum indexler arasinda gez ve hepsini teker teker sil
            for item in self.data {
                managedObjectContext?.delete(item)
            }
            
            try? managedObjectContext?.save()
            self.fetch()
            
        }
        )
    }
    
    
    // eleman eklenirken olusacak alert
    func presentAddAlert(){
        prototypeAlert(title: "Yeni Eleman Ekle",
                       message: nil,
                       defaultButtonTitle: "Ekle",
                       cancelButtonTitle: "Vazgec",
                       isTextFieldAvaliable: true,
                       defaultButtonHandler: {_ in
            
            let text = self.alertController.textFields?.first?.text
                if text != "" {
                    // burada self yazmamizin sebebi, data ve tableView hangi sinifa ait bunu anlamiyor bu yuzden, addButton'un bulundugu classin data ve tableView'ini kullan diyoruz
                    // sondaki unlem isareti, texfield bos birakilmicak bunun kontrolu bende bos gelsede ben halledicem gibi birsey

                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    let managedObjectContext = appDelegate?.persistentContainer.viewContext
                    
                    // managedObjectContext (yani veritabanimiz)'in icine, ListItem adli  bir entity olustur
                    let entity = NSEntityDescription.entity(forEntityName: "ListItem", in: managedObjectContext!)
                    
                    // listItem entitysinden, bir veri nesnesi olusturuldu ve veritabanina eklendi. Veri nesnesi class mantigiyla ayni. Yani bir listItem class'i (olusturuldu ve icinde ozellik olarak title var. Bu title'i kullanarak artik nesne uretebiliriz gibi birsey.)
                    let listItemObject = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
                    
                    // texfield ile aldigimiz text degiskenini, listItem nesnesinin title'ina esitle.
                    listItemObject.setPrimitiveValue(text, forKey: "title")
                    
                    // yaptigimiz degisiklikleri, veritabanina kaydetmek icin. try koymamizinda sebebi, veritabanina kayit islemi yapilirken herhangi bir hata throw edilirse, uygulama cokmesin diye.
                    try? managedObjectContext?.save()
                     
                    self.fetch()
                } else {
                    self.presentWarningAlert()
                }
            
        }
                     )}
    
    
    // eleman bos birakilirsa gosterilecek olan alert
    func presentWarningAlert(){
        
        prototypeAlert(title: "UYARI",
                       message: "Eleman Bos Birakilamaz",
                       cancelButtonTitle: "Vazgec")
    }
    
    
    func prototypeAlert(title : String?,
                        message: String?,
                        preferredStyle: UIAlertController.Style = .alert,
                        defaultButtonTitle : String? = nil,
                        cancelButtonTitle : String?,
                        isTextFieldAvaliable : Bool = false,
                        defaultButtonHandler : ((UIAlertAction) -> Void)? = nil){
        
        alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        
        
        if defaultButtonTitle != nil{
            let defaultButton = UIAlertAction(title: defaultButtonTitle,
                                              style: .default,
                                              handler: defaultButtonHandler)
            
            alertController.addAction(defaultButton)
        }
        
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel)
        
        if isTextFieldAvaliable{
            alertController.addTextField()
        }
        
        
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    func fetch(){
        //UIApplication.shared, tum uygulamanin yasam dongusu gibi birsey. Ornegin buradan, uygulama arkaya atildi mi? vb. bilgilerini alabiliriz. Bunu bir cast islemi yaparak sonucunun AppDelegate olmasini sagladik. Bu sayede gelen degeri appDelegate degiskeni icinden kullanicaz ve bu projede localdeki veritabanimiza baglanmak icin kullanicaz
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        //veritabanimizin ta kendisi
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        
        
        //ListItem Entitiy'sinden veri çekmek için bir sorgu (fetch) oluşturduk. fetchRequest degiskeninin bir NSManagedObject dondurmesini istedigimiz icinde, generic olarak NSManagedObject belirledik
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ListItem")
        
        //veri cekme islemini gerceklestiriyoruz ve verileri dataya kaydediyoruz.
        //(Bunu yaparken managedObjectContext ve try'in yanindaki "?"'yi "!"' ile degistirdik.)
        data = try! managedObjectContext!.fetch(fetchRequest)
        
        tableView.reloadData()

    }
    
}


// burada bir extension yazarak kodlarin daha okunabilir yazilmasini sagladik
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    //UITableViewDataSource protocolunu kullaninca, mutlaka yazilmasi gereken metot. Aksi halde program hata verir
    //numberOfRowsInSection metodu, kac adet section olucagini soyler
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    //UITableViewDataSource protocolunu kullaninca, mutlaka yazilmasi gereken metot. Aksi halde program hata verir
    //cellForRowAt metodu, olusacak sectionlarin icinde neler gostericegini soyler
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // bir cell degiskeni olusturduk. Bu sayede, bu degiskeni kullanarak, cellerin icinde yazacak degeri belirleyecegiz. Bunu kullanmiyoruz cunku burada manuel olarak cell olusturduk. Onun yerine bir adet protoype olusturarak onun uzerinden tum cellerimizi yonetmek daha kolay
        //var cell = UITableViewCell()
        
        
        // burada, cell degiskeni olustruduk. Bu sayede, degiskeni kullanarak cellerin icinde yazaka degeri belirleyecegiz ve ayni zamanda, bu cell'i manuel olarak degil, bir prototype cell kullanarak olusturduk ve bu sayede dequeueReusableCell fonksiyonunu kullanabildik. Artik islemlerimizi bu prototype uzerinden yapabiliriz.
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        
        // listitemin icine
        let listItem = data[indexPath.row]
        cell.textLabel?.text = listItem.value(forKey: "title") as? String
        return cell
    }
    
    
    // secilen elemani, kaydirinca gelen ozellikler. Ornegin wpde kaydirinca arsvile ve sil geliyor
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        // buradaki arka arkaya olan "_"'lerin nedeni, handler metotunun icinde gelen parametrelere burada ihtiyacim yok o yuzden onlari kullanmayacagimi gosterdim.
        let deleteAction = UIContextualAction(style: .normal, title: "Sil") { _, _, _ in
    
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedObjectContext = appDelegate?.persistentContainer.viewContext
            
            // veri tabani uzerinden silme islemi
            managedObjectContext?.delete(self.data[indexPath.row])
            // silme islemini hafizaya kaydetme
            try? managedObjectContext?.save()
            
            self.fetch()
        }
        deleteAction.backgroundColor = .systemRed
        
        let updateAction = UIContextualAction(style: .normal, title: "Duzenle") { _, _, _ in
            
           
            self.prototypeAlert(title: "Duzenle",
                                message: nil,
                                defaultButtonTitle: "Kaydet",
                                cancelButtonTitle: "Vazgec",
                                isTextFieldAvaliable: true,
                                defaultButtonHandler: {_ in
                let text = self.alertController.textFields?.first?.text
                
                //zaten nil olmicak bunun sorgusunu yaptik. O yuzden ! isreti koyduk. Cok onerilen bir yontem degil ileride daha mantikli cozumlere bakmayi unutma
                if text != ""{
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    let managedObjectContext = appDelegate?.persistentContainer.viewContext
                    
                    //indexteki elemanin degerini, text ile degistir ve bunu title'a kaydet.
                    self.data[indexPath.row].setValue(text, forKey: "title")
                    
                    if managedObjectContext!.hasChanges{
                       try? managedObjectContext?.save()
                    }
                    
                    self.tableView.reloadData()
                }else{
                    self.presentWarningAlert()
                }
                
                
            })
            
        }
        updateAction.backgroundColor = UIColor.systemBlue
        
        // elemani kaydirinca olusacak actionlar [] icinde sira sira gosterilir.
        let config = UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
        
        return config
    }
    
}












// Eleman ekleme alertimizi olusturduk.
//let alertController = UIAlertController(title: "Yeni Eleman Ekle",
//                                        message: nil,
//                                        preferredStyle: .alert)
//
// Alertin icine bir ekle butonu olusturduk.
// UIAlertAction olusturdugumuzda, "{_ in }" icine yazdiklarimiz ile, butona basilinca ne yapilacagini olusturabiliriz
//let addButton = UIAlertAction(title: "Ekle",
//                              style: UIAlertAction.Style.default){_ in
//    let text = alertController.textFields?.first?.text
//    if text != "" {
//        // burada self yazmamizin sebebi, data ve tableView hangi sinifa ait bunu anlamiyor bu yuzden, addButton'un bulundugu classin data ve tableView'ini kullan diyoruz
//        // sondaki unlem isareti, texfield bos birakilmicak bunun kontrolu bende bos gelsede ben halledicem gibi birsey
//        self.data.append((text)!)
//        self.tableView.reloadData()
//    } else {
//        self.presentWarningAlert()
//    }
//}
//
//
// burada "{- in }" kullanmadik cunku, style'i zaten cancel sectigimiz icin otomatik kendisi kapicak.
//let cancelButton = UIAlertAction(title: "Vazgec", style: .cancel)
//
//
//olusturulan ekle ve vazgec butonlarini, alert icinde gosterdik
//alertController.addAction(addButton)
//alertController.addAction(cancelButton)
//
// kullanicinin, eleman ekleyebilecegi textfieldi gosterdik.
//alertController.addTextField()
//
//alertimizi gosterdik
//present(alertController, animated: true)

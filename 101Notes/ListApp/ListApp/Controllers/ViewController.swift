//
//  ViewController.swift
//  ListApp
//
//  Created by Gorkem Saka on 5/13/23.
//

import UIKit

// burada UIViewController sinifindan, ViewController olusturduk ve bu sinifUITableViewDelegate ve UITableViewDataSource protokollerini kullaniyor
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView : UITableView!
    
    // alertController'i bilerek globalde tanimladik. Bu sayede fonksiyonlar ihtiyac duydugunda erisebilecek
    var alertController = UIAlertController()
    var data = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView'in delegate metodu UITableViewDelegate sinifindan conform olacak
        tableView.delegate = self
        //tableView'in datasource metodu UITableViewDataSource sinifindan conform olacak
        tableView.dataSource = self
    }
    
    
    
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
       
        cell.textLabel?.text = data[indexPath.row]
        return cell
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
            self.data.removeAll()
            self.tableView.reloadData()
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
                    self.data.append((text)!)
                    self.tableView.reloadData()
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

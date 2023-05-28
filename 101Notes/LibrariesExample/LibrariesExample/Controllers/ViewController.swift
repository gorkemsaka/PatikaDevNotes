//
//  ViewController.swift
//  LibrariesExample
//
//  Created by Gorkem Saka on 5/23/23.
//

import UIKit
import Alamofire
import Kingfisher
//import FLEX



class ViewController: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftgen()
    }
    
    
    // MARK: - SwiftGen
    func swiftgen(){
        // swiftgen ile, hicbir tanimlama yapmadan, Supporting Files icindeki assets dosyasinin icine kaydettigim tum resimleri, bu sekilde benim icin generate etti.
        imageView.image = Asset.redRose.image
    }
    
    // MARK: - FLEX kullaninca bir bug olusuyor anlam veremedim. Bi ara buna kesin bak
    // 2 parmak ile 2 tiklama yapilinca ne olacagini tanimladik
//    func setupFlexGesture(){
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(didFlexGestureRecognized(_:)))
//        gesture.numberOfTapsRequired = 2
//        gesture.numberOfTouchesRequired = 2
//        view.addGestureRecognizer(gesture)
//    }
//
//    @objc func didFlexGestureRecognized(_ sender : UITapGestureRecognizer){
//        FLEXManager.shared.showExplorer()
//    }
    
    // MARK: - KingFisher
    func setImageViaKingfisher(){
        let url = URL(string: "https://i0.wp.com/turanotagi.com/wp-content/uploads/2017/09/Gokturkce-Turk.png?ssl=1")
        imageView.kf.setImage(with: url)
    }
    
    func setImageViaAlamoFire(){
        let url = URL(string: "https://via.placeholder.com/300")
        let cache = NSCache<AnyObject,AnyObject>()
        
        // cacheden gelen veriyi, imageye donusturduk
        if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage{
            imageView.image = imageFromCache
            return
        }
        
        AF.request(url!, method: .get).response { response in
            switch response.result{
            case .failure(let error):
                print(error)
            case.success(let data):
                guard let data = data,
                        let image = UIImage(data: data) else {
                    return
                    
                }
                cache.setObject(image, forKey: url as AnyObject)
                self.imageView.image = image
            }
        }
    }
    
    
    //MARK: - SnapKit
    func setConstraintsViaSnapKit(){    
        redView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(256.0)
            make.height.equalTo(126.0)
            // widgh ve height esitse boyle bir kullanim imkanimizda var
            // make.width.height.equalTo(256.0)
        }
    }
    func setConstraintsViaAutoLayout(){
        // özelliğini false olarak ayarlamak, Auto Layout sisteminin view'in konumunu ve boyutunu kontrol etmesini sağlar.
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // redView'i dikeyde ve yatayda ortaladik ve daha sonrada onlari aktif ettik. Active etmeden calismaz
        //redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // Her constraint icin ayri ayri isActive yapmak yerine, asagidaki fonksiyonun icine, tum constraintleri yazarak daha temiz kod yazilabilir.
        NSLayoutConstraint.activate([
                                    redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     redView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     redView.heightAnchor.constraint(equalToConstant: 128.0),
                                     redView.widthAnchor.constraint(equalToConstant: 256.0)
                                    ])
    }
    
    //MARK: - Alamo Fire
    func fetchWithAlamoFire(){
        
        //fetchWithURLSession()
        
        AF.request("https://google.com").response{response in
            
            print(response)
            
        }
        
    }
    
    func fetchWithURLSession(){
        
        let url = URL(string: "https://no1softwarestudio.com")
        
        // force ettik fakat icinin bos olmciagini biliyoruz. normalde mantikli olan cozum bu degil
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data , response, error in
            guard let data else{
                return
            }
            
            print(String(data : data, encoding: .ascii) ?? "Data Is Invalid")
            
        }
        
        // yukarida olusturdugumuz taski, calistirmak icin resume kullanmaliyiz. Eger yukaridaki taski bir degiskene atamasaydik, handlerin }' closure'sinin sonuna da .resume() yazabilirdik.
        task.resume()
        
    }

}

//
//  AppDelegate.swift
//  LibrariesExample
//
//  Created by Gorkem Saka on 5/23/23.
//

import UIKit

// SnapKit'i burada import ettik. Cunku appDelegate, bir nevi uygulamanin omurgasi. Ismi hicbir zaman degismicek, bu uygulama varoldukca bu dosya burada duracak. SnapKiti herhangi biryerde import ettikten sonra baska yerde import etmeye gerek yoktur.
import SnapKit
import IQKeyboardManagerSwift



@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // artik IQKeyboardManager uygulama icinde kullanima hazir.
        IQKeyboardManager.shared.enable = true
        return true
    }
}


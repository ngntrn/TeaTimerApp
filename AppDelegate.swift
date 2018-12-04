//
//  AppDelegate.swift
//  TeaTimer
//
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit
import UserNotifications

var teaCupImages: [UIImage] = []

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 4) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UIView{
    func addShadow(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}

extension UITextField {
    func addBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:

        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge],completionHandler:{didAllow, error in
        })

        application.beginBackgroundTask(withName: "TeaDone", expirationHandler: nil)

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Light", size: 20)!
        ]

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Light", size: 15)!], for: UIControl.State.normal)


        teaCupImages = createImageArray(total: 20, imagePrefix: "teacup")


        return true
    }


    func createImageArray(total: Int, imagePrefix: String) -> [UIImage]{
        var imageArray: [UIImage] = []

        for imageCount in 1..<total+1{
            let imageName = "\(imagePrefix)\(imageCount).png"
            //print(imageName)
            let image = UIImage(named: imageName)!

            imageArray.append(image)
        }
        return imageArray
    }


    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {



        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("Application is in inactive state.")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Application has entered background.")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Application has entered foreground.")

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Application has become active.")

    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("Application is terminating.")

    }


}

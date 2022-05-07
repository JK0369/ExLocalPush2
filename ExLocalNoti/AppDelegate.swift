//
//  AppDelegate.swift
//  ExLocalNoti
//
//  Created by 김종권 on 2022/05/07.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UNUserNotificationCenter.current().requestAuthorization(
      options: [.alert, .sound, .badge],
      completionHandler: { (granted, error) in
        print("granted notification, \(granted)")
      }
    )
    UNUserNotificationCenter.current().delegate = self
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.presentLogin()
    self.window?.makeKeyAndVisible()
    
    return true
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
    [.list, .banner, .sound, .badge]
  }
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    guard let deepLink = DeepLink(string: response.notification.request.identifier) else { return }
    switch deepLink {
    case .login:
      self.presentLogin()
    case let .main(message, desc):
      self.presentMain(message: message, desc: desc)
    }
    completionHandler()
  }
}

// MARK: AppDelegate + Flow
extension AppDelegate {
  func presentLogin() {
    let vc = ViewController()
    self.window?.rootViewController = vc
    vc.view.layoutIfNeeded()
  }
  func presentMain(message: String?, desc: String?) {
    let vc = MainVC(message: message, desc: desc)
    self.window?.rootViewController = vc
    vc.view.layoutIfNeeded()
  }
}

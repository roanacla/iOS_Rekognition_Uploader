//
//  AppDelegate.swift
//  iOS_Rekognition_Uploader
//
//  Created by Roger Navarro on 9/28/20.
//

import Foundation
import UIKit
import Amplify

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    do {
      Amplify.Logging.logLevel = .verbose
      try Amplify.configure()
    } catch {
      print("An error occurred setting up Amplify: \(error)")
    }
    return true
    
  }
}

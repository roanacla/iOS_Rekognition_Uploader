//
//  AppDelegate.swift
//  iOS_Rekognition_Uploader
//
//  Created by Roger Navarro on 9/28/20.
//

import Foundation
import UIKit
import Amplify
import AmplifyPlugins
import AWSPredictionsPlugin
import AWSMobileClient

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    do {
      AWSMobileClient.default().initialize { (userState, error) in
              guard error == nil else {
                  print("Error initializing AWSMobileClient. Error: \(error!.localizedDescription)")
                  return
              }
              guard let userState = userState else {
                  print("userState is unexpectedly empty initializing AWSMobileClient")
                  return
              }

              print("AWSMobileClient initialized, userstate: \(userState)")
          }
      Amplify.Logging.logLevel = .verbose
      try Amplify.add(plugin: AWSCognitoAuthPlugin())
      try Amplify.add(plugin: AWSPredictionsPlugin())
      
      try Amplify.configure()
      print("🟢 Amplify configured")
    } catch {
      print("An error occurred setting up Amplify: \(error)")
    }
    return true
    
  }
}

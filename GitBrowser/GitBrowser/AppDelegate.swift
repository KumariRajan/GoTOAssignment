//
//  AppDelegate.swift
//  GitBrowser
//
//  Created by Prashant Rane
//  Copyright © 2019 prrane. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let splitViewController = window!.rootViewController as! UISplitViewController
    let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
    navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    splitViewController.delegate = self

    // Setup URL Cache
    NetworkManager.setupURLCache()  

    return true
  }

  // MARK: - Split view

  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
      guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
      guard let topAsDetailController = secondaryAsNavController.topViewController as? RepositoryDetailsVC else { return false }
      if topAsDetailController.repoDetails == nil {
          // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
          return true
      }
      return false
  }

}


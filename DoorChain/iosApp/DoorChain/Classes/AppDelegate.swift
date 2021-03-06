//
//  AppDelegate.swift
//  DoorChain
//
//  Created by Vladimir Sharaev on 30.08.2018.
//  Copyright © 2018 PixelPlex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var applicationAssembler = ApplicationAssembler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        _ = ApplicationAssembler.rootAssembler()
        self.window = applicationAssembler.assembler.resolver.resolve(UIWindow.self)!
        self.window?.makeKeyAndVisible()
        
        let configurators: [ConfiguratorProtocol] = applicationAssembler.assembler.resolver.resolve([ConfiguratorProtocol].self)!
        for configurator in configurators {
            configurator.configure()
        }
        
        return true
    }
}

extension AppDelegate {
    
    static var currentDelegate: AppDelegate {
        // swiftlint:disable force_cast
        return UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
    }
    
    static var currentWindow: UIWindow {
        return currentDelegate.window!
    }
    
    static var moduleAssembly: ModuleAssembly {
        return applicationAssembler.assembler.resolver.resolve(ModuleAssembly.self)!
    }
    
    static var applicationAssembler: ApplicationAssembler {
        return currentDelegate.applicationAssembler
    }
}

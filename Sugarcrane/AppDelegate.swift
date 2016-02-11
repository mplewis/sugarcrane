import UIKit
import Bean_iOS_OSX_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var beanManager: PTDBeanManager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        beanManager = PTDBeanManager()
        return true
    }

}


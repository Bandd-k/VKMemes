import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = setUPRoot()
        window?.makeKeyAndVisible()
        return true
    }

    private func setUPRoot() -> UINavigationController {
        let welcomeViewController = FeedMainController()
        let navController = UINavigationController(rootViewController: welcomeViewController)
        //navController.navigationBar.barTintColor = .clear
        //navController.navigationBar.tintColor = .white
        navController.navigationBar.isTranslucent = false
        return navController
    }
}

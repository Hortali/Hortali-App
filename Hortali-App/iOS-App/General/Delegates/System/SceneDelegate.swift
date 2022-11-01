/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /* MARK: - Atributos */
    
    /// Janela principal do app
    var window: UIWindow?
    
    
    
    /* MARK: - Delegate */

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        //self.window?.rootViewController = MainController()
        self.window?.rootViewController = OnboardingViewController()
        self.window?.makeKeyAndVisible()
    }
}

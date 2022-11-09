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

        var controller: UIViewController
    
        /// Verifica para qual tela o usuário será direcionado
        if UserDefaults.standard.isOnboarding {
            controller = MainController()
        } else {
            controller = OnboardingViewController()
        }
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de configurações
class SettingsController: UIViewController, SettingsProtocol {
    
    /* MARK: - Atributos */

    /* View */

    /// View principal que a classe vai controlar
    private let myView = SettingsView()
    
    
    /* Delegate & Data Sources */
    
    /// Data source da collection principal
    private let settingsDataSource = SettingsDataSource()
    
    /// Delegate da collection principal
    private let settingsDelegate = SettingsDelegate()


		
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDelegates()
    }
    


    /* MARK: - Protocolo */
    
    internal func openPage(for index: Int) {
        if index == 0 {
            self.showOnBoarding()
        } else {
            self.openLink(for: index)
        }
    }

    
    
    /* MARK: - Configurações */

    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.settingsDelegate.setProtocol(with: self)
        
        self.myView.setCollectionDataSource(for: self.settingsDataSource)
        self.myView.setCollectionDelegate(for: self.settingsDelegate)
    }
    
    
    /// Abre no navegador principal
    /// - Parameter index: index da célula
    private func openLink(for index: Int) {
        let data = self.settingsDataSource.collectionData[index]
        let link = data.link ?? ""
        
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    /// Função para exibir tela de onboarding
    private func showOnBoarding() {
        let controller = OnboardingViewController()
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.present(controller, animated: true)
    }
}

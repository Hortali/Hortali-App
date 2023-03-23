/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class SettingsController: UIViewController, SettingsProtocol {
    
    /* MARK: - Atributos */

    private let myView = SettingsView()
    
    
    /* Delegate & Data Sources */
    
    private let settingsDataSource = SettingsDataSource()
    
    private let settingsDelegate = SettingsDelegate()


		
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButtonsAction()
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
    
    
    
    /* MARK: - Ações de Botões */
    
    @objc
    private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupButtonsAction() {
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
    }
    

    private func setupDelegates() {
        self.settingsDelegate.setProtocol(with: self)
        
        self.myView.setCollectionDataSource(for: self.settingsDataSource)
        self.myView.setCollectionDelegate(for: self.settingsDelegate)
    }
    
    
    private func openLink(for index: Int) {
        let data = self.settingsDataSource.collectionData[index]
        let link = data.link ?? ""
        
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    private func showOnBoarding() {
        let controller = OnboardingViewController()
        controller.hidesBottomBarWhenPushed = true
        
        self.navigationController?.present(controller, animated: true)
    }
}

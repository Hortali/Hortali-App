/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de ver informações da Horta
class InfoGardenController: UIViewController, InfoGardenProtocol {
    
    /* MARK: - Atributos */

    /* View */

    /// View principal que a classe vai controlar
    private let myView = InfoGardenView()
    
    
    /* Delegate & Data Sources */
    
    /// Data Source da collection de informações da horta
    private let infoDataSource = InfoGardenInfosDataSource()
    
    /// Delegate da collection de informações da horta
    private let infoDelegate = InfoGardenInfosDelegate()
    
    
    /// Data Source da collection de imagens da horta
    private let imagesDataSource = InfoGardenImagesDataSource()
    
    /// Delegate da collection de imagens da horta
    private let imagesDelegate = InfoGardenImagesDelegate()
    


    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDelegates()
        self.setupButtonsAction()
    }
    


    /* MARK: - Protocolo */
    
    internal func updateCurrentPage(to index: Int) {
        self.myView.updateCurrentPage(for: index)
    }
	

    
    /* MARK: - Ações de botões */
    
    @objc
    private func backAction() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func favoriteAction() {
        
    }
    
    
    @objc
    private func showHourInfoPage() {
        let controller = UIViewController()
        controller.modalTransitionStyle = .coverVertical
        
        self.present(controller, animated: true)
    }
    
    
    
    /* MARK: - Configurações */

    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setFavoriteButtonAction(target: self, action: #selector(self.favoriteAction))
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.imagesDelegate.setProtocol(with: self)
        
        self.myView.setInfoDataSource(for: self.infoDataSource)
        self.myView.setInfoDelegate(for: self.infoDelegate)
        
        self.myView.setImagesDataSource(for: self.imagesDataSource)
        self.myView.setImagesDelegate(for: self.imagesDelegate)
    }
}

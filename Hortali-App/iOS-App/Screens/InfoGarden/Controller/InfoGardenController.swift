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
	
    
    internal func openHourInfoPage(for index: Int) {
        let controller = HourInfoController()
        controller.modalTransitionStyle = .coverVertical
        
        self.present(controller, animated: true)
    }

    
    
    /* MARK: - Ações de botões */
    
    /// Ação de voltar para a tela anterior
    @objc
    private func backAction() {
        self.dismiss(animated: true)
    }
    
    
    /// Ação de favoritar um card
    @objc
    private func favoriteAction() {
        
    }
    
    
    /// Ação de expandir uma label
    @objc
    private func expandLabelAction() {
        self.myView.expandLabel()
    }
    
    
    
    /* MARK: - Configurações */

    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setFavoriteButtonAction(target: self, action: #selector(self.favoriteAction))
        self.myView.setExpLabelButtonAction(target: self, action: #selector(self.expandLabelAction))
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.imagesDelegate.setProtocol(with: self)
        self.infoDelegate.setProtocol(with: self)
        
        self.myView.setInfoDataSource(for: self.infoDataSource)
        self.myView.setInfoDelegate(for: self.infoDelegate)
        
        self.myView.setImagesDataSource(for: self.imagesDataSource)
        self.myView.setImagesDelegate(for: self.imagesDelegate)
    }
}

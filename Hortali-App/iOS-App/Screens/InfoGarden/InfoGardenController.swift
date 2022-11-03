/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de ver informações da Horta
class InfoGardenController: UIViewController, InfoGardenProtocol {
    
    /* MARK: - Atributos */

    /* View */

    /// View principal que a classe vai controlar
    private var myView: InfoGardenView
    
    
    /* Delegate & Data Sources */
    
    /// Data Source da collection de informações da horta
    private let infoDataSource = InfoGardenInfosDataSource()
    
    /// Delegate da collection de informações da horta
    private let infoDelegate = InfoGardenInfosDelegate()
    
    
    /// Data Source da collection de imagens da horta
    private let imagesDataSource = InfoGardenImagesDataSource()
    
    /// Delegate da collection de imagens da horta
    private let imagesDelegate = InfoGardenImagesDelegate()
    
    
    /* Outros */
    
    /// Configurações para atualizar o estado de favoritos
    private var favUpdate: FavoriteUpdate
    
    
    
    /* MARK: - Construtor */
    
    init(with data: ManagedGarden) {
        self.myView = InfoGardenView(data: data)
        
        self.favUpdate = FavoriteUpdate(
            favoriteType: .garden,
            id: data.id,
            action: .add
        )
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupFavoriteStatus(for: data)
        self.setupDataSourcesData(for: data)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    


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
	
    
    internal func openHourInfoPage() {
        let data = self.infoDataSource.data?.hourInfo ?? []
        
        let controller = HourInfoController(with: data)
        controller.modalTransitionStyle = .coverVertical
        
        self.present(controller, animated: true)
    }
    
    
    internal func showNavigationOptions() {
        self.openPlaceOnNavigationApp()
    }
    
    
    internal func showContactOptions() {
        self.openContactOptions()
    }
    
    
    internal func openReportLink() {
        let link = "https://docs.google.com/forms/d/1o8-PFkMjBntnbzUXTayIU9jsDUX08ZvIXOKRv3KRqQw/viewform?edit_requested=true"
        
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    
    
    /* MARK: - Ações de botões */
    
    /// Ação de voltar para a tela anterior
    @objc
    private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /// Ação de favoritar um card
    @objc
    private func favoriteAction() {
        switch self.myView.isFavorited() {
        case true:
            self.favUpdate.action = .add
        case false:
            self.favUpdate.action = .remove
        }
        
        DataManager.shared.updateFavoriteList(for: self.favUpdate)
    }
    
    
    /// Ação de expandir uma label
    @objc
    private func expandLabelAction() {
        self.myView.expandLabel()
    }
    
    
    /// Mostra os possíveis contatos
    @objc
    private func openContactOptions() {
        guard let contacts = self.infoDataSource.data?.contacts else { return }
        
        // Verifica se é possível abrir os links
        var contactLinks: [Int:URL] = [:]
        for ind in 0..<contacts.count {
            if let url = URL(string: contacts[ind].link) {
                if UIApplication.shared.canOpenURL(url) {
                    contactLinks[ind] = url
                }
            }
        }
        
        // Cria o alerta
        let alert = UIAlertController(
            title: "Contatos",
            message: "Selecione uma opção contato",
            preferredStyle: .actionSheet
        )
        
        // Contatos
        for contact in contactLinks {
            var title = contacts[contact.0].type.capitalized
            if title == "Fone" {
                title = "Ligar"
            }
            let button = UIAlertAction(title: title, style: .default, handler: { _ in
                UIApplication.shared.open(contact.1, options: [:], completionHandler: nil)
            })
            alert.addAction(button)
        }
        
        
        // Cancelar a operação
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    
    /// Mostra o local em algum app de navegação
    @objc
    private func openPlaceOnNavigationApp() {
        guard let data = self.infoDataSource.data else { return }
        
        let latitude = data.latitude
        let longitude = data.longitude
        
        let navUrls: [String:String] = [
            "Apple Maps" : "http://maps.apple.com/?daddr=\(latitude),\(longitude)",
            "Google Maps" : "comgooglemaps://?daddr=\(latitude),\(longitude)&directionsmode=driving",
            "Waze" : "waze://?ll=\(latitude),\(longitude)&navigate=false"
        ]
        
        // Verifica se alguns dos apps existem no dispositivo do usuário
        var installedNavigationApps: [String:URL] = [:]
        
        for place in navUrls {
            if let url = URL(string: place.1) {
                if UIApplication.shared.canOpenURL(url) {
                    installedNavigationApps[place.0] = url
                }
            }
        }
        
        // Cria o alerta
        let alert = UIAlertController(
            title: "Navegação",
            message: "Selecione uma opção de navegação",
            preferredStyle: .actionSheet
        )
        
        // Aplicativos de navegação
        for app in installedNavigationApps {
            let button = UIAlertAction(title: app.0, style: .default, handler: { _ in
                UIApplication.shared.open(app.1, options: [:], completionHandler: nil)
            })
            alert.addAction(button)
        }
        
        // Copiar o endereço
        let address = UIAlertAction(title: "Copiar endereço", style: .default, handler: { _ in
            UIPasteboard.general.string = data.address
        })
        alert.addAction(address)
        
        // Cancelar a operação
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    
    /// Ação de quando altera a page control
    /// - Parameter sender: page control que foi alterada
    @objc
    private func pageControlAction(sender: UIPageControl) {
        self.myView.updateCurrentCell(for: sender.currentPage)
    }
    
    
    
    /* MARK: - Configurações */

    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setFavoriteButtonAction(target: self, action: #selector(self.favoriteAction))
        self.myView.setExpLabelButtonAction(target: self, action: #selector(self.expandLabelAction))
        self.myView.setPageControlAction(target: self, action: #selector(self.pageControlAction(sender:)))
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
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDataSourcesData(for data: ManagedGarden) {
        self.infoDataSource.data = data
        self.imagesDataSource.data = data.pageImages
        
        self.myView.reloadCollectionsData()
    }
    
    
    /// Configura a view pra caso for favorito
    /// - Parameter data: dado
    private func setupFavoriteStatus(for data: ManagedGarden) {
        for id in DataManager.shared.getFavoriteIds(for: .garden) {
            if data.id == id {
                let _ = self.myView.isFavorited(is: true)
                break
            }
        }
    }
}

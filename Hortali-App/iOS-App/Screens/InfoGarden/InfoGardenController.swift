/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de ver informações da Horta
class InfoGardenController: UIViewController, InfoGardenProtocol, ExpansiveLabelDelegate {
    
    /* MARK: - Atributos */

    /* View */

    private var myView: InfoGardenView
    
    
    /* Handlers & Delegates */
    
    private let infosCollectionHandler = InfoGardenInfosCollectionHandler()
    
    private let imagesCollectionHandler = InfoGardenImagesCollectionHandler()
    
    private let tagCollectionHandler: TagCollectionHandler = {
        let handler = TagCollectionHandler()
        handler.isSelectionAllowed = false
        return handler
    }()
    
    
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
        self.setNumberOfPageInPageControl()
    }
    
    
    
    /* MARK: - InfoGardenProtocol */
    
    internal func updateCurrentPage(to index: Int) {
        self.myView.updateCurrentPage(for: index)
    }
	
    
    internal func openHourInfoPage() {
        let data = self.infosCollectionHandler.data?.hourInfo ?? []
        
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
    
    
    
    /* MARK: - ExpansiveLabelProtocol */
    
    internal func actionWhenLabelWasExpanded() {
        self.myView.updateScrollSize()
    }
    
    
    
    /* MARK: - Ações de botões */
    
    @objc
    private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    private func favoriteAction() {
        let isFavorited = self.myView.favoriteHandler()
        self.favUpdate.action = isFavorited ? .add : .remove
        DataManager.shared.updateFavoriteList(for: self.favUpdate)
    }
    
    
    @objc
    private func expandLabelAction() {
        self.myView.expandLabel()
    }
    
    
    @objc
    private func openContactOptions() {
        guard let contacts = self.infosCollectionHandler.data?.contacts else { return }
        
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
    
    
    @objc
    private func openPlaceOnNavigationApp() {
        guard let data = self.infosCollectionHandler.data else { return }
        
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
            self.copyHandler(textToCopy: data.address)
        })
        alert.addAction(address)
        
        // Cancelar a operação
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    
    @objc
    private func pageControlAction(sender: UIPageControl) {
        self.myView.updateCurrentCell(for: sender.currentPage)
    }
    
    
    
    /* MARK: - Configurações */

    private func setNumberOfPageInPageControl() {
        let imagesCount = self.imagesCollectionHandler.getDataCount()
        self.myView.setNumbersOgPagesInPageControl(imagesCount)
    }
    
    
    private func setupButtonsAction() {
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setFavoriteButtonAction(target: self, action: #selector(self.favoriteAction))
        self.myView.setExpLabelButtonAction(target: self, action: #selector(self.expandLabelAction))
        self.myView.setPageControlAction(target: self, action: #selector(self.pageControlAction(sender:)))
    }
    
    
    private func setupDelegates() {
        self.setImagesCollectionHandler()
        self.setInfosCollectionHandler()
        self.setTagsCollectionHandler()
        self.setExpansiveLabelDelegate()
    }
    
    
    private func setInfosCollectionHandler() {
        self.infosCollectionHandler.setProtocol(with: self)
        
        let collection = self.myView.infosCollection
        self.infosCollectionHandler.link(with: collection)
    }
    
    
    private func setImagesCollectionHandler() {
        self.imagesCollectionHandler.setProtocol(with: self)
        
        let collection = self.myView.imagesCollection
        self.imagesCollectionHandler.link(with: collection)
    }
    
    
    private func setTagsCollectionHandler() {
        let tagCollection = self.myView.tagsCollection
        self.tagCollectionHandler.link(with: tagCollection)
    }
    
    
    private func setExpansiveLabelDelegate() {
        self.myView.setExpansiveLabelDelegate(self)
    }
    
    
    private func setupDataSourcesData(for data: ManagedGarden) {
        self.infosCollectionHandler.data = data
        self.imagesCollectionHandler.data = data.pageImages
        self.tagCollectionHandler.data = data.tags
        
        self.myView.reloadCollectionsData()
    }
    
    
    private func setupFavoriteStatus(for data: ManagedGarden) {
        let status = self.checkIfIsFavorited(gardenId: data.id)
        self.myView.favoriteHandler(for: status)
    }
    
    
    private func checkIfIsFavorited(gardenId: Int) -> Bool {
        let allFavoriteGardens = DataManager.shared.getFavoriteIds(for: .garden)
        let filter = allFavoriteGardens.filter() { $0 == gardenId }
        return !filter.isEmpty
    }
    
    
    private func copyHandler(textToCopy: String) {
        UIPasteboard.general.string = textToCopy
    }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class HourInfoController: UIViewController {
    
    /* MARK: - Atributos */

    private let myView = HourInfoView()
    
    
    /* Handler & Delegates */
    
    private let collectionHandler = HourInfoHandler()

    
    
    /* MARK: - Construtor */
    
    init(with data: [ManagedHourInfo]) {
        super.init(nibName: nil, bundle: nil)
        
        self.setupDataSourceData(for: data)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
        
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegates()
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupDelegates() {
        let collection = self.myView.hourInfoCollection
        self.collectionHandler.link(with: collection)
    }
    
    
    private func setupDataSourceData(for data: [ManagedHourInfo]) {
        self.collectionHandler.data = data
        self.reloadCollectionData()
    }
    
    
    private func reloadCollectionData() {
        self.myView.hourInfoCollection.reloadCollectionData()
    }
}

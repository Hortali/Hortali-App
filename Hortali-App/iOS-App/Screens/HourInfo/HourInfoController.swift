/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável por mostrar os horários de funcionamento das hortas
class HourInfoController: UIViewController {
    
    /* MARK: - Atributos */

    /// View principal que a classe vai controlar
    private let myView = HourInfoView()
    
    
    /* Delegate & Data Sources */
    
    /// Data source da collection de horários de funcionamento
    private let collectionDataSource = HourInfoDataSource()

    
    
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
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.myView.setDataSource(with: self.collectionDataSource)
    }
    
    
    /// Define os dados que vão aparecerna collection
    /// - Parameter data: dados da collection
    private func setupDataSourceData(for data: [ManagedHourInfo]) {
        self.collectionDataSource.data = data
        self.myView.reloadCollectionData()
    }
}

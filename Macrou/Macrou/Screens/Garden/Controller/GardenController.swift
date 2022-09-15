/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela principal de ver todas as hortas
class GardenController: UIViewController, GardenProtocol {
    
    
    /* MARK: - Atributos */
    
    /* View */
    
    /// View principal que a classe vai controlar
    private let myView = GardenView()
    
    
    /* Delegate & Data Sources */
    private let gardenDataSource = GardenDataSource()
    private let gardenDelegate = GardenDelegate()
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDelegates()
        self.setupButtonsAction()
        self.setupKeyboardHandler()
    }
    
    
    
    /* MARK: - Protocolo */
    
    func gardenProtocol() {
        
    }
    
    
    
    /* MARK: - Ações de botões */
    
    
    
    /* MARK: - Configurações */
    
    /// Função para retirar o teclado da tela
    @objc
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    ///Função parar reconhecer toque na tela e retirar o teclado ao ser clicado fora da search
    private func setupKeyboardHandler() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    ///  Delegate da célula
    private func setupDataSource() {
        
        self.myView.setDelegate(with: gardenDelegate)
    }
    
    /// DataSource da célula
    private func setupDelegates() {
        
        self.myView.setDataSource(with: gardenDataSource)
        
    }
}

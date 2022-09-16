/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela principal de ver todas as hortas
class GardenController: UIViewController {
    
    /* MARK: - Atributos */
    
    /* View */
    
    /// View principal que a classe vai controlar
    private let myView = GardenView()
    
    
    /* Delegate & Data Sources */
    
    /// dataSource das hortas
    private let gardenDataSource = GardenDataSource()
    
    
    
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
    
    
    /* MARK: Ações de botões*/
    /// Função para retirar o teclado da tela
    @objc
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    /* MARK: - Configurações */
    
    ///Função parar reconhecer toque na tela e retirar o teclado ao ser clicado fora da search
    private func setupKeyboardHandler() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.myView.setDataSource(with: gardenDataSource)
    }
}

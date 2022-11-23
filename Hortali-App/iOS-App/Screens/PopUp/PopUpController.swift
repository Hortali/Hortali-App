/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pelo pop up
class PopUpController: UIViewController {
    
    /* MARK: - Atributos */

    /// View principal que a classe vai controlar
    private var myView: PopUpView

    
    
    /* MARK: - Atributos */
    
    init(infos: PopUpInfo) {
        self.myView = PopUpView(info: infos)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
		
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupButtonsAction()
    }
    

    
    /* MARK: - Ações de botões */
    
    /// Ação de fechar o pop up
    @objc
    private func closeAction() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    
    
    /* MARK: - Configurações */

    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        self.myView.setCloseButtonAction(target: self, action: #selector(self.closeAction))
    }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela tela de onboarding
class OnboardingViewController: UIViewController, OnboardingProtocol{
    
    /* MARK: - Atributos */
    
    /// Muda a cor da status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if UserDefaults.getValue(for: .onBoardingPresented) {
            return .lightContent
        }
        return .darkContent
    }
    
    
    /* View */

    private let myView = OnboardingView()
    
    
    /* handlers & Delegate */
    
    private let onBoardingCollectionHandler = OnBoardingCollectionHandler()
    

        
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
         self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDelegates()
        self.setupButtonsAction()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.myView.setupToInitialState()
    }
    


    /* MARK: - Protocolo */
    
    internal func updateCurrentPage(to index: Int) {
        self.myView.updateCurrentPage(for: index)
    }
    

    
    /* MARK: - Ações de botões */
    
    @objc
    private func closeAction() {
        UserDefaults.setValue(true, forKey: .onBoardingPresented)
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true)
        self.dismiss(animated: true)
    }
    
    
    @objc
    private func backAction() {
        let currentPage = self.myView.currentPage - 1
        
        self.myView.updateCurrentCell(for: currentPage)
        self.myView.updateCurrentPage(for: currentPage)
    }
    
    
    @objc
    private func nextAction() {
        let currentPage = self.myView.currentPage + 1
        
        if currentPage == self.onBoardingCollectionHandler.totalPages {
            self.closeAction()
        } else {
            self.myView.updateCurrentCell(for: currentPage)
            self.myView.updateCurrentPage(for: currentPage)
        }
    }
    
    
    @objc
    private func pageControlAction(sender: UIPageControl) {
        self.myView.updateCurrentCell(for: sender.currentPage)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupButtonsAction() {
        self.myView.setCloseButtonAction(target: self, action: #selector(self.closeAction))
        self.myView.setPageControlAction(target: self, action: #selector(self.pageControlAction(sender:)))
        self.myView.setBackButtonAction(target: self, action: #selector(self.backAction))
        self.myView.setNextButtonAction(target: self, action: #selector(self.nextAction))
    }
    
    
    private func setupDelegates() {
        self.onBoardingCollectionHandler.setProtocol(with: self)
        
        let collection = self.myView.onBoardingCollection
        self.onBoardingCollectionHandler.link(with: collection)
    }
}

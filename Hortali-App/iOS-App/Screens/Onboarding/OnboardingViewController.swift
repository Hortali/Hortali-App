/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class OnboardingViewController: UIViewController, OnboardingProtocol {
    
    /* MARK: - Atributos */
    
    // Muda a cor da status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if CDManager.shared.checkIsFirstTime() {
            return .darkContent
        }
        return .lightContent
    }
    
    
    /* View */

    private let myView = OnboardingView()
    
    
    /* Handlers & Delegate */
    
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
        self.notifyViewThatHasAppeared()
    }
    


    /* MARK: - Protocolo */
    
    internal func updateCurrentPage(to index: Int) {
        self.myView.updateCurrentPage(for: index)
    }
    

    
    /* MARK: - Ações de botões */
    
    @objc
    private func closeAction() {
        self.saveOnBordingHasBeenPresented()
        self.dismissController()
    }
    
    
    @objc
    private func backAction() {
        let currentPage = self.myView.currentPage - 1
        self.updateCurrentPage(currentPage)
    }
    
    
    @objc
    private func nextAction() {
        let currentPage = self.myView.currentPage + 1
        
        if currentPage == self.onBoardingCollectionHandler.totalPages {
            self.closeAction()
        } else {
            self.updateCurrentPage(currentPage)
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
    
    
    private func saveOnBordingHasBeenPresented() {
        CDManager.shared.confirmOnBoardingHasShowed()
    }
    
    
    private func dismissController() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true)
        self.dismiss(animated: true)
    }
    
    
    private func updateCurrentPage(_ page: Int) {
        self.myView.updateCurrentCell(for: page)
        self.myView.updateCurrentPage(for: page)
    }
    
    
    private func notifyViewThatHasAppeared() {
        self.myView.viewHasAppeared = true
    }
}

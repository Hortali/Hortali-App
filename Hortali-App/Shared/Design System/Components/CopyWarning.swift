/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class CopyWarning: ViewLabel {
    
    /* MARK: - Encapsulamento */
    
    public func createConstraints() -> [NSLayoutConstraint] {
        guard let superview else { return [] }
        let safeArea = superview.safeAreaLayoutGuide
        let bottomSpace: CGFloat = 10
        
        let constraints = [
            self.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -bottomSpace),
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            self.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.7),
        ]
        return constraints
    }
    
    
    public func showCopyWarning() -> Void {
        self.showCopyWarningView()
        self.dismissCopyWarningView()
    }
    
    
    
    /* MARK: - Configurações */
    
    private func showCopyWarningView() {
        UIView.transition(
            with: self, duration: 0.5, options: .transitionCrossDissolve,
            animations: { self.isHidden = false }
        )
    }
    
    
    private func dismissCopyWarningView() {
        let delay: TimeInterval = 3
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.isHidden = true
        }
    }
    
    
    
    /* MARK: - ViewCode */
    
    override func setupView() {
        self.isHidden = true
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(originalColor: .greenLight)
        self.label.textColor = UIColor(originalColor: .greenDark)
    }
    
    
    override func setupFonts() {
        let fontSize = self.superview?.getEquivalent(15) ?? 15
        
        self.label.setupText(with: FontInfo(
            fontSize: fontSize, weight: .medium
        ))
    }
    
    override func setupStaticTexts() {
        self.label.text = "Texto copiado para área de tranferência"
    }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.NSCoder
import class UIKit.NSLayoutConstraint

import class UIKit.UIView
import class UIKit.UILabel
import struct CoreGraphics.CGFloat


/// Uma view que possui uma label dentro
///
/// Esse componente é usado principalemente pra cliar uma label que não fique grudada na borda dela
class ViewLabel: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    private lazy var label: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    

    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Texto da label
    public var text: String = "" {
        didSet {
            self.label.text = text
        }
    }
    
    
    /// Configrua a fonte da label
    /// - Parameter font: informações da fonte
    public func setupText(with font: FontInfo) {
        self.label.setupText(with: font)
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.label)
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupConstraints() {
        let space: CGFloat = 5
    
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space)
        ])
    }
}

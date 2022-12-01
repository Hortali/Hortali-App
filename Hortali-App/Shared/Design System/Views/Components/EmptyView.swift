/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

/// Componentes de toda tela vazia.
class EmptyView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    private var titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(originalColor: .greyButton)
        
        return lbl
    }()
    
    public var dynamicLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(originalColor: .greyButton)
        
        return lbl
    }()
    
    private var contentView = CustomViews.newView()
    
    // Outros
    
    /// Textos das labels que mudam de acordo com a tela.
    private func setupText(style: EmptyTexts){
        self.dynamicLabel.text = style.text
    }
        
        
        /// Constraints que vão mudar de acordo com o tamanho da tela
        private var dynamicConstraints: [NSLayoutConstraint] = []
        
        
        
        /* MARK: - Construtor */
        
        init(emptyViewType: EmptyTexts? = nil) {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.setupText(style: emptyViewType ?? .search)
            self.setupViews()
        }
        
        required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
        
        
        /* MARK: - Encapsulamento */
        
        /* Ações dos Botões */
        
        
        
        /* MARK: - Ciclo de Vida */
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            self.setupUI()
            self.setupStaticTexts()
            self.setupDynamicConstraints()
        }
        
        
        
        /* MARK: - Configurações */
        
        /* Geral */
        
        /// Adiciona os elementos (Views) na tela
        private func setupViews() {
            self.addSubview(contentView)
            self.contentView.addSubview(titleLabel)
            self.contentView.addSubview(dynamicLabel)
        }
        
        
        /// Personalização da UI
        private func setupUI() {
            self.backgroundColor = .clear
        }
        
        
        /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
        private func setupStaticTexts() {
            self.titleLabel.setupText(with: FontInfo(text: "OPS", fontSize: 32, weight: .bold))
            self.titleLabel.font = UIFont(name: "AmsterdamGraffiti", size: 52)
        }
        
        
        /// Define as constraints que dependem do tamanho da tela
        private func setupDynamicConstraints() {
            NSLayoutConstraint.deactivate(self.dynamicConstraints)
            
            self.dynamicConstraints = [
                self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
                self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                
                self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                
                self.dynamicLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
                self.dynamicLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            ]
            
            NSLayoutConstraint.activate(self.dynamicConstraints)
        }
    }

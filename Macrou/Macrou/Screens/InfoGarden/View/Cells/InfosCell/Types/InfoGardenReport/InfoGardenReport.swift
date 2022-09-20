/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Conteúdo da célula para reportar algum problema da horta
class InfoGardenReport: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    /// Imagem de reportar
    private let imageReport = CustomViews.newImage()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
        
        
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupInfo()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura as informaçòes dessa view
    private func setupInfo() {
        self.imageReport.image = UIImage(appImage: .report)
    }

    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.imageReport)
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.imageReport.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageReport.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageReport.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageReport.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}

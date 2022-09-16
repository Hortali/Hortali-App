/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Célula para reportar algo
class InfoGardenReportCell: UIView {
    
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
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    

    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.imageReport)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        let imageName = "ReportIcon"
        let image = UIImage(named: imageName)
        
        if let image = image {
            print("A imagem criou")
        }
        self.imageReport.image = image
    }
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.imageReport.topAnchor.constraint(equalTo: self.bottomAnchor),
            self.imageReport.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageReport.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageReport.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Célula que mostra as informações da tela de ver as inforações das hortas
class SettingsCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    // Views
    
    /// Título da célula
    private let titleLabel = CustomViews.newLabel()
    
    /// Espaço para colocar as informações da célula
    private let container: UIView = {
        let view = CustomViews.newView()
        view.layer.masksToBounds = true
        return view
    }()
    
    ///
    private var iconImage = CustomViews.newImage()
    
    ///
    private var subTitleLabel = CustomViews.newLabel()
    
    ///
    private var descriptionLabel = CustomViews.newLabel()
        
    
    // Outros
    
    /// Identificador da célula
    static let identifier = "IdSettingsCell"
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o tipo da célula
    public func setupCell(with data: SettingsData) {
        self.titleLabel.text = data.title
        self.subTitleLabel.text = data.subTitle
        self.descriptionLabel.text = data.description
        
        self.container.backgroundColor = UIColor(data.color)
        self.iconImage.image = UIImage(data.icon)
    }
    
    

    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
          
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.container)
        
        self.container.addSubview(self.iconImage)
        self.container.addSubview(self.subTitleLabel)
        self.container.addSubview(self.descriptionLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.container.layer.cornerRadius = self.getConstant(for: 15)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.titleLabel.setupText(with: FontInfo(
            fontSize: self.getConstant(for: 25), weight: .medium
        ))
        
        let labelFont: CGFloat = self.getConstant(for: 15)
        
        self.subTitleLabel.setupText(with: FontInfo(
            fontSize: labelFont, weight: .bold
        ))
        
        self.descriptionLabel.setupText(with: FontInfo(
            fontSize: labelFont, weight: .medium
        ))
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getConstant(for: 15)
        let between: CGFloat = self.getConstant(for: 12)
        
        let labelHeight: CGFloat = self.getConstant(for: 25)
        let betweenLabels: CGFloat = self.getConstant(for: 8)
        
        let spaceLeft = (self.subTitleLabel.frame.origin.y - self.container.frame.origin.y)/2
        
        // 40 x 40
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            
            self.container.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between),
            self.container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -lateral),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: lateral),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -lateral),
            
            
            self.subTitleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -betweenLabels),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.descriptionLabel.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.descriptionLabel.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    /// Responsável por pegar o valor referente à célula
    /// - Parameter space: valor para ser convertido
    /// - Returns: valor em relação à tela
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 360, height: 165),
            dimension: .width
        )
        
        return self.getEquivalent(space, screenReference: screenReference)
    }
}

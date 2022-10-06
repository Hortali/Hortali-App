/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import MapKit


/// Conteúdo da célula para mostrar o local
class InfoGardenMap: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    /// Mapa
    private let mapView: MKMapView = CustomViews.newMap()
    
    /// Endereço da rua
    private let addressLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor(.viewBack)?.withAlphaComponent(0.6)
        return lbl
    }()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
		
		
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.DADOS_TESTE()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    

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
        self.addSubview(self.mapView)
        self.addSubview(self.addressLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.addressLabel.layer.cornerRadius = self.getConstant(for: 10)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {		
        self.addressLabel.setupText(with: FontInfo(
            fontSize: self.getConstant(for: 20), weight: .regular
        ))
    }
	  
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
        let lateral: CGFloat = self.getConstant(for: 10)
        
        let labelHeight: CGFloat = self.getConstant(for: 35)
        
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.mapView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.addressLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            self.addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.addressLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -lateral),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    /// Responsável por pegar o valor referente à célula
    /// - Parameter space: valor para ser convertido
    /// - Returns: valor em relação à tela
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 350, height: 160),
            dimension: .width
        )
        
        return self.getEquivalent(space, screenReference: screenReference)
    }
    
    
    private func DADOS_TESTE() {
        self.addressLabel.text = "R: Pacaratu, 66 - Parque Imperial, SP"
    }
}

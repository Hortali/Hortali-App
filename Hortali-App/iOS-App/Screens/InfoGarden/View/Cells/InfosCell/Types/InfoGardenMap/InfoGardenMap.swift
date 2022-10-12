/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import MapKit


/// Conteúdo da célula para mostrar o local
class InfoGardenMap: UIView, InfoGardenCellProtocol {
    
    /* MARK: - Atributos */

    // Views
    
    /// Vosualização do mapa
    private let mapView: UIImageView = CustomViews.newImage()
    
    /// Endereço da rua
    private let addressLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.backgroundColor = UIColor(.viewBack)?.withAlphaComponent(0.6)
        return lbl
    }()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    // Data info
    
    
    private var pin: MKPointAnnotation?
		
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Protocol */
    
    internal func setupView(for data: ManagedGarden) {
        self.addressLabel.text = data.address
        
        let pin = MKPointAnnotation()
        pin.coordinate = data.coords!
        pin.title = data.name
        pin.subtitle = data.address
        
        self.pin = pin
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupMap()
    }
    
    
    
    /* MARK: - Configurações */
    
    // Mapa
    
    /// Configura o print do mapa
    private func setupMap() {
        guard self.mapView.bounds.size != .zero else { return }
        guard let pin = self.pin else { return }
        
        let option = MKMapSnapshotter.Options()
        option.showsBuildings = true
        
        // Zoom
        let radius: CLLocationDistance = 600
        let region = MKCoordinateRegion(
            center: pin.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        
        option.region = region
        option.region.center = pin.coordinate
        
        // Tamanho
        let gap: CGFloat = 50
        option.size = CGSize(width: self.mapView.bounds.width+gap, height: self.mapView.bounds.height+gap)
        
        // Print do mapa
        let snapshot = MKMapSnapshotter(options: option)
        snapshot.start { snapshot, error in
            if error != nil {
                return
            }
            
            if let snapshot {
                UIGraphicsBeginImageContextWithOptions(option.size, true, snapshot.traitCollection.displayScale)
                snapshot.image.draw(at: .zero)
                
                let snapshotPin = snapshot.point(for: pin.coordinate)

                // Desenhando o pin na imagem
                let annotationView = MKMarkerAnnotationView(annotation: pin, reuseIdentifier: "")
    
                let pinSize: CGFloat = 35   // Tamanho padrão do pin: 40
                annotationView.bounds = CGRect(x: 0, y: 0, width: pinSize, height: pinSize)
                annotationView.contentMode = .scaleAspectFit
                
                annotationView.drawHierarchy(
                    in: CGRect(
                    x: snapshotPin.x, y: snapshotPin.y,
                    width: annotationView.bounds.size.width, height: annotationView.bounds.size.height),
                    afterScreenUpdates: true
                )
                
                // Gerando a imagem
                let drawnImagem = UIGraphicsGetImageFromCurrentImageContext()
                
                self.mapView.image = drawnImagem
                self.mapView.layer.contentsRect = CGRectMake(0.175, 0.3, 0.72, 0.72)
                self.mapView.contentMode = .scaleAspectFill
            }
        }
    }
    
    
    // View

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
}




/*
 
private let mapView: MKMapView = CustomViews.newMap()
 
private func setupMap(with data: ManagedGarden) {
    self.addressLabel.text = data.address
    
    if let coord = data.coords {
        self.setZoom(for: coord)
        self.addPin(for: coord, name: data.name)
    }
}


private func setZoom(for coord: CLLocationCoordinate2D) {
    let radius: CLLocationDistance = 400
    
    let region = MKCoordinateRegion(
        center: coord,
        latitudinalMeters: radius,
        longitudinalMeters: radius
    )
    self.mapView.setRegion(region, animated: true)
}


private func addPin(for coord: CLLocationCoordinate2D, name: String) {
    let pin = MKPointAnnotation()
    pin.coordinate = coord
    pin.title = name
    self.mapView.addAnnotation(pin)
}
*/

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import MapKit


class InfoGardenMap: ViewWithViewCode, InfoGardenCellProtocol {
    
    /* MARK: - Atributos */

    private let mapView: UIImageView = CustomViews.newImage()
    
    private let addressLabel: ViewLabel = {
        let lbl = ViewLabel()
        lbl.backgroundColor = UIColor(.viewBack)?.withAlphaComponent(0.6)
        lbl.label.numberOfLines = 3
        
        return lbl
    }()
    
    
    // Outros
    
    private var pin: MKPointAnnotation?
		


    /* MARK: - Protocol */
    
    internal func setupView(for data: ManagedGarden) {
        self.setAddressInfo(data.address)
        self.createPin(from: data)
    }
    
    
    private func setAddressInfo(_ address: String) {
        self.addressLabel.label.text = address
    }
    
    
    private func createPin(from data: ManagedGarden) {
        let pin = MKPointAnnotation()
        pin.coordinate = data.coords!
        pin.title = data.name
        pin.subtitle = data.address
        self.pin = pin
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setupMap()
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupMap() {
        guard self.mapView.bounds.size != .zero else { return }
        guard let pin else { return }
        
        let screenShotCreator = ScreenShotFromMapCreation(viewBounds: self.mapView.bounds, pin: pin)
        screenShotCreator.createScreenShot() { image, _ in
            self.setupMapView(image: image)
        }
    }
    
    
    private func setupMapView(image: UIImage?) {
        self.mapView.image = image
        self.mapView.layer.contentsRect = CGRectMake(0.175, 0.3, 0.72, 0.72)
        self.mapView.contentMode = .scaleAspectFill
    }
    
    
    
    /* MARK: - ViewCode */

    override func setupHierarchy() {
        self.addSubview(self.mapView)
        self.addSubview(self.addressLabel)
    }
    
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func setupUI() {
        self.addressLabel.layer.cornerRadius = self.getConstant(for: 10)
    }
    
    
    override func setupFonts() {
        self.addressLabel.label.setupFont(with: FontInfo(
            fontSize: self.getConstant(for: 15), weight: .regular
        ))
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = self.mapView.strechToBounds(of: self)
        return constraints
    }
    
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getConstant(for: 10)
        
        let labelHeight: CGFloat = self.getConstant(for: 50)

        self.dynamicConstraints = [
            self.addressLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            self.addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.addressLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -lateral),
        ]
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 163, height: 163),
            dimension: .width
        )
        return self.getEquivalent(space, screenReference: screenReference)
    }
}

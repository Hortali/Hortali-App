/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import MapKit


class ScreenShotFromMapCreation {
    
    let viewBounds: CGRect
    
    let pin: MKPointAnnotation
    
    init(viewBounds: CGRect, pin: MKPointAnnotation) {
        self.viewBounds = viewBounds
        self.pin = pin
    }
    
    
    public func createScreenShot(_ handler: @escaping (UIImage?, Error?) -> Void) {
        let mapInfos = self.createInfosForMap()
        self.setupMapScreenShot(with: mapInfos) { image, error in
            handler(image, error)
        }
    }
    
    
    private func setupMapScreenShot(with mapInfos: MKMapSnapshotter.Options, _ handler: @escaping (UIImage?, Error?) -> Void) {
        let snapshot = MKMapSnapshotter(options: mapInfos)
        snapshot.start { snapshot, error in
            guard error.isNil else { return handler(nil, error) }
            guard let snapshot else { return handler(nil, nil) }
            
            let imageCreated = self.createImageFromSnapshot(snapshot, size: mapInfos.size)
            handler(imageCreated, nil)
        }
    }
    
    
    private func createInfosForMap() -> MKMapSnapshotter.Options {
        let option = MKMapSnapshotter.Options()
        self.setGeneralOptions(option)
        self.setRegionOnMap(option)
        self.setMapSize(option)
        return option
    }
    
    
    private func setGeneralOptions(_ info: MKMapSnapshotter.Options) {
        info.showsBuildings = true
    }
    
    
    private func setRegionOnMap(_ info: MKMapSnapshotter.Options) {
        let radius: CLLocationDistance = 600
        let region = MKCoordinateRegion(
            center: self.pin.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        
        info.region = region
        info.region.center = self.pin.coordinate
    }
    
    
    private func setMapSize(_ info: MKMapSnapshotter.Options) {
        /*
         Ao tirar um print do mapa ele não fica centralizado. Quando da um zoom no mapa
         ele fica com as bordas borradas. Esse espaço a mais pega extamente a área que
         não fica borrada
         */
        let gap: CGFloat = 50
        info.size = CGSize(
            width: self.viewBounds.width + gap,
            height: self.viewBounds.height + gap
        )
    }
    
    
    private func createImageFromSnapshot(_ snapshot: MKMapSnapshotter.Snapshot, size: CGSize) -> UIImage? {
        self.startBitmapImageCreation(snapshot, size: size)
        self.drawImageOnSnapshot(snapshot)
        
        let pinPoints = self.setPinOnSnapshot(snapshot)
        self.drawPinOnMapImage(imagePinPoint: pinPoints)
        
        let imageCreated = self.finishBitmapImageCreation()
        return imageCreated
    }
    
    
    private func startBitmapImageCreation(_ snapshot: MKMapSnapshotter.Snapshot, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, true, snapshot.traitCollection.displayScale)
    }
    
    
    private func drawImageOnSnapshot(_ snapshot: MKMapSnapshotter.Snapshot) {
        snapshot.image.draw(at: .zero)
    }
    
    
    private func setPinOnSnapshot(_ snapshot: MKMapSnapshotter.Snapshot) -> CGPoint {
        let pinPoint = snapshot.point(for: self.pin.coordinate)
        return pinPoint
    }
    
    
    private func drawPinOnMapImage(imagePinPoint: CGPoint) {
        let annotationView = MKMarkerAnnotationView(annotation: self.pin, reuseIdentifier: "")

        let pinSize: CGFloat = 35
        annotationView.bounds = CGRect(x: 0, y: 0, width: pinSize, height: pinSize)
        annotationView.contentMode = .scaleAspectFit
        
        annotationView.drawHierarchy(
            in: CGRect(
                x: imagePinPoint.x,
                y: imagePinPoint.y,
                width: annotationView.bounds.size.width,
                height: annotationView.bounds.size.height
            ),
            afterScreenUpdates: true
        )
    }
    
    
    private func finishBitmapImageCreation() -> UIImage? {
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

/// Conteúdo da célula para mostrar o local
class InfoGardenMap: ViewWithViewCode, InfoGardenCellProtocol {
    
    /* MARK: - Atributos */

    // Views
    
    private let mapView: UIImageView = CustomViews.newImage()
    
    private let addressLabel: ViewLabel = {
        let lbl = ViewLabel()
        lbl.backgroundColor = UIColor(.viewBack)?.withAlphaComponent(0.6)
        lbl.label.numberOfLines = 3
        
        return lbl
    }()
    
    
    // Data info
    
    /// Ponto no mapa
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

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import MapKit


struct ScreenShotFromMapCreation {
    
    /* MARK: - Atributos */
    
    let viewBounds: CGRect
    
    let pin: MKPointAnnotation
    
    
    
    /* MARK: - Construtor */
    
    init(viewBounds: CGRect, pin: MKPointAnnotation) {
        self.viewBounds = viewBounds
        self.pin = pin
    }
    
    
    
    /* MARK: - Encapsulamento */
    
    public func createScreenShot(_ handler: @escaping (UIImage?, Error?) -> Void) {
        let mapInfos = self.createInfosForMap()
        self.setupMapScreenShot(with: mapInfos) { image, error in
            handler(image, error)
        }
    }
    
    
    
    /* MARK: - Configurações */
    
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

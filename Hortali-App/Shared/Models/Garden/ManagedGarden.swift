/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import struct CoreLocation.CLLocationCoordinate2D


/// Modelo de dados das hortas
struct ManagedGarden: Codable {
    let id: Int
    
    let name: String
    let biograph: String
    
    let address: String
    let latitude: Double
    let longitude: Double
    
    var isFavorited: Bool?
    
    let coverImage: ManagedImage
    let pageImages: [ManagedImage]
    let contacts: [ManagedContact]
    let hourInfo: [ManagedHourInfo]
    
    var coords: CLLocationCoordinate2D? {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}

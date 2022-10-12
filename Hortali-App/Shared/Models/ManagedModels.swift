/* Macro - Grupo 05 */

import struct CoreLocation.CLLocationCoordinate2D


struct ManagedGardenData: Codable {
    let count: Int
    let gardens: [ManagedGarden]
}


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



struct ManagedContact: Codable {
    let id: Int?
    let type: String
    let contact: String
    let link: String
    let description: String
}



struct ManagedImage: Codable {
    let id: Int?
    let name: String
    let type: String?
}



struct ManagedHourInfo: Codable {
    let id: Int?
    let status: Bool
    let week: String
    let startTime: String
    let endTime: String
}




struct ManagedFoodData: Codable {
    let count: Int
    let foods: [ManagedFood]
}



struct ManagedFood: Codable {
    let id: Int
    
    let name: String
    let category: String
    let benefits: String
    let minerals: String
    
    var isFavorited: Bool?
    
    let vitamins: [ManagedVitamins]
    let coverImage: ManagedImage
    let pageImage: ManagedImage
}



struct ManagedVitamins: Codable {
    let id: Int?
    let name: String
}

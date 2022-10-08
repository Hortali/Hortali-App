/* Macro - Grupo 05 */


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
    
    let coverImage: ManagedImage
    let pageImages: [ManagedImage]
    let contacts: [ManagedContact]
    let hourInfo: [ManagedHourInfo]
}



struct ManagedContact: Codable {
    let type, contact: String
    let link: String
}



struct ManagedImage: Codable {
    let name: String
}



struct ManagedHourInfo: Codable {
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
    let cateogory: String
    let benefits: String
    let minerals: String
    
    let vitamins: [ManagedVitamins]
    let coverImage: ManagedImage
    let pageImage: ManagedImage
}



struct ManagedVitamins: Codable {
    let name: String
}

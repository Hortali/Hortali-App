/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */


extension CDManager {
    
    public func getAllCategories() -> [String] {
        guard let allData = self.categorieCDM.allData else { return [] }
        let categories = allData.map() { CategorieCDM.transformToModel(entity: $0).name }
        return categories
    }
    
    
    public func getFoodsByCategorie(_ name: String) -> [ManagedFood] {
        guard let categorie = self.categorieCDM.getDataByName(name) else { return [] }
        let foodData = self.categorieCDM.getFoodsEntityByCategorie(categorie)
        
//        let data = foodData.map() { FoodCDM.transformToModel(entity: $0) }
        return [] //foodData
    }
}

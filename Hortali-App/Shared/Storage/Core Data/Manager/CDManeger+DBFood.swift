/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */


extension CDManager {
    
    public func getFoodData() -> [ManagedFood] {
        let data = self.foodCDM.allData
//        let model = data.map() { FoodCDM.transformToModel(entity: $0) }
        return [] //model
    }
    
    
    public func addNewFood(_ data: ManagedFood) {
        self.foodCDM.createIfNeeded(data: data)
    }
    
    
    public func updateFoodData(newData: ManagedFood) {
        self.foodCDM.updateData(with: newData)
    }
    
    
    public func deleteFoodData(data: ManagedFood) {
        self.foodCDM.deleteData(id: data.id)
    }
    
    
    public func getFoodsFavorited() -> [ManagedFood] {
        let data = self.foodCDM.getFavoritedDatas()
//        let model = data.map() { FoodCDM.transformToModel(entity: $0) }
        return [] //model
    }
    
    
    public func updateFoodFavoriteStatus(food: ManagedFood, status: Bool? = nil) {
        self.foodCDM.updateDataFavoriteStatus(id: food.id, isFavorited: status)
    }
}

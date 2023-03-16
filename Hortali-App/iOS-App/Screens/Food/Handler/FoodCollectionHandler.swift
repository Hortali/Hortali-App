/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class FoodCollectionHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    private var mainData: [ManagedFood] = []

    private weak var foodProtocol: FoodProtocol?
    
    
    
    /* MARK: - Encapsulamento */
    
    public var data: [ManagedFood] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    public func setProtocol(with delegate: FoodProtocol) {
        self.foodProtocol = delegate
    }
    
    
    
    /* MARK: - Protocolo */
    
    func registerCell(in collection: UICollectionView) {
        collection.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.identifier)
    }
    
    
    func setupFlowLayoutSettings(_ collection: CustomCollection) {
        
    }
    
    
    
    /* MARK: - Data Sources */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCell.identifier, for: indexPath) as? FoodCell else {
            return UICollectionViewCell()
        }
        
        let data = self.mainData[indexPath.row]
        cell.setupCell(for: data)
        
        return cell
    }
    
    
    
    /* MARK: - Delegate */
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.foodProtocol?.openFoodInfo(for: indexPath.row)
    }
    
}

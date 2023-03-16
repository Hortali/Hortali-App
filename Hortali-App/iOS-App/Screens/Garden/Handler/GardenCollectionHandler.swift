/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class GardenCollectionHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    private var mainData : [ManagedGarden] = []

    private weak var gardenProtocol: GardenProtocol?
    
    
    
    /* MARK: - Encapsulamento */
    
    public var data: [ManagedGarden] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    public func setProtocol(with delegate: GardenProtocol) {
        self.gardenProtocol = delegate
    }
    
    
    
    /* MARK: - Protocolo */
    
    func registerCell(in collection: UICollectionView) {
        collection.register(GardenCell.self, forCellWithReuseIdentifier: GardenCell.identifier)
    }
    
    func setupFlowLayoutSettings(_ collection: CustomCollection) {
        
    }
    
    
    
    /* MARK: - Data Sources */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GardenCell.identifier, for: indexPath) as? GardenCell else {
            return UICollectionViewCell()
        }
        
        let actualData = self.mainData[indexPath.row]
        cell.setupCell(for: actualData)
        
        return cell
    }
    
    
    
    /* MARK: - Delegate */
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.gardenProtocol?.openGardenInfo(for: indexPath.row)
    }
}

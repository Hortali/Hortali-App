/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data source da colelction das hortas
class GardenDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    
    /// Dados usados no data source
    private var mainData : [ManagedGarden] = []
    
    /// Dados que estão sendo usados no dados source
    public var data: [ManagedGarden] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainData.count
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GardenCell.identifier, for: indexPath) as? GardenCell else {
            return UICollectionViewCell()
        }
        
        let actualData = self.mainData[indexPath.row]
        cell.setupCell(for: actualData)
        
        return cell
    }
}

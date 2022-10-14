/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data source da collection de mostrar os alimentos
class FoodDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    
    /// Dados usados no data source
    private var mainData : [ManagedFood] = []
    
    /// Dados que estão sendo usados no dados source
    public var data: [ManagedFood] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    
    /* MARK: - Data Source */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainData.count
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCell.identifier, for: indexPath) as? FoodCell else {
            return UICollectionViewCell()
        }
        
        let data = self.mainData[indexPath.row]
        cell.setupCell(for: data)
        
        return cell
    }
}

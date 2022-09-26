/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class GardenDataSource: NSObject, UICollectionViewDataSource {
    
    var data: [String] = ["Horta_01", "Horta_02", "Horta_03"]
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GardenCell.identifier, for: indexPath) as? GardenCell else {
            return UICollectionViewCell()
        }
        
        let imageName = self.data[indexPath.row]
        cell.setupCell(for: imageName)
        
        return cell
    }
}

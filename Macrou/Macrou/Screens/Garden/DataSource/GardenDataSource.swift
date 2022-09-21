/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class GardenDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GardenCell.identifier, for: indexPath) as? GardenCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

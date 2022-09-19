/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class FoodCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCell.identifier, for: indexPath) as? FoodCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

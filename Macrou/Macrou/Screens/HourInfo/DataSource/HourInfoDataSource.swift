/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class HourInfoDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Data Sources */
    
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourInfoCell.identifier, for: indexPath) as? HourInfoCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

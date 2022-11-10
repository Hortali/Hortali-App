/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data source da colelction das hortas
class OnboardingDataSource: NSObject, UICollectionViewDataSource {
    
    let data: Int = 4
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data
        
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        let currentPage = self.data
        
        return cell
    }
}

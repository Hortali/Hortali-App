/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class GardenDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    
    private weak var gardenProtocol: GardenProtocol?
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
    }
    
    
    /* MARK: - Encapsulamento */
    internal func setProtocol(with gProtocol: GardenProtocol) {
        self.gardenProtocol = gProtocol
    }
    
    
    
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
        
        //        let row = indexPath.row
        
        return cell
    }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data source da collection de informações de uma horta da tela de info garden
class InfoGardenInfosDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */

    /// Dados usados no data source
    private var mainData: ManagedGarden?
        
    /// Dados que estão sendo usados no dados source
    public var data: ManagedGarden? {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    /* MARK: - Data Source */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    /// Faz a configuração de cada célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoGardenInfosCell.identifier, for: indexPath) as? InfoGardenInfosCell else {
            return UICollectionViewCell()
        }
        
        if let data {
            switch indexPath.row {
            case 0: cell.setupCell(for: .map, with: data)
            case 1: cell.setupCell(for: .time, with: data)
            case 2: cell.setupCell(for: .contact, with: data)
            default: break
            }
        }
        
        return cell
    }
}

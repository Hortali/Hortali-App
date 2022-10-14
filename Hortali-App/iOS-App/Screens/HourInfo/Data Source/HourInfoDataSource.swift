/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data Source da collection de horário de funcionamento
class HourInfoDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    
    /// Dados usados no data source
    private var mainData: [ManagedHourInfo] = []
        
    /// Dados que estão sendo usados no data source
    public var data: [ManagedHourInfo] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }

    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourInfoCell.identifier, for: indexPath) as? HourInfoCell else {
            return UICollectionViewCell()
        }
        
        let data = self.data[indexPath.row]
        cell.setupCell(for: data)
        
        return cell
    }
}

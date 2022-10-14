/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data source da collection de imagens de uma horta da tela de info garden
class InfoGardenImagesDataSource: NSObject, UICollectionViewDataSource {
        
    /* MARK: - Atributos */
    
    /// Dados usados no data source (nome das imagens)
    private var mainData: [ManagedImage] = []
        
    /// Dados que estão sendo usados no dados source
    public var data: [ManagedImage] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    /* MARK: - Encapsulamento */
    
    /// Pega a quantidade de células que vão ser mostradas
    /// - Returns: quantidade de dados
    public func getDataCount() -> Int {
        return self.data.count
    }
    
    
    
    /* MARK: - Data Source */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getDataCount()
    }
    
    
    /// Faz a configuração de cada célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoGardenImagesCell.identifier, for: indexPath) as? InfoGardenImagesCell else {
            return UICollectionViewCell()
        }
        
        let currentImage = self.data[indexPath.row].name
        cell.setupCell(with: currentImage)
        
        return cell
    }
}

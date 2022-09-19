/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfoGardenImagesDataSource: NSObject, UICollectionViewDataSource {
        
    /* MARK: - Atributos */
    
    /// Nome das imagens
    private var data: [String] = ["ImagemHorta", "ImagemHorta", "ImagemHorta"]
    
    
    
    /* MARK: - Encapsulamento */
        
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
        
        let currentImage = self.data[indexPath.row]
        cell.setupCell(with: currentImage)
        
        return cell
    }
}

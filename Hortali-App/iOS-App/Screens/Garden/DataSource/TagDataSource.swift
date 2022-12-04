/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data source da collection das tags
class TagDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /* MARK: - Atributos */
    
    /// Dados usados no data source
    private var mainData : [ManagedTags] = []
    
    /// Label usada como referencia para o tamanho do texto
    private let referenceLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
//        lbl.numberOfLines = 1
        lbl.sizeToFit()
        return lbl
    }()
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Dados que estão sendo usados no dados source
    public var data: [ManagedTags] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    
    /* MARK: - Delegate (Flow) */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return .zero
        }
        
        let data = self.mainData[indexPath.row]
        let text = "    \(data.name)    "
        
        let font = cell.fontCell ?? UIFont()
        let textWidth = text.size(withAttributes: [
            NSAttributedString.Key.font: font]
        ).width
        
        let size = CGSize(width: textWidth, height: collectionView.bounds.height)
        return size
    }
    
    
    
    /* MARK: - Data Sources (Collection) */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainData.count
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        
        let data = self.mainData[indexPath.row]
        cell.setupCell(with: data.name)
        
        collectionView.reloadInputViews()
        return cell
    }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

/// Os tipos que estão de acordo com esse protocolo são classes que lidam com o data source e delegate de uma collection
protocol CollectionHandler {
    
    /// Linka o data source e delegate na collection
    /// - Parameter collection: collection que vai ser linkada
    func link(with collection: UICollectionView)
}


class TagCollectionHandler: NSObject, CollectionHandler, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /* MARK: - Atributos */
    
    /// Dados usados no data source
    private var mainData : [ManagedTags] = []
    
    /// Protocolo de comunicação com a controller da collection
    private weak var `protocol`: SearchProtocol?
    
    /// Index da célula (tag) selecionada
    private var selectedCell: IndexPath?
    

    
    /* MARK: - Encapsulamento */
    
    /// Verifica se existe alguma tag selecionada
    public var tagSelected: IndexPath? {
        return self.selectedCell
    }
    
    /// Dados que estão sendo usados no dados source
    public var data: [ManagedTags] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    /// Configura o protocolo de comunicação
    /// - Parameter `protocol`: protocolo
    public func setProtocol(with `protocol`: SearchProtocol) {
        self.protocol = `protocol`
    }
    
    
    
    /* MARK: - Protocol */
    
    internal func link(with collection: UICollectionView) {
        collection.delegate = self
        collection.dataSource = self
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
        let row = indexPath.row
        
        let data = self.mainData[row]
        cell.setupCell(with: data.name)
        cell.tag = row
        
        collectionView.reloadInputViews()
        return cell
    }
    
    

    /* MARK: - Delegate (Collection) */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let lastCellIndex = self.selectedCell {
            if indexPath == lastCellIndex {
                collectionView.deselectItem(at: indexPath, animated: true)
                self.selectedCell = nil
                self.protocol?.updateCollection(tag: "")
                return
            }
        }
        
        self.selectedCell = indexPath
        
        let data = self.mainData[indexPath.row]
        self.protocol?.updateCollection(tag: data.name)
    }



    /* MARK: - Delegate (Flow) */

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fontSize = collectionView.superview?.getEquivalent(20) ?? 20
        guard let font = UIFont.setupFont(with: FontInfo(fontSize: fontSize, weight: .regular)) else { return .zero }
        
        let data = self.mainData[indexPath.row]
        let text = "    \(data.name)    "
        
        let textWidth = text.size(withAttributes: [
            NSAttributedString.Key.font: font]
        ).width
        
        let size = CGSize(width: textWidth, height: collectionView.bounds.height)
        return size
    }
}

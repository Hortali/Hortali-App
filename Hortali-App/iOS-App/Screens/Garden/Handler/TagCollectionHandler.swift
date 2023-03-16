/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Lida com a collection de tag, tanto o delegate quanto o data source
class TagCollectionHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    private var mainData: [ManagedTags] = []
    
    private weak var searchProtocol: SearchProtocol?
    
    private var selectedCell: IndexPath?
    

    
    /* MARK: - Encapsulamento */
    
    public var isSelectionAllowed = true
    
    public var tagSelected: IndexPath? { self.selectedCell }
    
    public var data: [ManagedTags] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    public func setProtocol(with `protocol`: SearchProtocol) {
        self.searchProtocol = `protocol`
    }
    
    
    
    /* MARK: - Protocolo */
    
    func registerCell(in collection: UICollectionView) {
        collection.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
    }
    
    
    func setupFlowLayoutSettings(_ collection: CustomCollection) {
        collection.scrollDirection = .horizontal
    }
    
    
    
    /* MARK: - Data Sources (Collection) */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell
        else { return UICollectionViewCell() }
        
        self.setupCell(cell, collectionView, atRow: indexPath.row)
        return cell
    }
    
    
    private func setupCell(_ cell: TagCell, _ collection: UICollectionView, atRow row: Int) {
        let data = self.mainData[row]
        cell.setupCell(with: data.name)
        cell.isSelectionAllowed = self.isSelectionAllowed
    }
    

    
    /* MARK: - Delegate (Collection) */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedCell.isNil {
            self.selectNewCell(at: indexPath); return
        }
        self.deselectCellSelected(collectionView, at: indexPath)
    }
    
    
    private func deselectCellSelected(_ collection: UICollectionView, at indexPath: IndexPath) {
        guard indexPath == self.selectedCell else { return }
        collection.deselectItem(at: indexPath, animated: true)
        self.selectedCell = nil
        self.searchProtocol?.updateCollection(tag: "")
    }
    
    
    private func selectNewCell(at indexPath: IndexPath) {
        self.selectedCell = indexPath
        
        let data = self.mainData[indexPath.row]
        self.searchProtocol?.updateCollection(tag: data.name)
    }



    /* MARK: - Delegate (Flow) */

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fontSize = collectionView.superview?.getEquivalent(20) ?? 20
        let font = UIFont.setupFont(with: FontInfo(fontSize: fontSize, weight: .regular))
        guard let font else { return .zero }
        
        let data = self.mainData[indexPath.row]
        let text = "    \(data.name)    "
        
        let textWidth = text.size(withAttributes: [
            NSAttributedString.Key.font: font]
        ).width
        
        let size = CGSize(width: textWidth, height: collectionView.bounds.height)
        return size
    }
}

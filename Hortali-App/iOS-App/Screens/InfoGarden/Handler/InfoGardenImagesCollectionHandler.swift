/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class InfoGardenImagesCollectionHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    private var mainData: [ManagedImage] = []
    
    private weak var infoGardenProtocol: InfoGardenProtocol?
    
    
    
    /* MARK: - Encapsulamento */
    
    public var data: [ManagedImage] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }

        
    public func setProtocol(with delegate: InfoGardenProtocol) {
        self.infoGardenProtocol = delegate
    }
    
    
    public func getDataCount() -> Int {
        return self.data.count
    }
    
    
    /* MARK: - Protocolo */
    
    func registerCell(in collection: UICollectionView) {
        collection.register(InfoGardenImagesCell.self, forCellWithReuseIdentifier: InfoGardenImagesCell.identifier)
    }
    
    
    func setupFlowLayoutSettings(_ collection: CustomCollection) {
        collection.scrollDirection = .horizontal
        collection.spaceBetweenCells = .zero
        collection.flowLayout.minimumLineSpacing = .zero
    }
    
    
    
    /* MARK: - Data Sources */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getDataCount()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoGardenImagesCell.identifier, for: indexPath) as? InfoGardenImagesCell else {
            return UICollectionViewCell()
        }
        
        let currentImage = self.data[indexPath.row].name
        cell.setupCell(with: currentImage)
        
        return cell
    }
    
    
    
    /* MARK: - Delegate */
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.infoGardenProtocol?.updateCurrentPage(to: indexPath.row)
    }
}

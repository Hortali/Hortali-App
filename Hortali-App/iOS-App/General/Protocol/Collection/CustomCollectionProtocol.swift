/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


protocol CustomCollectionProtocol {
    
    var collection: UICollectionView { get set }
    
    var flowLayout: UICollectionViewFlowLayout { get set }
}


extension CustomCollectionProtocol {
    
    func reloadCollectionData() {
        self.collection.reloadData()
        self.collection.reloadInputViews()
    }
    
    
    func setCollectionHandler(with handler: CollectionHandler) {
        self.collection.delegate = handler
        self.collection.dataSource = handler
    }
    
    
    func setupCollectionFlowLayout() {
        self.collection.collectionViewLayout = self.flowLayout
    }
}

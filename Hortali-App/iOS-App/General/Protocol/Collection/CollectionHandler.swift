/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acordo com esse protocolo são classes que lidam com o data source e delegate de uma collection
protocol CollectionHandler: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func registerCell(in collection: UICollectionView)
    
    func setupFlowLayoutSettings(_ collection: CustomCollection)
}


extension CollectionHandler {
    
    /// Linka o data source e delegate na collection
    func link(with view: CustomCollection) {
        self.registerCell(in: view.collection)
        self.setupFlowLayoutSettings(view)
        view.setCollectionHandler(with: self)
    }
}

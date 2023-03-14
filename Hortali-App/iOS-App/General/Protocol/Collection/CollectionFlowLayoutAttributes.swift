/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


protocol CollectionFlowLayoutAttributes {
    
    var cellSize: CGSize { get set }
    
    var spaceBetweenCells: CGFloat { get set }
    
    var scrollDirection: UICollectionView.ScrollDirection { get set }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit
import MapKit


/// Componentes de UI já padronizados de acordo com o projeto.
struct CustomViews {
    
    /// Cria uma nova label de acordo com a padronização do projeto
    static func newLabel() -> UILabel {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        
        lbl.backgroundColor = UIColor(.viewBack)
        lbl.textColor = UIColor(.subTitle)
        
        lbl.textAlignment = .left
        return lbl
    }
    
    
    /// Cria uma nova view de acordo com a padronização do projeto
    static func newView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    
    /// Cria uma collection de acordo com a padronização do projeto
    static func newCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.backgroundColor = UIColor(.viewBack)
        
        return col
    }
    
    
    /// Cria um botão de acordo com a padronização do projeto
    static func newButton() -> UIButton {
        return CustomButton()
    }
    
    
    /// Cria uma imagem (view) de acordo com a padronização do projeto
    static func newImage() -> UIImageView {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        
        return imgV
    }
    
    
    /// Cria um mapa de acordo com a padronização do projeto
    static func newMap() -> MKMapView {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        return map
    }
    
    
    /// Cria uma scrool view de acordo com a padronização do projeto
    static func newScrool() -> UIScrollView {
        let scrool = UIScrollView()
        scrool.translatesAutoresizingMaskIntoConstraints = false
        
        return scrool
    }
    
    
    /// Cria uma search bar de acordo com a padronização do projeto
    static func newSearch() -> UISearchBar {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        
        // Cores
        let textColor = UIColor(.searchText)
        
        search.backgroundImage = UIImage()
        search.searchTextField.backgroundColor = UIColor(.searchBack)
        search.searchTextField.textColor = textColor
        search.searchTextField.setupPlaceHolder(text: "Buscar", color: textColor)
        search.searchTextField.setupIconsColor(with: .searchIcons)
        
        return search
    }
    
    
    /// Cria uma segmentation control de acordo com a padronização do projeto
    /// - Parameter itens: itens que a segmentation pode ter caso for do tipo menu
    /// - Returns: Retorna uma segmentation personalizada
    static func newSegmentation(with itens: [String]?) -> UISegmentedControl {
        var seg = UISegmentedControl()
        
        if let itens = itens {
            seg = UISegmentedControl(items: itens)
            seg.selectedSegmentTintColor = UIColor(.segBackSelected)
            seg.backgroundColor = UIColor(.segBackNotSelected)
        }
    
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }
 }
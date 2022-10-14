/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import MapKit
import UIKit


/// Componentes de UI já padronizados de acordo com o projeto.
struct CustomViews {
    
    /// Cria uma nova label de acordo com a padronização do projeto
    static func newLabel() -> CustomLabel {
        let lbl = CustomLabel()
        lbl.backgroundColor = .clear
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
    
    
    /// Cria um botão de acordo com a padronização do projeto
    static func newButton() -> CustomButton {
        let but = CustomButton()
        but.tintColor = UIColor(.viewBack)
        
        return but
    }
    
    
    /// Cria uma imagem (view) de acordo com a padronização do projeto
    static func newImage() -> UIImageView {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.clipsToBounds = true
        
        return imgV
    }
    
    
    /// Cria um mapa de acordo com a padronização do projeto
    static func newMap() -> MKMapView {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        
        return map
    }
    
    
    /// Cria uma scrool view de acordo com a padronização do projeto
    static func newScrool() -> CustomScroll {
        return CustomScroll()
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
            seg.tintColor = UIColor(.segTextSelected)
        }
        
        let titleTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(.segTextSelected) ?? .clear
        ]
        seg.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }
    
    
    /// Cria uma page control de acordo com a padronização do projeto
    static func newPageControl() -> UIPageControl {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        
        page.currentPageIndicatorTintColor = UIColor(.pageSelected)
        page.pageIndicatorTintColor = UIColor(.pageNotSelected)
        
        page.numberOfPages = 1
        page.currentPage = 0
        
        if #available(iOS 14.0, *) {
            page.backgroundStyle = .automatic
            page.allowsContinuousInteraction = false
        }
        
        page.backgroundColor = UIColor(.backgroundButton)?.withAlphaComponent(0.95)
        
        return page
    }
    
    
    /// Cria uma page control de acordo com a padronização do projeto
    ///
    /// Valores padronizados:
    /// - Direção: vertical
    /// - Distribuição e alinhamento: centralizado
    static func newStackView() -> CustomStack {
        let stack = CustomStack()
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.axis = .vertical
        
        return stack
    }
 }

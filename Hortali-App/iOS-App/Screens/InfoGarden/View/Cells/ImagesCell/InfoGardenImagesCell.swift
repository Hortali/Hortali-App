/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Célula que mostra as imagens da horta
class InfoGardenImagesCell: CollectionCellWithViewCode, CustomCell {
    
    /* MARK: - Atributos */

    static let identifier = "IdInfoGardenImagesCell"
    

    // Views
    
    private let imageView = CustomViews.newImage()
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setupCell(with imageName: String) {
        self.imageView.image = UIImage(named: imageName)
    }
    
    

    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        self.addViewInContent(self.imageView)
    }
    
    
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        let constraints = self.imageView.strechToBounds(of: self.contentView)
        return constraints
    }
}

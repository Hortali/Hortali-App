/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class CustomCollectionWithTitle: CustomCollection {
    
    /* MARK: - Atributos */
    
    public let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textColor = UIColor(.subTitle)
        return lbl
    }()
    
    
    
    /* MARK: - ViewCode */
    
    override func setupHierarchy() {
        super.setupHierarchy()
        self.addSubview(self.titleLabel)
    }

    // Não mexer nas constraints da collection
    override func createStaticConstraints() -> [NSLayoutConstraint] {
        var constraints = [
            self.collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),


            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ]
        constraints += self.createEmptyViewConstraints()
        return constraints
    }


    override func createDynamicConstraints() {
        let titleLabelHeight: CGFloat = self.superview?.getEquivalent(25) ?? 0

        self.dynamicConstraints = [
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.labelSpace),
            self.titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
        ]
    }
}

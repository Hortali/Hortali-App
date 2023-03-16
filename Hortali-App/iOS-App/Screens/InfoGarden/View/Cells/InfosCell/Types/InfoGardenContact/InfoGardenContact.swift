/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Conteúdo da célula para mostrar os contatos disponíveis
class InfoGardenContact: ViewWithViewCode, InfoGardenCellProtocol {
    
    /* MARK: - Atributos */

    // Views
    
    private let contactStack: CustomStack = CustomViews.newStackView()
    
    private let contactViews: [ContactGroup] = [ContactGroup(), ContactGroup(), ContactGroup()]
    
    
    // Outros
    
    private var contactInStack: Int = 0


    
    /* MARK: - Protocol */
    
    internal func setupView(for data: ManagedGarden) {
        self.setupContactInfos(with: data.contacts)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupContactInfos(with infos: [ManagedContact]) {
        switch infos.count {
        case 1:
            self.contactViews[0].setupContactInfo(with: infos[0])
            self.contactViews[1].isHidden = true
            self.contactViews[2].isHidden = true
        case 2:
            self.contactViews[0].setupContactInfo(with: infos[0])
            self.contactViews[1].setupContactInfo(with: infos[1])
            self.contactViews[2].isHidden = true
        default:
            self.contactViews[0].setupContactInfo(with: infos[0])
            self.contactViews[1].setupContactInfo(with: infos[1])
            self.contactViews[2].setupContactInfo(with: infos[2])
        }
        
        self.contactInStack = infos.count
    }
    
    
    
    /* MARK: - ViewCode */
    
    
    override func setupHierarchy() {
        self.addSubview(self.contactStack)
        
        self.addViewInStack(self.contactViews[0])
        self.addViewInStack(self.contactViews[1])
        self.addViewInStack(self.contactViews[2])
    }
    
    
    private func addViewInStack(_ view: UIView) {
        self.contactStack.addArrangedSubview(view)
    }
    
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(.contactCellBack)
    }
    
    
    override func createDynamicConstraints() {
        let lateral: CGFloat = self.getConstant(for: 15)
        
        let groupHeight: CGFloat = self.getConstant(for: 75)
        
        var spaceStack = self.contactStack.getEqualSpace(for: groupHeight)
        if self.contactInStack == 2 {
            spaceStack += groupHeight / 2
        }
       
        self.dynamicConstraints = [
            self.contactStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.contactStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            
            self.contactViews[0].heightAnchor.constraint(equalToConstant: groupHeight),
            self.contactViews[1].heightAnchor.constraint(equalToConstant: groupHeight),
            self.contactViews[2].heightAnchor.constraint(equalToConstant: groupHeight),
        ]
        
        
        if self.contactInStack == 1 {
            self.dynamicConstraints += [
                self.contactStack.heightAnchor.constraint(equalToConstant: groupHeight),
                self.contactStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.contactStack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ]
        } else {
            self.dynamicConstraints += [
                self.contactStack.topAnchor.constraint(equalTo: self.topAnchor, constant: spaceStack),
                self.contactStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spaceStack)
            ]
        }
    }
    
    
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 350, height: 160),
            dimension: .width
        )
        return self.getEquivalent(space, screenReference: screenReference)
    }
}

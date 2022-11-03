/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Conteúdo da célula para mostrar os contatos disponíveis
class InfoGardenContact: UIView, InfoGardenCellProtocol {
    
    /* MARK: - Atributos */

    // Views
    
    /// Uma stack vertical para colocar as views de contato
    private let contactStack: CustomStack = CustomViews.newStackView()
    
    /// Views de contatos
    private let contactViews: [ContactGroup] = [ContactGroup(), ContactGroup()]
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
	
    /// Quantiade de contato que estão na stack view
    private var contactInStack: Int = 0


    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Protocol */
    
    internal func setupView(for data: ManagedGarden) {
        self.setupContactInfos(with: data.contacts)
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    // Geral
    
    /// Configura os contatos de acordo com a quantidade de contatos disponíveis
    /// - Parameter infos: contatos disponiveis
    private func setupContactInfos(with infos: [ManagedContact]) {
        if infos.count == 1 {
            self.contactViews[1].isHidden = true
            self.contactViews[0].setupContactInfo(with: infos[0])
        } else {
            self.contactViews[0].setupContactInfo(with: infos[0])
            self.contactViews[1].setupContactInfo(with: infos[1])
        }
        self.contactInStack = infos.count
    }
    
    
    // Views
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.contactStack)
        
        self.contactStack.addArrangedSubview(self.contactViews[0])
        self.contactStack.addArrangedSubview(self.contactViews[1])
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.contactCellBack)
    }
   
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        let lateral: CGFloat = self.getConstant(for: 15)
        
        let groupHeight: CGFloat = self.getConstant(for: 50)
        
        let spaceStack = self.contactStack.getEqualSpace(for: groupHeight)
       
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.contactStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.contactStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            
            self.contactViews[0].heightAnchor.constraint(equalToConstant: groupHeight),
            self.contactViews[1].heightAnchor.constraint(equalToConstant: groupHeight),
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
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    /// Responsável por pegar o valor referente à célula
    /// - Parameter space: valor para ser convertido
    /// - Returns: valor em relação à tela
    private func getConstant(for space: CGFloat) -> CGFloat {
        let screenReference = SizeInfo(
            screenSize: CGSize(width: 350, height: 160),
            dimension: .width
        )
        
        return self.getEquivalent(space, screenReference: screenReference)
    }
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfoGardenContact: UIView {
    
    /* MARK: - Atributos */

    // Views
    
    private let contactOne = ContactGroup()
    
    private let contactTwo = ContactGroup()
    
    
    // Outros
    
    /// Constraints dinâmicas que mudam de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
		


    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupUI()
        self.DADOS_TESTE()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura os contatos de acordo com a quantidade de contatos disponíveis
    /// - Parameter infos: contatos disponiveis
    public func setupContactInfos(with infos: [ContactInfo]) {
        if infos.count == 1 {
            self.contactTwo.isHidden = true
            self.contactOne.setupContactInfo(with: infos[0])
        } else {
            self.contactTwo.isHidden = false
            self.contactOne.setupContactInfo(with: infos[0])
            self.contactTwo.setupContactInfo(with: infos[1])
        }
    }
    

    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() {
        super.layoutSubviews()
	      
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */

    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(self.contactOne)
        self.addSubview(self.contactTwo)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        self.backgroundColor = UIColor(.contactCellBack)
    }
   
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() { 
        let lateral: CGFloat = 15 // self.getEquivalent(15)
        let between: CGFloat = 10 // self.getEquivalent(10)
        
        let groupHeight: CGFloat = 50
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.contactOne.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: lateral),
            self.contactOne.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -lateral),
            self.contactOne.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -between),
            self.contactOne.heightAnchor.constraint(equalToConstant: groupHeight),


            self.contactTwo.leadingAnchor.constraint(equalTo: self.contactOne.leadingAnchor),
            self.contactTwo.trailingAnchor.constraint(equalTo: self.contactOne.trailingAnchor),
            self.contactTwo.topAnchor.constraint(equalTo: self.centerYAnchor, constant: between),
            self.contactTwo.heightAnchor.constraint(equalToConstant: groupHeight),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    private func DADOS_TESTE() {
        self.setupContactInfos(with: [
            ContactInfo(icon: .insta, contact: "@hortadasaude"),
            ContactInfo(icon: .whatts, contact: "+55 11 98888-8888"),
        ])
    }
}

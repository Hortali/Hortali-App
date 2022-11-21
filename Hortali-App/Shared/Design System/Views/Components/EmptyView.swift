/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

/// Componentes de toda tela vazia.
class EmptyView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    internal var titleLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    internal var dynamicLabel: UILabel = {
        let lbl = CustomViews.newLabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
        self.registerCell()
        self.setupCollectionFlow()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Ações dos Botões */
    
    /// Define a ação do botão
    public func setAction(target: Any?, action: Selector) -> Void {
        // self. .addTarget(target, action: action, for: .touchDown)
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /* Collection */
    
    /// Registra as células nas collections/table
    private func registerCell() {
        self.backgroundColor = .red
    }
    
    
    /// Define o layout da collection
    private func setupCollectionFlow() {
        // self.collection.collectionViewLayout = self.collectionFlow
    }
    
    
    /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        self.addSubview(titleLabel)
        self.addSubview(dynamicLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
        /*
         Aqui vão definidos as bordas, cor de fundo da view
         */
        
        // Define o tamanho que a célula vai ter
        // self.collectionFlow.itemSize = CGSize(width: 100, height: 100)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        self.titleLabel.setupText(with: FontInfo(text: "OPS !", fontSize: 32, weight: .bold))
        self.titleLabel.font = UIFont(name: "AmsterdamGraffiti", size: 52)
        
        self.dynamicLabel.setupText(with: FontInfo(text: "Uma mensagem bacana \n e personalizada aqui", fontSize: 17, weight: .regular))
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
        //let lateral: CGFloat = self.getEquivalent(15)
        // let between: CGFloat =
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.dynamicLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.dynamicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}

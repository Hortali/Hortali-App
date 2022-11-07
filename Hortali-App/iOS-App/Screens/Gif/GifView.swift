/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class GifView: UIView {
    
    /* MARK: - Atributos */
    
    // Views

    // Outros
    
    private let imagesCollectionGp: CollectionGroup = {
        let colGp = CollectionGroup(style: .justCollection)
        colGp.collection.isPagingEnabled = true
        return colGp
    }()
        
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
        
        
        /// Configurações do layout da collection
        private let collectionFlow: UICollectionViewFlowLayout = {
        let cvFlow = UICollectionViewFlowLayout()
        cvFlow.scrollDirection = .vertical
             
        return cvFlow
    }()



    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
//                self.registerCells()
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
        
    }


        /// Define o layout da collection
    private func setupCollectionFlow() {
//         self.imagesCollectionGp.collectionViewLayout = self.collectionFlow
    }


        /* Geral */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() {
        
        
        let linkDoGif: String = "https://c.tenor.com/x8oDQkCwHc0AAAAC/qualquer-coisa-vestibular.gif"
        
        
        let enderecoDoGif = UIImage.gifImageWithURL(linkDoGif)
        let gif = UIImageView(image: enderecoDoGif)
       // return gif
        gif.frame = CGRect(x: 20, y: 30, width: self.imagesCollectionGp.frame.width - 30, height: self.imagesCollectionGp.frame.height - 30)
        
        self.imagesCollectionGp.addSubview(gif)
    }
    
    
    /// Personalização da UI
    private func setupUI() {
       
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() {
        /*
                    Aqui vão ser configurados os textos estáticos, ícones dos botões
                    tamanho das fontes, peso das fontes.. (para botões e labels ou até
                    mesmo para putrp elemento caso tenha)
                */
                
                /* Labels */
                

                /* Botões */
    }
      
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() {
                // let lateral: CGFloat =
        // let between: CGFloat =
       
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [

        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}

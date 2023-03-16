/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class UIKit.NSLayoutConstraint


/// Os tipos que estão de acordo com esse protocolo são Views que são
/// configuradas por código (view code) usando contraints.
///
/// Há duas função para serem chamadas em momentos diferentes:
/// - `createView`: no inicializador da estrutura
/// - `updateUI`: na função `layoutSubviews
///
/// Existem métodos que são chamados apenas uma única vez e outros que são chamados ao longo do
/// ciclo de vida da View (ou alguma atualização). Para entender quais métodos possuem esse comportamento
/// verifique a implementação (na extension) dos dois métodos acima.
protocol ViewCode {
    
    /* MARK: - Atributos */
    
    /// Constraints que podem ser alteradas no decorrer do ciclo de vida
    var dynamicConstraints: [NSLayoutConstraint] { get set }
        
    
    
    /* MARK: - Métodos */
    
    /// Adiciona os elementos (Views) na tela, criando a hierarquia nde views
    func setupHierarchy()
    
    
    /// Configurações gerais da view
    func setupView()
    
    
    /// Define os textos que são estáticos (os textos que vão sempre ser o mesmo)
    func setupStaticTexts()
    
    
    /// Configurações da view que podem ser atualizadas durante o ciclo de vida
    func setupUI()
    
    
    /// Define o tamanho das fontes e ícones
    func setupFonts()
    
    
    /// Cria as contraitns que vão ser a mesma até o ciclo de vida se encerrar
    func createStaticConstraints() -> [NSLayoutConstraint]
    
    
    /// Cria as constraints que podem mudar ao longo do ciclo de vida da View
    ///
    /// As constraints precisam ser definidas no atributo `dynamicConstraints`.
    func createDynamicConstraints()
    
    
    /// Remove as contraints dinâmicas
    func clearDynamicConstraints()
}


extension ViewCode {
    
    /// Métodos para criaçao incial da view, são chamados apenas uma vez.
    ///
    /// Esse método deve ser chamado no inicializador por exemplo.
    internal func createView() {
        self.setupHierarchy()
        self.setupView()
        self.setupStaticTexts()
        self.setupStaticConstraints()
    }
    
    
    /// Métodos de ações dinâmicas, que podem ser chamadas mais de uma vez durante o ciclo de vida.
    ///
    /// Esse método deve ser chamado na função `layoutSubviews` por exemplo.
    internal func reloadView() {
        self.setupDynamicConstraints()
        self.setupUI()
        self.setupFonts()
    }
    
    
    /// Define as constraints que NÃO dependem do tamanho da tela, que nunca vão mudar.
    ///
    /// Em caso de override dessa função, não esqueça de ativar as contraints no final.
    internal func setupStaticConstraints() {
        let constraints = self.createStaticConstraints()
        self.activateConstraints(for: constraints)
    }
    
    
    /// Define as constraints que dependem do tamanho da tela ou que podem mudar ao longo do ciclo.
    ///
    /// Em caso de override dessa função, não esqueça de limpar e desativar as contraints antes de atribuir
    /// novas e no fim ativa-las.
    internal func setupDynamicConstraints() {
        self.clearDynamicConstraints()
        self.createDynamicConstraints()
        self.activateConstraints()
    }
    
    
    /// Caso não tenha nenhum parâmetro é ativado as constraints que estão no atributo (`dynamicConstraints`)
    internal func activateConstraints(for constraints: [NSLayoutConstraint]? = nil) {
        if let constraints {
            return NSLayoutConstraint.activate(constraints)
        }
        
        guard !self.dynamicConstraints.isEmpty else { return }
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}

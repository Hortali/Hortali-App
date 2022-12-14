/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data source da collection da tela de configurações
class SettingsDataSource: NSObject, UICollectionViewDataSource {
        
    /* MARK: - Atributos */
    
    /// Dados usados no data source
    private var mainData: [SettingsData] = []
        
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        self.setupStaticData()
    }
    
    
    
    /* MARK: - Encapsulamento */

    /// Dados da collection
    public var collectionData: [SettingsData] {
        return self.mainData
    }
    
    
    
    /* MARK: - Data Source */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainData.count
    }
    
    
    /// Faz a configuração de cada célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else {
            return UICollectionViewCell()
        }
        
        let data = self.mainData[indexPath.row]
        cell.setupCell(with: data)
        
        return cell
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura os dados da collection
    private func setupStaticData() {
        self.mainData = [
            SettingsData(
                icon: .help,
                title: "Como usar o aplicativo?",
                subTitle: "Esqueceu como usa o aplicativo?",
                description: "Aqui tem um tutorial completo pra você!",
                color: .settingsHelp,
                link: nil
            ),
            SettingsData(
                icon: .suggestion,
                title: "Sugerir",
                subTitle: "Tem uma horta pertinho de você?",
                description: "Aqui você pode mandar pra gente adicionar!",
                color: .settingsSuggestions,
                link: "https://forms.gle/aurYnGF5RX86NcsL9"
            ),
            SettingsData(
                icon: .contactUs,
                title: "Fale com a gente",
                subTitle: "Tem alguma dúvida?",
                description: "Sempre estamos a uma mensagem de você!",
                color: .settingsContactUs,
                link: "https://instagram.com/hortaliapp?igshid=Zjc2ZTc4Nzk="
            ),
            SettingsData(
                icon: .report,
                title: "Reportar",
                subTitle: "Descobriu alguma informação incorreta?",
                description: "Conta pra gente poder arrumar!",
                color: .settingsReport,
                link: "https://forms.gle/KtfLT9se4e44UcU28"
            ),
        ]
    }
}

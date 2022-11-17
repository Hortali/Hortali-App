/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


struct SettingsData {
    let icon: AppIcons
    let title: String
    let subTitle: String
    let description: String
    let color: AppColors
}

/// Data source da collection de imagens de uma horta da tela de info garden
class SettingsDataSource: NSObject, UICollectionViewDataSource {
        
    /* MARK: - Atributos */
    
    /// Dados usados no data source (nome das imagens)
    private var mainData: [SettingsData] = []
        
    
    
    /* MARK: - Construtor */
    
    override init() {
        super .init()
        
        self.setupStaticData()
    }
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Pega a quantidade de células que vão ser mostradas
    /// - Returns: quantidade de dados
    public func getDataCount() -> Int {
        return self.mainData.count
    }
    
    
    
    /* MARK: - Data Source */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getDataCount()
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
    
    
    /// Configura os dados da collection
    private func setupStaticData() {
        self.mainData = [
            
        ]
    }
}

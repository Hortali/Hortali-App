/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Data source da collection do on boarding
class OnboardingDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Encapsulamento */
    
    /// Total de células que a colelction vai mostrar
    public var totalPages: Int {
        return 3
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalPages
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        let data = self.getInfos(for: indexPath.row)
        cell.setupCell(for: data)
        
        return cell
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Pega os dados da célula a partir da linha
    /// - Parameter row: linha
    /// - Returns: dados da célula
    private func getInfos(for row: Int) -> OnBoardingInfos {
        switch row {
        case 0:
            return OnBoardingInfos(
                primaryTitleText: "Veja as hortas de",
                secondaryTitleText: "Sao Paulo",
                primaryDescriptionText: "Você conhece as hortas da cidade?",
                secondaryDescriptionText: "Aqui você pode encontrar as hortas mais próximas ou até buscar por hortas específicas.",
                image: UIImage(named: "OnBoarding-\(row)"),
                color: UIColor(.gardenBack)
            )
            
        case 1:
            return OnBoardingInfos(
                primaryTitleText: "Conheça os verdadeiros",
                secondaryTitleText: "alimentos",
                primaryDescriptionText: "Aprender nunca é demais né?",
                secondaryDescriptionText: "Aqui da pra conhecer com os alimentos organicos e ver muitas informações sobre eles.",
                image: UIImage(named: "OnBoarding-\(row)"),
                color: UIColor(.foodBack)
            )
        
        default:
            return OnBoardingInfos(
                primaryTitleText: "Selecione todos os seus",
                secondaryTitleText: "favoritos",
                primaryDescriptionText: "Gostou? Favoritou!",
                secondaryDescriptionText: "Pra você encontrar suas hortas e alimentos favoritos, uma área só sua.",
                image: UIImage(named: "OnBoarding-\(row)"),
                color: UIColor(.favoriteBack)
            )
        }
    }
}

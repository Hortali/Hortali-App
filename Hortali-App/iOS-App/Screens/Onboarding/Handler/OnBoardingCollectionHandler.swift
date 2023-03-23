/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class OnBoardingCollectionHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    public var totalPages: Int { return 3 }
    
    private weak var onboardingProtocol: OnboardingProtocol?
    
    
    
    /* MARK: - Encapsulamento */
        
    public func setProtocol(with delegate: OnboardingProtocol) {
        self.onboardingProtocol = delegate
    }
    
    
    
    /* MARK: - Protocolo */
    
    func registerCell(in collection: UICollectionView) {
        collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
    
    
    func setupFlowLayoutSettings(_ collection: CustomCollection) {
        collection.scrollDirection = .horizontal
        collection.spaceBetweenCells = 0
        collection.flowLayout.minimumLineSpacing = 0
    }
    
    
    
    /* MARK: - Data Sources */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalPages
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        let data = self.getInfos(for: indexPath.row)
        cell.setupCell(for: data)
        
        return cell
    }
    
    
    
    /* MARK: - Delegate */
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("Entrei no delegate")
        self.onboardingProtocol?.updateCurrentPage(to: indexPath.row)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func getInfos(for row: Int) -> OnBoardingInfos {
        let image = UIImage(named: "OnBoarding-\(row)")
        
        switch row {
        case 0:
            return OnBoardingInfos(
                primaryTitleText: "Veja as hortas de",
                secondaryTitleText: "Sao Paulo",
                primaryDescriptionText: "Você conhece as hortas da cidade?",
                secondaryDescriptionText: "Aqui você pode encontrar as hortas mais próximas ou até buscar por hortas específicas.",
                image: image,
                color: UIColor(.gardenBack)
            )
            
        case 1:
            return OnBoardingInfos(
                primaryTitleText: "Conheça os verdadeiros",
                secondaryTitleText: "alimentos",
                primaryDescriptionText: "Aprender nunca é demais né?",
                secondaryDescriptionText: "Aqui da pra conhecer com os alimentos organicos e ver muitas informações sobre eles.",
                image: image,
                color: UIColor(.foodBack)
            )
        
        default:
            return OnBoardingInfos(
                primaryTitleText: "Selecione todos os seus",
                secondaryTitleText: "favoritos",
                primaryDescriptionText: "Gostou? Favoritou!",
                secondaryDescriptionText: "Pra você encontrar suas hortas e alimentos favoritos, uma área só sua.",
                image: image,
                color: UIColor(.favoriteBack)
            )
        }
    }
}

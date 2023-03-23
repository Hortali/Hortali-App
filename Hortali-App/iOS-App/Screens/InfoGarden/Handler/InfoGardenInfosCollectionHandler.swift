/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class InfoGardenInfosCollectionHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    private var mainData: ManagedGarden?

    private weak var infoGardenProtocol: InfoGardenProtocol?
    
    
    
    /* MARK: - Encapsulamento */
    
    public var data: ManagedGarden? {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    public func setProtocol(with delegate: InfoGardenProtocol) {
        self.infoGardenProtocol = delegate
    }
    
    
    
    /* MARK: - Protocolo */
    
    func registerCell(in collection: UICollectionView) {
        collection.register(InfoGardenInfosCell.self, forCellWithReuseIdentifier: InfoGardenInfosCell.identifier)
    }
    
    
    func setupFlowLayoutSettings(_ collection: CustomCollection) {
        collection.scrollDirection = .horizontal
    }
    
    
    
    /* MARK: - Data Sources */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoGardenInfosCell.identifier, for: indexPath) as? InfoGardenInfosCell else {
            return UICollectionViewCell()
        }
        
        self.setupCell(cell, atRow: indexPath.row)
        return cell
    }
    
    
    private func setupCell(_ cell: InfoGardenInfosCell, atRow row: Int) {
        guard let data else { return }
        switch row {
        case 0: cell.setupCell(for: .map, with: data)
        case 1: cell.setupCell(for: .time, with: data)
        case 2: cell.setupCell(for: .contact, with: data)
        default: break
        }
    }
    
    
    
    /* MARK: - Delegate */
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.infoGardenProtocol?.showNavigationOptions()
        case 1:
            self.infoGardenProtocol?.openHourInfoPage()
        case 2:
            self.infoGardenProtocol?.showContactOptions()
        default: break
        }
    }
}

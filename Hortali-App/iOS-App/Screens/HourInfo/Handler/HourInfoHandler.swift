/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


class HourInfoHandler: NSObject, CollectionHandler {
    
    /* MARK: - Atributos */
    
    private var mainData: [ManagedHourInfo] = []

        
    
    /* MARK: - Encapsulamento */
    
    public var data: [ManagedHourInfo] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }
    
    
    
    /* MARK: - Protocolo */
    
    func registerCell(in collection: UICollectionView) {
        collection.register(HourInfoCell.self, forCellWithReuseIdentifier: HourInfoCell.identifier)
    }
    
    
    func setupFlowLayoutSettings(_ collection: CustomCollection) {
        collection.scrollDirection = .vertical
    }
    
    
    
    /* MARK: - Data Sources */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Quantidade de dados \(self.data.count)")
        return self.data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourInfoCell.identifier, for: indexPath) as? HourInfoCell
        else { return UICollectionViewCell() }
        
        let data = self.data[indexPath.row]
        cell.setupCell(for: data)
        return cell
    }
}

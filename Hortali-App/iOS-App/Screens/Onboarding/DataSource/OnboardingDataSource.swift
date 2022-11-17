/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


<<<<<<<< HEAD:Hortali-App/iOS-App/Screens/Onboarding/DataSource/OnboardingDataSource.swift
/// Data source da colelction das hortas
class OnboardingDataSource: NSObject, UICollectionViewDataSource {
========
/// Data Source da collection de horário de funcionamento
class HourInfoDataSource: NSObject, UICollectionViewDataSource {
>>>>>>>> main:Hortali-App/iOS-App/Screens/HourInfo/Data Source/HourInfoDataSource.swift
    
    /* MARK: - Atributos */
    
    /// Dados usados no data source
<<<<<<<< HEAD:Hortali-App/iOS-App/Screens/Onboarding/DataSource/OnboardingDataSource.swift
    
========
    private var mainData: [ManagedHourInfo] = []
        
    /// Dados que estão sendo usados no data source
    public var data: [ManagedHourInfo] {
        set (newData) { self.mainData = newData }
        get { self.mainData }
    }

>>>>>>>> main:Hortali-App/iOS-App/Screens/HourInfo/Data Source/HourInfoDataSource.swift
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
<<<<<<<< HEAD:Hortali-App/iOS-App/Screens/Onboarding/DataSource/OnboardingDataSource.swift
        return 4
========
        return self.data.count
>>>>>>>> main:Hortali-App/iOS-App/Screens/HourInfo/Data Source/HourInfoDataSource.swift
    }
    
    
    /// Configura uma célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }

        
        let data = self.data[indexPath.row]
        cell.setupCell(for: data)
        
        return cell
    }
}

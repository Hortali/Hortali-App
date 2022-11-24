/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acordo com esse protocolo faz com que a tela de info de alimentos apareça
protocol FoodProtocol: NSObject {
    
    /// Abre a tela de informações de alimento
    /// - Parameter index: célula que foi aberta
    func openFoodInfo(for index: Int)
    
    ///Transfere a quantidade de células visíveis na collection
    ///- Parameter data: quantidade de células
    func getFoodData(data: Int)
}


//Extensão adicionada para tornar o método opcional
extension FoodProtocol {
    func getFoodData(data: Int) {

     }
}

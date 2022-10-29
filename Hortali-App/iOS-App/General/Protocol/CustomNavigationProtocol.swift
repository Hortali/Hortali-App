/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.NSObject


/// Os tipos que estão de acordo esse protocolo são navigation controllers que
/// precisam de configuração a partir da quantidade de view controllers que ela
/// possui
protocol CustomNavigationProtocol: NSObject {
    
    /// Diz a quantidade de controllers que a navigation possuei
    /// - Returns: quantidade de view controlllers
    func getControllersCount() -> Int
}

/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import struct Foundation.URLError


/// Erros que podem acontecer durante o uso do Core Data.
enum EHDataManaher: Error, CustomStringConvertible {
    
    /* MARK: - Casos */
    case dataNotFound
    case protocolNotSetted
    
    case decoderError

    
    
    /* MARK: - Variáveis */
    
    /// Descrição do erro para o usuário
    var localizedDescription: String {
        switch self {
        case .dataNotFound:
            return "Não existe esse dado."
        case .protocolNotSetted:
            return "Os devs erraram aqui"
        case .decoderError:
            return "Probleminhas pra ler os dados"
        }
    }

    
    /// Descrição do erro para o dev
    var description: String {
        switch self {
        case .dataNotFound:
            return "Não existe esse dado no Core Data."
        case .protocolNotSetted:
            return "Protoco não implementado"
        case .decoderError:
            return "Erro na hora decodificar o JSON"
        }
    }
}

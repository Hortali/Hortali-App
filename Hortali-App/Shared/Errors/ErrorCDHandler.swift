/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import struct Foundation.URLError


/// Erros que podem acontecer durante o uso do Core Data.
public enum ErrorCDHandler: Error, ErrorWarnings {
    
    /* MARK: - Casos */
    
    case dataNotFound
    
    case protocolNotSetted
    
    case fetchError
    
    case saveError
    
    case deleteError
    
    case dataAlreadyExists

    
    
    /* MARK: - Variáveis */
    
    public var userWarning: String {
        switch self {
        case .dataNotFound:
            return "Não existe esse dado."
        case .fetchError:
            return "Eita, teve um erro dos grandes aqui"
        case .protocolNotSetted:
            return "Os devs erraram aqui"
        case .saveError:
            return "Parece que deu um errinho aqui na hora de salvar"
        case .deleteError:
            return "Ixi, não deu pra deletar"
        case .dataAlreadyExists:
            return "Esse dado já existe."
        }
    }

    
    public var developerWarning: String {
        switch self {
        case .dataNotFound:
            return "Não existe esse dado no Core Data."
        case .fetchError:
            return "Problema no fetch"
        case .protocolNotSetted:
            return "Protoco não implementado"
        case .saveError:
            return "Erro na hora de salvar"
        case .deleteError:
            return "Erro na hora de delatar os dados"
        case .dataAlreadyExists:
            return "Esse dado já existe."
        }
    }
}

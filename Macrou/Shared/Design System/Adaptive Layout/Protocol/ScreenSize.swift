/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import struct CoreGraphics.CGSize


/// Tipo com um tamanho contendo largura e altura (CGSize)
///
/// Os tipos que conformam com esse protocolo salva dimensões de tela (largura x altura)
protocol ScreenSize {
    
    var size: CGSize { get }
}

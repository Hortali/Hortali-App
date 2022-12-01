/* Macro - Grupo 05 */


/// Casos de uso das cores usadas no projeto
enum AppColors {
    
    /* MARK: - Casos */
    
    /* Textos */
    
    /// Títulos da página
    case title
    
    /// Sub títulos no geral
    case subTitle
    
    /// Parágrafos (textos extensos)
    case paragraph
    
    /// Títulos secundários usados em sub views
    case secondaryTitle
    
    
    
    /* Telas */
    
    /// Telas: fundo padrão das telas
    case viewBack
    
    /// Tela de Hortas: fundo
    case gardenBack
    
    /// Tela de Alimentos: fundo
    case foodBack
    
    /// Tela de Favoritos: fundo
    case favoriteBack
    
    /// Tela de Configurações: fundo
    case settingsBack
    
    
    
    /* Pop Up */
    
    /// Pop Up: fundo blur
    case popupBackBlur
    
    /// Pop Up: borda
    case popupBorder
    
    /// Pop Up: fundo padrão
    case popupDefaultBack
    
    /// Pop Up: botão padrão
    case popupDefaultButton
    
    
    
    /* Segmented */
    
    /// Segmented: fundo do item selecionado
    case segBackSelected
    
    /// Segmented: fundo do item não selecionado
    case segBackNotSelected
    
    /// Segmented: texto dos itens selecionadas
    case segTextSelected
    
    /// Segmented: texto dos itens não selecionadas
    case segTextNotSelected
    
    
    
    /* Tab Bar */
    
    /// Tab Bar: item selecionado
    case tabSelected
    
    /// Tab Bar: item não selecionado
    case tabNotSelected
    
    
    
    /* Page Control */
    
    /// Page Control: item selecionado
    case pageSelected
    
    /// Page Control: item não selecionado
    case pageNotSelected
    
    
    
    /* Search Bar */
    
    /// Search Bar: fundo
    case searchBack
    
    /// Search Bar: textos
    case searchText
    
    /// Search Bar: ícones
    case searchIcons
    
    
    
    /* Favorito */
    
    /// Botão favorito: fundo de quando de quando está selecionado
    case favoriteSelectedBack
    
    /// Botão favorito: fundo de quando não está selecionado
    case favoriteNotSelectedBack
    
    /// Botão favorito: ícone de quando está selecionado
    case favoriteSelectedIcon
    
    /// Botão favorito: ícone de quando não está selecionado
    case favoriteNotSelectedIcon
    
    
    
    /* Botões */
    
    /// Botão: fundo padrão
    case backgroundButton
    
    /// Botão: mudar a visualização das hortas
    case visualizationButton
    
    
    
    /* Horário de Funcionamento */
    
    /// Célula CL08 - Status fechado
    case closeStatus
    
    /// Célula CL08 - Fundo status fechado
    case closeBackgroundStatus
    
    /// Célula CL08 - Status aberto
    case openStatus
    
    /// Célula CL08 - Fundoi status aberto
    case openBackgroundStatus
    
    /// Barra do componente TimeGroup
    case barHourInfo
    
    
    /* Outros */
    
    /// Fundo da célula de contato
    case contactCellBack
    
    
    
    /* Configuração */
    
    /// (Configurações) Célula de ajuda
    case settingsHelp
    
    /// (Configurações) Célula de sugestão
    case settingsSuggestions
    
    /// (Configurações) Célula de contato
    case settingsContactUs
    
    /// (Configurações) Célula de reportar
    case settingsReport
    
    
    
    /* MARK: - Nome dos botões */
    
    /// Nome das cores
    var colorName: AppPureColors {
        switch self {
            
        /* Textos */
        case .title: return .greenMedium
        case .subTitle: return .brownDark
        case .paragraph: return .greyDark
        case .secondaryTitle: return .white
            
        
        /* Telas */
        case .viewBack: return .white
        case .gardenBack: return .greenMedium
        case .foodBack: return .brownLight
        case .favoriteBack: return .orange
        case .settingsBack: return .yellow
        
            
        /* Pop Up */
        case .popupDefaultBack: return .greenMedium
        case .popupDefaultButton: return .greenLight
        case .popupBackBlur: return .greyDark
        case .popupBorder: return .white
            
        
        /* Segmented */
        case .segBackSelected: return .greenMedium
        case .segBackNotSelected: return .greenLight
        case .segTextSelected: return .white
        case .segTextNotSelected: return .greenMedium
            
            
        /* Tab */
        case .tabSelected: return .greenMedium
        case .tabNotSelected: return .greenLight
            
        
        /* Page Control */
        case .pageSelected: return .greenMedium
        case .pageNotSelected: return .greenLight
            
        
        /* Search */
        case .searchBack: return .greenLight
        case .searchText: return .greenMedium
        case .searchIcons: return .greenMedium
          
        
        /* Favorito */
        case .favoriteSelectedBack: return .greenDark
        case .favoriteSelectedIcon: return .white
            
        case .favoriteNotSelectedBack: return .white
        case .favoriteNotSelectedIcon: return .greenDark
        
            
        /* Botões */
        case .backgroundButton: return .white
        case .visualizationButton: return .greenMedium
            
        
        /* Horários de funcionamentos */
        case .closeStatus: return .red
        case .closeBackgroundStatus: return .orange
            
        case .openStatus: return .greenMedium
        case .openBackgroundStatus: return .greenLight
        
        case .barHourInfo: return .greyDark
        
            
        /* Outros */
        case .contactCellBack: return .yellow
            
        // Configurações
        case .settingsHelp: return .greenDark
        case .settingsSuggestions: return .yellow
        case .settingsContactUs: return .greenMedium
        case .settingsReport: return .orange
        }
    }
}

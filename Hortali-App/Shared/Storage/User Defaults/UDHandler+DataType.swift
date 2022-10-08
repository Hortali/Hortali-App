//
//  UDHandler.swift
//  Hortali
//
//  Created by Gui Reis on 07/10/22.
//

import class Foundation.UserDefaults


extension UserDefaults {
    
    /// Atualiza a lista de favoritos
    internal static func updateFavoriteList(in key: DataType, with value: [Int]) {
        UserDefaults.standard.set(value, forKey: key.userDefaultKey)
    }
    
    
    /// Retorna a lista de favoritos
    internal static func getFavoriteList(for key: DataType) -> [Int] {
        return UserDefaults.standard.object(forKey: key.userDefaultKey) as? [Int] ?? []
    }
}

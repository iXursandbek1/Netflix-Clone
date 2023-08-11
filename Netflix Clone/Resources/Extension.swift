//
//  Extension.swift
//  Netflix Clone
//
//  Created by Xursandbek Qambaraliyev on 11/08/23.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

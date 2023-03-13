//
//  CoreDataError.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 03/02/2023.
//

import Foundation

enum CoreDataError:Error{
    case savingError
    case gettingError
}
extension CoreDataError: LocalizedError{
    
    var errorDescription :String?{
        switch self{
        case .savingError:
            return NSLocalizedString("Got Error while saving into DB", comment: "Saving Error")
        case .gettingError:
            return NSLocalizedString("Got Error while getting data from DB", comment: "Getting Error")
        }
    }
}


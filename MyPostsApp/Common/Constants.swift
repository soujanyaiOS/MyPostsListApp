//
//  Constants.swift
//  MyPostsApp
//
//  Created by soujanya Balusu on 08/03/23.
//

import Foundation
import ToastViewSwift

class Constants {
    static let InvalidUser = "Invalid User Id"
    static let errorTitle = "Error"
    static let noDataAvailable = "No Data Available for this user Id"
    static let Favourites = "Favourites"
    static let MyPostTitle = "My Posts"
    static let Comments = "Comments"
    static let XibError = "xib does not exists"
    static let ALLTab = "ALL"
    static let FavouriteTab = "Favourites"
    static let RecordExistsFavourites = "Record already added to favourites"
    static let savedToFavourites = "Saved to favourites"
    static let noFavDataAvailable = "No favourites Saved"
    static let logoutMessage = "Logged out Successfully"
    
    static func showToastMessage(_ message: String) {
        let toast = Toast.text(message)
        toast.show()
    }
}

//
//  ErrorMessage.swift
//  GH Project
//
//  Created by Andres Gutierrez on 12/22/21.
//

import Foundation

enum GFError: String, Error{
    case invalidUsername        = "This username create an invalid request. Please try again."
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid. Please try again."
    case unableToFavorite       = "Unable to favorite this user. Please try again."
    case alreadyFavorited       = "This person is already in your Favorites"
}

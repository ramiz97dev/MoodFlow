//
//  Track.swift
//  MoodFlow
//
//  Created by Ramiz Niftaliev / PBD2H24A on 11.06.26.
//

import Foundation

struct Track: Codable, Identifiable {
    let id: String
    let title: String
    let mood: String
    let artist: String
    let track: String
    let notes: String
    let date: String
    let isFavorite: String?
    let imageUrl: String?
}

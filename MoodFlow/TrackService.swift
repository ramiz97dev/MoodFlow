//
//  TrackService.swift
//  MoodFlow
//
//  Created by Ramiz Niftaliev / PBD2H24A on 11.06.26.
//

import Foundation
import UIKit

class TrackService {
    
    static func addTrack(
        title: String,
        mood: String,
        artist: String,
        track: String,
        notes: String
    ) {
        
        guard let url = URL(
            string: "https://pbd2h24ani.web.bib.de/moodflow/addTrack.php"
        ) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body =
        "title=\(title)&mood=\(mood)&artist=\(artist)&track=\(track)&notes=\(notes)"
        
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) {
            data,
            response,
            error in
            
            if let error = error {
                print(error)
                return
            }
            
            print("Track gespeichert")
            
        }.resume()
    }
    
    static func addTrackWithImage(
        title: String,
        mood: String,
        artist: String,
        track: String,
        notes: String,
        image: UIImage?
    ) {

        guard let url = URL(
            string: "https://pbd2h24ani.web.bib.de/moodflow/addTrack.php"
        ) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString

        request.setValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )

        var data = Data()

        func appendField(
            name: String,
            value: String
        ) {

            data.append(
                "--\(boundary)\r\n".data(using: .utf8)!
            )

            data.append(
                "Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n"
                    .data(using: .utf8)!
            )

            data.append(
                "\(value)\r\n"
                    .data(using: .utf8)!
            )
        }

        appendField(name: "title", value: title)
        appendField(name: "mood", value: mood)
        appendField(name: "artist", value: artist)
        appendField(name: "track", value: track)
        appendField(name: "notes", value: notes)

        if let image,
           let imageData = image.jpegData(compressionQuality: 0.8) {

            data.append(
                "--\(boundary)\r\n".data(using: .utf8)!
            )

            data.append(
                "Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n"
                    .data(using: .utf8)!
            )

            data.append(
                "Content-Type: image/jpeg\r\n\r\n"
                    .data(using: .utf8)!
            )

            data.append(imageData)

            data.append(
                "\r\n".data(using: .utf8)!
            )
        }

        data.append(
            "--\(boundary)--\r\n".data(using: .utf8)!
        )

        request.httpBody = data

        URLSession.shared.dataTask(with: request) {
            _, _, error in

            if let error = error {

                print(error)
                return
            }

            print("Track mit Bild gespeichert")

        }.resume()
    }
    
    static func deleteTrack(id: String) {
        
        guard let url = URL(string:
                                "https://pbd2h24ani.web.bib.de/moodflow/deleteTrack.php"
        ) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "id=\(id)"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { _, _, _ in
            
            print("Track gelöscht")
            
        }.resume()
    }
    
    static func toggleFavorite(id: String) {

        guard let url = URL(
            string: "https://pbd2h24ani.web.bib.de/moodflow/favoriteTrack.php"
        ) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body = "id=\(id)"
        request.httpBody = body.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { _, _, _ in

            print("Favorite geändert")

        }.resume()
    }
    
    static func updateTrack(
        id: String,
        title: String,
        mood: String,
        artist: String,
        track: String,
        notes: String
    ) {

        guard let url = URL(
            string: "https://pbd2h24ani.web.bib.de/moodflow/updateTrack.php"
        ) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body =
        "id=\(id)&title=\(title)&mood=\(mood)&artist=\(artist)&track=\(track)&notes=\(notes)"

        request.httpBody = body.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { _, _, _ in

            print("Track aktualisiert")

        }.resume()
    }
}

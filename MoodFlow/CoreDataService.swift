import Foundation
import CoreData
import UIKit

class CoreDataService {

    static let shared = CoreDataService()

    private let context =
        PersistenceController.shared.container.viewContext

    @discardableResult
    func saveTrack(_ track: Track) -> Bool {

        let request: NSFetchRequest<LocalTrack> = LocalTrack.fetchRequest()

        request.predicate = NSPredicate(
            format: "title == %@ AND artist == %@",
            track.title,
            track.artist
        )

        if let _ = try? context.fetch(request).first {
            return false
        }

        let localTrack = LocalTrack(context: context)

        localTrack.id = UUID()
        localTrack.title = track.title
        localTrack.mood = track.mood
        localTrack.artist = track.artist
        localTrack.track = track.track
        localTrack.notes = track.notes
        localTrack.isFavorite = false
        localTrack.isLocal = false

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = formatter.date(from: track.date) {
            localTrack.date = date
        } else {
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: track.date) {
                localTrack.date = date
            } else {
                localTrack.date = Date()
            }
        }

        if let imageUrl = track.imageUrl,
           let url = URL(string: "https://pbd2h24ani.web.bib.de/moodflow/\(imageUrl)"),
           let data = try? Data(contentsOf: url) {
            localTrack.imageData = data
        }

        do {
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func isTrackSaved(_ track: Track) -> Bool {
        let request: NSFetchRequest<LocalTrack> = LocalTrack.fetchRequest()
        request.predicate = NSPredicate(
            format: "title == %@ AND artist == %@",
            track.title,
            track.artist
        )
        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }
}

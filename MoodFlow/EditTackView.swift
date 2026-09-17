import SwiftUI
import CoreData

struct EditTrackView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    let track: LocalTrack

    @State private var title: String
    @State private var mood: String
    @State private var artist: String
    @State private var trackName: String
    @State private var notes: String

    init(track: LocalTrack) {
        self.track = track
        _title = State(initialValue: track.title ?? "")
        _mood = State(initialValue: track.mood ?? "")
        _artist = State(initialValue: track.artist ?? "")
        _trackName = State(initialValue: track.track ?? "")
        _notes = State(initialValue: track.notes ?? "")
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 15) {
                TextField("Title", text: $title)
                TextField("Mood", text: $mood)
                TextField("Artist", text: $artist)
                TextField("Track", text: $trackName)
                TextEditor(text: $notes).frame(height: 150)
                Button("Save") {
                    track.title = title
                    track.mood = mood
                    track.artist = artist
                    track.track = trackName
                    track.notes = notes
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                .fontWeight(.bold)
            }
            .padding()
        }
        .navigationTitle("Edit")
    }
}

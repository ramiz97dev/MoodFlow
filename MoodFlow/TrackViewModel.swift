import Foundation
import Combine

class TrackViewModel: ObservableObject {

    @Published var tracks: [Track] = []

    func loadIdeas() {

        guard let url = URL(string: "https://pbd2h24ani.web.bib.de/moodflow/tracks.php") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print("Fehler: \(error)")
                return
            }

            guard let data = data else {
                return
            }

            do {
                let decodedTracks = try JSONDecoder().decode([Track].self, from: data)

                DispatchQueue.main.async {
                    self.tracks = decodedTracks
                }

            } catch {
                print("JSON Fehler: \(error)")
            }

        }.resume()
    }
}

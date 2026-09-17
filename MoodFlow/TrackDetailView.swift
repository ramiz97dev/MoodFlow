import SwiftUI

struct TrackDetailView: View {

    let track: LocalTrack
    var showEditButton: Bool = true

    @Environment(\.openURL) var openURL

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    Text(track.title ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(track.mood ?? "")
                        .font(.title2)
                        .foregroundColor(.purple)

                    Text("\(track.artist ?? "") – \(track.track ?? "")")
                        .foregroundColor(.gray)

                    if let data = track.imageData,
                       let image = UIImage(data: data) {

                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    }

                    Divider()

                    Text("Notes")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(track.notes ?? "")
                        .foregroundColor(.white)

                    Divider()

                    if let date = track.date {

                        Text(date.formatted(date: .numeric, time: .omitted))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Button("Open in YouTube") {

                        let query =
                        "\(track.artist ?? "") \(track.track ?? "")"
                            .addingPercentEncoding(
                                withAllowedCharacters: .urlQueryAllowed
                            ) ?? ""

                        if let url = URL(
                            string: "https://www.youtube.com/results?search_query=\(query)"
                        ) {

                            openURL(url)
                        }
                    }
                    .foregroundColor(.red)
                    .fontWeight(.bold)

                    if showEditButton {

                        NavigationLink {

                            EditTrackView(track: track)

                        } label: {

                            Text("Edit")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                        }

                    }

                }
                .padding()

            }

        }
        .navigationTitle("Details")

    }

}

#Preview {

    ContentView()

}

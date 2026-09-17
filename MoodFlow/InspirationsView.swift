import SwiftUI

struct InspirationsView: View {

    @StateObject private var viewModel = TrackViewModel()
    @State private var savedTracks: Set<String> = []

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                ScrollView {

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Inspirations")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("Discover ideas and save them to your journal")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        LazyVStack(spacing: 16) {

                            ForEach(viewModel.tracks) { track in

                                HStack(alignment: .top, spacing: 14) {

                                    if let imageUrl = track.imageUrl {

                                        AsyncImage(
                                            url: URL(string: "https://pbd2h24ani.web.bib.de/moodflow/\(imageUrl)")
                                        ) { image in

                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 105, height: 105)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))

                                        } placeholder: {

                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 85, height: 85)

                                        }

                                    }

                                    VStack(alignment: .leading, spacing: 6) {

                                        if !track.mood.trimmingCharacters(in: .whitespaces).isEmpty {

                                            Text(track.mood)
                                                .font(.caption2)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.purple.opacity(0.2))
                                                .foregroundColor(.purple)
                                                .clipShape(Capsule())

                                        }

                                        Text(track.title)
                                            .font(.headline)
                                            .foregroundColor(.white)

                                        Text("\(track.artist) – \(track.track)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)

                                        if !track.notes.trimmingCharacters(in: .whitespaces).isEmpty {

                                            Text(track.notes)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                                .lineLimit(2)

                                        }

                                    }

                                    Spacer()

                                    Button {

                                        if CoreDataService.shared.saveTrack(track) {
                                            savedTracks.insert(track.id)
                                        }

                                    } label: {

                                        if savedTracks.contains(track.id) {

                                            Label("Saved", systemImage: "checkmark.circle.fill")
                                                .font(.caption)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 8)
                                                .foregroundColor(.green)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.green)
                                                )

                                        } else {

                                            Label("Save", systemImage: "plus.circle")
                                                .font(.caption)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 8)
                                                .foregroundColor(.purple)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.purple)
                                                )

                                        }

                                    }
                                    .disabled(savedTracks.contains(track.id))

                                }
                                .padding(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    Color(red: 0.12, green: 0.12, blue: 0.14)
                                )
                                .cornerRadius(18)

                            }

                        }

                    }
                    .padding()

                }

            }
            .onAppear {

                viewModel.loadIdeas()

                savedTracks.removeAll()

                for track in viewModel.tracks {

                    if CoreDataService.shared.isTrackSaved(track) {
                        savedTracks.insert(track.id)
                    }

                }

            }

        }

    }

}

#Preview {
    InspirationsView()
}

import SwiftUI
import CoreData

struct JournalView: View {

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LocalTrack.date, ascending: false)
        ]
    )
    private var localTracks: FetchedResults<LocalTrack>

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black.ignoresSafeArea()

                ScrollView {

                    VStack(alignment: .leading) {

                        Text("Journal")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        LazyVStack(spacing: 16) {

                            ForEach(localTracks) { track in
                                JournalTrackCard(track: track)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct JournalTrackCard: View {

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var track: LocalTrack

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {

                Text(track.title ?? "")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Spacer()

                Button {

                    track.isFavorite.toggle()

                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }

                } label: {

                    Image(systemName: track.isFavorite ? "star.fill" : "star")
                        .foregroundColor(.purple)
                        .font(.title3)
                }
                .buttonStyle(.plain)

                Button {

                    viewContext.delete(track)

                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }

                } label: {

                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .font(.title3)
                }
                .buttonStyle(.plain)
            }

            NavigationLink {
                TrackDetailView(track: track)
            } label: {

                HStack(alignment: .top, spacing: 16) {

                    if let data = track.imageData,
                       let image = UIImage(data: data) {

                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    VStack(alignment: .leading, spacing: 8) {

                        Text(track.mood ?? "")
                            .font(.subheadline)
                            .foregroundColor(.purple)

                        Label(
                            "\(track.artist ?? "") – \(track.track ?? "")",
                            systemImage: "music.note"
                        )
                        .font(.subheadline)
                        .foregroundColor(.gray)

                        if let date = track.date {
                            Label(
                                date.formatted(date: .numeric, time: .omitted),
                                systemImage: "calendar"
                            )
                            .font(.caption)
                            .foregroundColor(.gray)
                        }
                    }

                    Spacer()
                }
            }
            .buttonStyle(.plain)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.12, green: 0.12, blue: 0.14))
        .cornerRadius(20)
    }
}

#Preview {
    ContentView()
}

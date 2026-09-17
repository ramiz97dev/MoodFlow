import SwiftUI
import CoreData

struct FavoritesView: View {
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LocalTrack.date, ascending: false)
        ],
        predicate: NSPredicate(format: "isFavorite == true")
    )
    private var favoriteTracks: FetchedResults<LocalTrack>
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(alignment: .leading) {

                        Text("Favorites")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        LazyVStack(spacing: 16) {

                            ForEach(favoriteTracks) { track in

                                NavigationLink {
                                    TrackDetailView(track: track, showEditButton: false)
                                } label: {
                                    
                                    VStack(alignment: .leading, spacing: 12) {
                                        
                                        HStack {
                                            
                                            Text(track.title ?? "")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.purple)
                                                .font(.title3)
                                        }
                                        
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
                                                    .foregroundColor(.purple)
                                                
                                                Label(
                                                    "\(track.artist ?? "") – \(track.track ?? "")",
                                                    systemImage: "music.note"
                                                )
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
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(red: 0.12, green: 0.12, blue: 0.14))
                                    .cornerRadius(20)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
}

import SwiftUI

struct ContentView: View {

    var body: some View {

        TabView {

            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "book")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            AddEntryView()
                .tabItem {
                    Label("Add Entry", systemImage: "plus.circle")
                }

            InspirationsView()
                .tabItem {
                    Label("Ideas", systemImage: "lightbulb")
                }
        }
        .tint(.purple)
    }
}

#Preview {
    ContentView()
}

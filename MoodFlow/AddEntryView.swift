//
//  AddEntryView.swift
//  MoodFlow
//

import SwiftUI
import PhotosUI
import CoreData

struct AddEntryView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @State private var title = ""
    @State private var mood = ""
    @State private var artist = ""
    @State private var track = ""
    @State private var notes = ""
    @State private var date = Date()

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?

    @State private var isSaved = false
    @State private var errorMessage: String?

    private let fieldColor = Color(
        red: 0.10,
        green: 0.10,
        blue: 0.12
    )

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black
                    .ignoresSafeArea()

                ScrollView {

                    VStack(alignment: .leading, spacing: 18) {

                        header

                        inputSection(
                            title: "Title",
                            icon: "pencil",
                            placeholder: "Enter title",
                            text: $title
                        )

                        inputSection(
                            title: "Mood",
                            icon: "face.smiling",
                            placeholder: "Enter mood",
                            text: $mood
                        )

                        inputSection(
                            title: "Artist",
                            icon: "person",
                            placeholder: "Enter artist",
                            text: $artist
                        )

                        inputSection(
                            title: "Track",
                            icon: "music.note",
                            placeholder: "Enter track name",
                            text: $track
                        )

                        dateSection

                        notesSection

                        imageSection

                        if let errorMessage {

                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        Button {
                            saveEntry()
                        } label: {

                            Label(
                                isSaved ? "Saved" : "Save Entry",
                                systemImage: isSaved
                                    ? "checkmark.circle.fill"
                                    : "plus.circle"
                            )
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .foregroundColor(
                                isSaved ? .green : .purple
                            )
                            .background(
                                isSaved
                                    ? Color.green.opacity(0.15)
                                    : Color.purple.opacity(0.15)
                            )
                            .overlay {

                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        isSaved ? Color.green : Color.purple,
                                        lineWidth: 1
                                    )
                            }
                            .clipShape(
                                RoundedRectangle(cornerRadius: 14)
                            )
                        }
                        .disabled(
                            title.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            ).isEmpty || isSaved
                        )
                        .opacity(
                            title.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            ).isEmpty ? 0.5 : 1
                        )

                        Spacer(minLength: 90)
                    }
                    .padding()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .onChange(of: selectedItem) {
                Task {

                    guard let data = try? await selectedItem?.loadTransferable(
                        type: Data.self
                    ) else {
                        return
                    }

                    await MainActor.run {
                        selectedImage = UIImage(data: data)
                    }
                }
            }
        }
    }

    private var header: some View {

        HStack {

            Text("Add Entry")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Spacer()
        }
    }

    private func inputSection(
        title: String,
        icon: String,
        placeholder: String,
        text: Binding<String>
    ) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.headline)
                .foregroundColor(.white)

            HStack(spacing: 12) {

                Image(systemName: icon)
                    .foregroundColor(.purple)
                    .frame(width: 22)

                TextField(placeholder, text: text)
                    .foregroundColor(.white)
                    .textInputAutocapitalization(.sentences)
            }
            .padding()
            .background(fieldColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
        }
    }

    private var dateSection: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("Date")
                .font(.headline)
                .foregroundColor(.white)

            HStack {

                Image(systemName: "calendar")
                    .foregroundColor(.purple)

                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: .date
                )
                .labelsHidden()
                .colorScheme(.dark)

                Spacer()
            }
            .padding()
            .background(fieldColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
        }
    }

    private var notesSection: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("Notes")
                .font(.headline)
                .foregroundColor(.white)

            ZStack(alignment: .topLeading) {

                if notes.isEmpty {

                    HStack(spacing: 10) {

                        Image(systemName: "note.text")
                            .foregroundColor(.purple)

                        Text("Write your thoughts...")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                    .allowsHitTesting(false)
                }

                TextEditor(text: $notes)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .frame(height: 130)
                    .padding(10)
                    .background(Color.clear)
            }
            .background(fieldColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
        }
    }

    private var imageSection: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text("Image")
                .font(.headline)
                .foregroundColor(.white)

            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {

                Label(
                    selectedImage == nil
                        ? "Select Image"
                        : "Change Image",
                    systemImage: "photo"
                )
                .fontWeight(.semibold)
                .foregroundColor(.purple)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(fieldColor)
                .clipShape(
                    RoundedRectangle(cornerRadius: 14)
                )
            }

            if let selectedImage {

                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )
                    .overlay(alignment: .topTrailing) {

                        Button {

                            self.selectedImage = nil
                            selectedItem = nil

                        } label: {

                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.black.opacity(0.6))
                                )
                        }
                        .padding(10)
                    }
            }
        }
    }

    private func saveEntry() {

        let cleanedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanedTitle.isEmpty else {

            errorMessage = "Please enter a title."
            return
        }

        let entry = LocalTrack(context: viewContext)

        entry.id = UUID()
        entry.title = cleanedTitle
        entry.mood = mood.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        entry.artist = artist.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        entry.track = track.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        entry.notes = notes.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        entry.date = date
        entry.isFavorite = false
        entry.isLocal = true

        if let selectedImage {

            entry.imageData = selectedImage.jpegData(
                compressionQuality: 0.8
            )
        }

        do {

            try viewContext.save()

            errorMessage = nil
            isSaved = true

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 1.2
            ) {

                resetForm()
                isSaved = false
            }

        } catch {

            viewContext.rollback()
            errorMessage = error.localizedDescription
        }
    }

    private func resetForm() {

        title = ""
        mood = ""
        artist = ""
        track = ""
        notes = ""
        date = Date()
        selectedImage = nil
        selectedItem = nil
    }
}

#Preview {

    AddEntryView()
        .environment(
            \.managedObjectContext,
            PersistenceController.shared.container.viewContext
        )
}

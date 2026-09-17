# MoodFlow 🎵

## Overview

MoodFlow is an iOS music journal application built with SwiftUI.

The app lets users save tracks together with a mood, notes, date and image. Tracks can be marked as favorites, edited later, or discovered through an online inspiration library.

The project combines a native iOS client with local Core Data storage and a PHP/MySQL backend for online inspiration data.

---

## Tech Stack

* Swift / SwiftUI
* Xcode
* Core Data
* PHP
* MySQL
* REST / JSON
* URLSession / AsyncImage

---

## Features

* Create personal music journal entries
* Add mood, artist, track, notes, date and image
* Edit and delete saved entries
* Mark tracks as favorites
* Browse a dedicated Favorites view
* Load inspiration tracks from a MySQL database through a PHP API
* Save inspiration tracks into the local journal
* Local persistence with Core Data
* Online image loading for inspiration tracks

---

## App Structure

MoodFlow contains four main areas:

* **Journal** – displays locally saved tracks
* **Favorites** – shows tracks marked as favorites
* **Add Entry** – creates a new personal journal entry
* **Ideas / Inspirations** – loads inspiration tracks from the server

### Data Flow

```text
MySQL
  ↓
PHP API
  ↓ JSON
TrackViewModel
  ↓
InspirationsView
  ↓ Save
Core Data (LocalTrack)
  ↓
Journal / Favorites
```

Personal journal data is stored locally with Core Data. Inspiration data is loaded from the PHP/MySQL backend.

---

## Demo

A short screen recording of the application is available in `demo/MoodFlow_Demo.mov`.

---

## Backend

The `server` folder contains the PHP endpoints and a database export used during development.

Database credentials are intentionally not included in this public repository.

---

## Notes

The online inspiration feature depends on the original project server being available. Personal journal entries are stored locally on the device using Core Data.

---

## Author

Ramiz Niftaliev

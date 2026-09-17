# MoodFlow

## Overview

MoodFlow is an iOS music journal application built with SwiftUI.

The idea behind MoodFlow is to organize music not only by artist or track name, but also by the **mood and emotional character of a track**.

The app was originally designed with DJs and music enthusiasts in mind. When preparing a DJ set, the atmosphere and feeling of a track can be just as important as its genre or BPM. MoodFlow allows users to build a personal collection of tracks and describe the mood, feeling or atmosphere they associate with each one.

This can make it easier to rediscover tracks and select music that fits the desired direction of a DJ set.

At the same time, MoodFlow is not limited to DJs. Any music listener can use it as a personal music journal to collect favorite tracks, connect them with memories or emotions, add notes and images, and organize their own music discoveries.

The project combines a native iOS application with local Core Data storage and a PHP/MySQL backend for online inspiration data.

---

## Concept

Instead of treating music as just a list of songs, MoodFlow focuses on the connection between **music and emotion**.

For example, a track can be described as:

* Melancholic
* Energetic
* Dreamy
* Dark
* Peaceful
* Reflective

Users can save tracks together with these moods, personal notes, dates and images.

For DJs, this creates a personal collection that can help when searching for tracks with a particular atmosphere while preparing a set.

For regular listeners, it works as a music diary where songs can be connected with personal feelings, moments and memories.

---

## Tech Stack

* Swift
* SwiftUI
* Xcode
* Core Data
* PHP
* MySQL
* HTTP / JSON
* AsyncImage

---

## Features

* Create personal music journal entries
* Add title, mood, artist, track, notes, date and image
* Organize tracks around their mood and atmosphere
* Edit existing journal entries
* Delete saved entries
* Mark tracks as favorites
* Browse favorite tracks in a dedicated Favorites view
* Discover inspiration tracks from an online database
* Save inspiration tracks to the local journal
* Store personal data locally using Core Data
* Load images for online inspiration tracks

---

## App Structure

MoodFlow contains four main areas:

* **Journal** – displays locally saved music entries
* **Favorites** – shows tracks marked as favorites
* **Add Entry** – allows users to create a new personal journal entry
* **Ideas / Inspirations** – loads inspiration tracks from the online database

### Data Flow

```text
MySQL
  ↓
PHP
  ↓ JSON
TrackViewModel
  ↓
InspirationsView
  ↓ Save
Core Data (LocalTrack)
  ↓
Journal / Favorites
```

Personal journal data is stored locally using Core Data.

The Inspirations section receives track data from a MySQL database through a PHP backend. When an inspiration track is saved, it is added to the local Core Data journal.

---

## Demo

A short screen recording demonstrates the main features and user flow of MoodFlow.

**▶ [Watch MoodFlow Demo](demo/MoodFlow_Demo.mov)**

---

## Backend

The `server` folder contains the PHP scripts and a MySQL database export used during development.

The PHP backend connects the iOS application with the MySQL database and provides the inspiration data as JSON.

Database credentials are intentionally not included in this public repository.

---

## Requirements

* macOS
* Xcode
* iOS Simulator or iPhone

---

## Notes

Personal journal entries, favorites and locally saved images are stored on the device using Core Data.

The **Inspirations** section requires an internet connection and access to the PHP/MySQL backend.

If the original development server is unavailable, the local journal functionality can still be used independently.

---

## Author

**Ramiz Niftaliev**

# Todo App

## Overview

This project implements a minimal offline todo app where tasks only exist for the current day.
Each day automatically starts with a clean slate — there are no overdue tasks, no history, and no future scheduling.

The goal of the implementation was to keep the logic simple, predictable, and aligned with the product constraint rather than building a generic todo system.

## Architecture

The app follows a lightweight MVVM with clean architecture structure:

Presentation
* SwiftUI views
* ViewModel manages UI state

Data
* Repository abstracts persistence
* CoreData handles storage

The ViewModel never talks to CoreData directly — only through the repository.


* Fetch tasks where `createdAt >= startOfToday`
* AND `createdAt < startOfTomorrow`

This means:

* Yesterday’s tasks automatically disappear
* No background jobs required
* Works even if the app was closed overnight
* Keeps persistence simple and reliable

The database keeps history, but the UI always represents “today”.

---

## Persistence Choice

CoreData was chosen because:

* Fully offline
* Handles structured data cleanly
* Efficient filtering using predicates
* Avoids manual JSON parsing or file management

SwiftData was avoided to maintain compatibility and predictability.

## Tradeoffs

Kept intentionally minimal:

* No categories or priorities
* No multi-day scheduling
* No syncing
* No edit screen

Focus was correctness of time-based behavior over feature count and single task deletion.

## What I Would Improve With More Time

* Local notification before day ends
* Widget showing today’s remaining tasks
* Animations for completion transitions
* Dependency injection for repository

## Running the Project

* iOS 16+
* Fully offline
* No configuration required
* Launch and add tasks — tomorrow they reset automatically


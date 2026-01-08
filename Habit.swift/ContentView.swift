//
//  ContentView.swift
//  Habit.swift
//
//  Created by Ethan on 07/01/26.
//

import Foundation
import SwiftUI

// MARK: - Model
struct Habit: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

// MARK: - View
struct ContentView: View {

    @StateObject private var viewModel = TodayViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                header
                progressText
                progressBar
                habitList
                resetButton
            }
            .padding()
            .navigationTitle("Today")
        }
    }

    // MARK: - Header
    private var header: some View {
        Text("Daily Discipline")
            .font(.largeTitle)
            .bold()
    }

    // MARK: - Progress Text
    private var progressText: some View {
        Text("\(viewModel.completedCount) / \(viewModel.habits.count) completed")
            .font(.title3)
            .foregroundColor(.secondary)
    }

    // MARK: - Progress Bar
    private var progressBar: some View {
        ProgressView(
            value: Double(viewModel.completedCount),
            total: Double(max(viewModel.habits.count, 1))
        )
        .progressViewStyle(.linear)
    }

    // MARK: - Habit List / Empty State
    private var habitList: some View {
        Group {
            if viewModel.habits.isEmpty {
                ContentUnavailableView(
                    "No habits today",
                    systemImage: "checklist",
                    description: Text("Add habits to start your discipline")
                )
            } else {
                List {
                    ForEach(viewModel.habits) { habit in
                        HabitRow(
                            habit: habit,
                            onToggle: {
                                viewModel.toggleHabit(habit)
                            }
                        )
                    }
                }
                .listStyle(.plain)
            }
        }
    }

    // MARK: - Reset Button
    private var resetButton: some View {
        Button("Reset Day") {
            viewModel.resetDay()
        }
        .foregroundColor(.red)
        .padding(.top, 8)
    }
}

#Preview {
    ContentView()
}

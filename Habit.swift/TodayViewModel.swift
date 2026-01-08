//
//  TodayViewModel.swift
//  Habit.swift
//
//  Created by Ethan on 07/01/26.
//

import Foundation
import Combine

final class TodayViewModel: ObservableObject {

    @Published var habits: [Habit] = [] {
        didSet {
            store.save(habits)
        }
    }

    private let store = HabitsStore()

    init() {
        habits = store.load()
    }

    var completedCount: Int {
        habits.filter { $0.isCompleted }.count
    }

    func toggleHabit(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index].isCompleted.toggle()
    }

    func resetDay() {
        for index in habits.indices {
            habits[index].isCompleted = false
        }
    }
}

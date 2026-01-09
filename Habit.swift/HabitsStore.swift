//
//  HabitsStore.swift
//  Habit.swift
//
//  Created by Ethan on 07/01/26.
//

import Foundation

final class HabitsStore {

    private let key = "daily_habits"

    func save(_ habits: [Habit]) {
        guard let data = try? JSONEncoder().encode(habits) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    func load() -> [Habit] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let habits = try? JSONDecoder().decode([Habit].self, from: data)
        else {
            return defaultHabits()
        }
        return habits
    }

    private func defaultHabits() -> [Habit] {
        [
            Habit(title: "Study iOS"),
            Habit(title: "Walk a Mile"),
            Habit(title: "Workout"),
            Habit(title: "Drink Water"),
            Habit(title: "Sleep on Time")
        ]
    }
}

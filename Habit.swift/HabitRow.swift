//
//  HabitRow.swift
//  Habit.swift
//
//  Created by Ethan on 07/01/26.
//

import SwiftUI

struct HabitRow: View {

    let habit: Habit
    let onToggle: () -> Void

    var body: some View {
        HStack {
            Text(habit.title)
                .strikethrough(habit.isCompleted)
                .opacity(habit.isCompleted ? 0.4 : 1)

            Spacer()

            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(habit.isCompleted ? .green : .gray)
                .onTapGesture {
                    onToggle()
                }
        }
        .padding(.vertical, 6)
    }
}

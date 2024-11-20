//
//  ContentView.swift
//  Guess The TVSHOW
//
//  Created by Hafsa Tazrian on 11/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tvShows = [
        (character: "Chandler", show: "Friends", image: "chandler"),
        (character: "Dwight", show: "The Office", image: "dwight"),
        (character: "Sheldon", show: "The Big Bang Theory", image: "sheldon"),
        (character: "Michael", show: "The Office", image: "michael"),
        (character: "Rachel", show: "Friends", image: "rachel"),
        (character: "Walter", show: "Breaking Bad", image: "walter"),
        (character: "Tommy", show: "Peaky Blinders", image: "tommy"),
        (character: "Lorelai", show: "Gilmore Girls", image: "lorelai"),
        (character: "Jon Snow", show: "Game of Thrones", image: "jonsnow"),
        (character: "Eleven", show: "Stranger Things", image: "eleven")
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(colors: [
                Color(red: 0.95, green: 0.78, blue: 0.1),
                Color(red: 0.9, green: 0.2, blue: 0.6),
                Color(red: 0.1, green: 0.6, blue: 0.8)
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the TV Show")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Who is ")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.secondary)
                        +
                        Text("\(tvShows[correctAnswer].character.uppercased())")
                            .font(.title2.weight(.bold))
                            .foregroundColor(Color.black.opacity(0.9)) +
                        Text(" from ")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.secondary) +
                        Text("\(tvShows[correctAnswer].show.uppercased())?")
                            .font(.title2.weight(.bold))
                            .foregroundColor(Color.black.opacity(0.9))
                    }
                    .multilineTextAlignment(.center)

                    ForEach(0..<3) { number in
                        Button {
                            characterTapped(number)
                        } label: {
                            Image(tvShows[number].image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 266.67, height: 150) // 16:9 aspect ratio
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.white, lineWidth: 4)
                                )
                                .shadow(radius: 8)
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.white.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()

            // Custom Modal Alert
            if showingScore {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text(scoreTitle)
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)

                        Text("Your score is \(score)")
                            .font(.title2)
                            .foregroundColor(.white)

                        Button(action: askQuestion) {
                            Text("CONTINUE")
                                .font(.title3.weight(.bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue]),
                                        startPoint: .top, endPoint: .bottom
                                    )
                                )
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding(.horizontal, 40)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(40)
                }
            }
        }
    }

    func characterTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }

        showingScore = true
    }

    func askQuestion() {
        tvShows.shuffle()
        correctAnswer = Int.random(in: 0...2)
        showingScore = false
    }
}

#Preview {
    ContentView()
}

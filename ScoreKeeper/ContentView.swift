//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by AdvocatesClose on 4/7/25.
//

import SwiftUI

struct ContentView: View {
	@State private var scoreboard = Scoreboard()
	@State private var startingPoints = 0

    var body: some View {
		VStack(alignment: .leading) {
			Text("Score Keeper")
				.font(.title)
				.bold()
				.padding(.bottom)

			SettingsView(doesHighestScoreWin: $scoreboard.doesHighestScoreWin, startingPoints: $startingPoints)

			Grid {
				GridRow {
					Text("Player")
						.gridColumnAlignment(.leading)
					Text("Score")
						.opacity(scoreboard.state == .setup ? 0 : 1.0)
				}
				.font(.headline)

				ForEach($scoreboard.players) { $player in
					GridRow {
						HStack {
							TextField("Name", text: $player.name)
						}
						Text("\(player.score)")
							.opacity(scoreboard.state == .setup ? 0 : 1.0)
						Stepper("\(player.score)", value: $player.score)
							.labelsHidden()
							.opacity(scoreboard.state == .setup ? 0 : 1.0)
					}
				}
			}
			.padding(.vertical)

			Button("Add Player", systemImage: "plus") {
				scoreboard.players.append(Player(name: "", score: 0))
			}
			.opacity(scoreboard.state == .setup ? 1.0 : 0)

			Spacer()

			HStack {
				Spacer()

				switch scoreboard.state {
					case .setup:
						Button("Start Game", systemImage: "play.fill") {
							scoreboard.state = .playing
							scoreboard.resetScores(to: startingPoints)
						}
					case .playing:
						Button("End Game", systemImage: "stop.fill") {
							scoreboard.state = .gameOver
						}
					case .gameOver:
						Button("Reset Game", systemImage: "arrow.counterclockwise") {
							scoreboard.state = .setup
						}
				}
				Spacer()
			}
			.buttonStyle(.bordered)
			.buttonBorderShape(.capsule)
			.controlSize(.large)
			.tint(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

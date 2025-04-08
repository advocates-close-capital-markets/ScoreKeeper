//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by AdvocatesClose on 4/7/25.
//

import Testing
@testable import ScoreKeeper

struct ScoreKeeperTests {

	@Test("Reset player scores", arguments: [0, 10, 20])
	func resetScores(to newValue: Int) async throws {
		var scoreboard = Scoreboard(players: [
			Player(name: "Elisha", score: 0),
			Player(name: "Andre", score: 5),
		])
		scoreboard.resetScores(to: newValue)

		for player in scoreboard.players {
			#expect(player.score == newValue)
		}
	}

	@Test("Highest score wins")
	func highestScoreWins() {
		let scoreboard = Scoreboard(
			players: [
				Player(name: "Elisha", score: 0),
				Player(name: "Andre", score: 4),
			],
			state: .gameOver,
			doesHighestScoreWin: true
		)
		let winners = scoreboard.winners
		#expect(winners == [Player(name: "Andre", score: 4)])
	}

}

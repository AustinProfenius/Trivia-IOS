//
//  ViewController.swift
//  Trivia
//
//  Created by Austin Profenius on 3/28/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        displayQuestion() // Show the first question when the view loads
    }
    
    var currentQuestionIndex = 0
    var score = 0
    
    func displayQuestion() {
        // check if we've run out of questions
        guard currentQuestionIndex < questions.count else {
            showGameOverAlert()
            return
        }


        // Retrieve current question
        let currentQuestion = questions[currentQuestionIndex]

        // Update UI elements
        question.text = currentQuestion.text
        topic.text = currentQuestion.topic // Update topic label
        questionNumber.text = "Question: \(currentQuestionIndex + 1) / \(questions.count)" // Update question number label

        button1.setTitle(currentQuestion.answers[0], for: .normal)
        button2.setTitle(currentQuestion.answers[1], for: .normal)
        button3.setTitle(currentQuestion.answers[2], for: .normal)
        button4.setTitle(currentQuestion.answers[3], for: .normal)

        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        button4.tag = 3

        setAnswerButtonsEnabled(true)
    }

    func setAnswerButtonsEnabled(_ isEnabled: Bool) {
         button1.isEnabled = isEnabled
         button2.isEnabled = isEnabled
         button3.isEnabled = isEnabled
         button4.isEnabled = isEnabled
     }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard currentQuestionIndex < questions.count else { return } // Avoid issues after game ends

        let selectedAnswerIndex = sender.tag
        let correctAnswerIndex = questions[currentQuestionIndex].correctAnswerIndex

        // Check if the answer is correct and update score
        if selectedAnswerIndex == correctAnswerIndex {
            score += 1
            print("Correct! Score: \(score)") // For debugging
        } else {
            print("Incorrect. Score: \(score)") // For debugging
        }

        
        currentQuestionIndex += 1 // Move to the next question
        displayQuestion() // Display the next question or trigger game over
    }
    
    // Function to show the final score and restart option
    func showGameOverAlert() {
         setAnswerButtonsEnabled(false)

        let alert = UIAlertController(title: "Game Over!",
                                      message: "Final Score: \(score) / \(questions.count)", // Display final score
                                      preferredStyle: .alert)

        let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
            self?.restartGame()
        }
        alert.addAction(restartAction) 

        present(alert, animated: true, completion: nil)
    }

    // Function to reset the game state
    func restartGame() {
        score = 0
        currentQuestionIndex = 0
        displayQuestion() // Show the first question again
    }

    
    let questions: [Question] = [
        Question(text: "What is the capital of France?", answers: ["London", "Berlin", "Paris", "Madrid"], correctAnswerIndex: 2, topic: "Geography"),
        Question(text: "Which planet is known as the Red Planet?", answers: ["Earth", "Mars", "Jupiter", "Venus"], correctAnswerIndex: 1, topic: "Science: Astronomy"),
        Question(text: "What is the largest ocean on Earth?", answers: ["Atlantic", "Indian", "Arctic", "Pacific"], correctAnswerIndex: 3, topic: "Geography"),
        Question(text: "What is the last song on the first Panic! At The Disco album?", answers: ["Lying Is The Most Fun...", "Nails for Breakfast...", "Build God, Then We'll Talk", "I Write Sins Not Tragedies"], correctAnswerIndex: 2, topic: "Entertainment: Music")
    ]
    

    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
}

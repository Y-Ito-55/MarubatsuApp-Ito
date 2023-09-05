//
//  ViewController.swift
//
//
//  Created by Ngos on
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    
    
    
    // Put Question number
    var currentQuestionNum: Int = 0
    
    // 問題
    var questions: [[String: Any]] = [
//        [
//            "question": "iPhoneアプリを開発する統合環境はZcodeである",
//            "answer": false
//        ],
//        [
//            "question": "Xcode画面の右側にはユーティリティーズがある",
//            "answer": true
//        ],
//        [
//            "question": "UILabelは文字列を表示する際に利用する",
//            "answer": true
//        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQestion()
        // Display question after loading
    }
    
    
    // Display question
    func showQestion(){
        if currentQuestionNum >= questions.count {
            questionLabel.text = "問題がありません"
            return
        }
        
        let question = questions[currentQuestionNum]
        
        if let que = question["question"] as? String {
            questionLabel.text = que
        }
    }
    
    // Check answer is corrent proceed next question
    func checkAnswer(yourAnswer: Bool){
        // 現在の問題番号がquestionsの範囲外である場合、アラートを表示して関数を終了
        if currentQuestionNum >= questions.count {
            showAlert(message: "問題がありません")
            return
        }
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool{
            if yourAnswer == ans {
                // When correct answer
                // Plus 1 to currentQuestionNum and next question
                currentQuestionNum += 1
                showAlert(message: "正解!")
            } else {
                // When incorrect
                showAlert(message: "不正解!")
            }
            
        } else { // When not answer
            print("答えが入っていません")
            return
        }
        // if currentQuestionNum more tha qty of Question, back to initial question
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        
        showQestion() //Correct -> next Question, Incorrect -> Same question.
    }
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    // 問題作成画面に遷移するボタンのアクション
    @IBAction func createQuestionButtonTapped(_ sender: Any) {
        let createQuestionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateQuestionViewController") as! CreateQuestionViewController
        createQuestionVC.questions = self.questions
        createQuestionVC.delegate = self // ViewControllerをデリゲートとして設定
        present(createQuestionVC, animated: true, completion: nil)
    }

}
// CreateQuestionViewControllerからのデータを受け取るための拡張
extension ViewController: CreateQuestionDelegate {
    func didUpdateQuestions(updatedQuestions: [[String : Any]]) {
        self.questions = updatedQuestions
        currentQuestionNum = 0
        showQestion()
    }
}

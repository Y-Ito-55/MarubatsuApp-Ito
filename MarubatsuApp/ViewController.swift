//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by Yumi Ito on 2023/09/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var Segment: UISegmentedControl!   //宿題で追加
    
    // 表示中の問題番号を格納
    var currentQuestionNum: Int = 0
    // 問題
    let questions: [[String: Any]] = [
        [
            "question": "iPhoneアプリを開発する統合環境はZcodeである",
            "answer": false
        ],
        [
            "question": "Xcode画面の右側にはユーティリティーズがある",
            "answer": true
        ],
        [
            "question": "UILabelは文字列を表示する際に利用する",
            "answer": true
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
        segmented.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)  //宿題で追加
        
    }
    
    //問題を表示する関数
    func showQuestion(){
        let question = questions[currentQuestionNum]
        
        if let que = question["question"] as? String {
            questionLabel.text = que
    }
    
    //回答チェックの関数、正解なら次の問題を表示
    func checkAnswer(yourAnswer: Bool){
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"]as? Bool {
            if yourAnswer == ans {     //正解したときの処理
                currentQuestionNum += 1       //カレントクエスチョンなむに1を足して次の問題に進む
                showAlert(message: "正解！")
            } else {     //不正解のときの処理
                showAlert(message: "不正解…")
            }
            
        } else {        //答えがない時
            print("答えが入っていません")
            return
        }
        
        //カレントクエスチョンなむの値が問題数以上なら最初の問題へ
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        showQuestion()     //正解→次の問題を表示、不正解→同じ問題を表示
        
    }
    
    // アラート(今回の場合、正解不正解の文字が出る小さい窓がポップする)を表示する関数
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

        
}

    // 選択された時に実行させたい処理 宿題で追加
    @objc  func segmentChanged() {
        let selectedIndex = segmented.selectedSegmentIndex
        print(selectedIndex)
    }

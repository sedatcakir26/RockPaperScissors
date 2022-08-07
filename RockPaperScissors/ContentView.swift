//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sedat Çakır on 6.08.2022.
//

import SwiftUI


struct Title : ViewModifier{
    var text : String
    
    func body(content: Content) -> some View {
        Text(text)
            .font(.largeTitle.bold())
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(50)
        
        
    }
}

extension View{
    func title(with text : String) -> some View {
        modifier(Title(text:text))
    }
}

struct ContentView: View {
    
    @State private var options = ["rock","paper","scissors"]
    @State private var counting = 0
    @State private var appsMove = Int.random(in:0...2){
        willSet{
            result = options[appsMove]
        }
    }
    @State private var whoWinTheGame = " "
    @State private var winOrLose = false
    @State private var isGameFinished = false
    @State private var score = 0
    @State private var appScore = 0
    @State private var result = ""
    @State private var isGameStart = false
    @State private var winnigMoves = ["paper", "scissors", "rock"]
    
    
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.indigo, .mint]), startPoint: .top, endPoint: .bottom) .ignoresSafeArea()
            
            VStack{
                Spacer()
                    .title(with: "Rock  Paper  Scissors")
                
                Spacer()
                
                HStack(spacing:20){
                    ForEach(0..<3){number in
                        Button{
                            tapped(number)
                        }label: {
                            Image(options[number])
                                .renderingMode(.original)
                        }
                    }
                }
                Spacer()
                
                
                
                VStack{
                    Text("Player Score is: \(score)")
                    isGameStart ? Text("Apps move was \(result)") : Text(" ")
                 // isGameStart ? winOrLose ? Text("You win") : Text("You lose") : Text(" ")
                }
                
                Spacer()
                
            }
            
        }
        .alert("Your score is \(score) App score is \(appScore) and \(whoWinTheGame)", isPresented: $isGameFinished){
            Button("RESTART GAME", action: restartGame)
        }
    }
    func restartGame(){
        counting = 0
        isGameFinished = false
        isGameStart = false
        winOrLose = false
        score = 0
        appScore = 0
        appsMove = 0
        whoWinTheGame = " "
    }
    
    func tapped(_ number : Int){
        
        
        isGameStart = true
        counting += 1
        
        switch options[number]{
        case  "rock" :
            if options[appsMove] == "rock"{
                
            }
            else if options[appsMove] == "scissors" {
                winOrLose = true
                score += 1
            }
            else if options[appsMove] == "paper"{
                winOrLose = false
                appScore += 1
                
            }
        case  "paper" :
            if options[appsMove] == "rock"{
                winOrLose = true
                score += 1
            }
            else if options[appsMove] == "scissors" {
                winOrLose = false
                appScore += 1
            }
            
        case "scissors" :
            if options[appsMove] == "rock"{
                winOrLose = false
                appScore += 1
            }
            else if options[appsMove] == "paper"{
                winOrLose = true
                score += 1
            }
        default: break
            
        }
        
        appsMove = Int.random(in: 0..<3)
        
        if counting == 10{
            
            if score > appScore{
                whoWinTheGame = "You win the game"
            }
            else if appScore > score{
                whoWinTheGame = "App win the game"
            }
            else if appScore == score{
                whoWinTheGame = "Draw"
            }
            isGameFinished = true
            
            
        }
        //print("Score: \(score) AppScore: \(appScore)")
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

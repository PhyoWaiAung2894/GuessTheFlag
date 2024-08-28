//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by PhyoWai Aung on 6/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingScan = false
    @State private var gameCount = 8
    @State private var scoreTitle = ""
    @State private var scorePoint = 0
    @State private var countries = ["estonia","france","germany","ireland","italy","nigeria","poland","russia","spain","uk","us"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var selectedButton : Int? = nil
    @State private var animationAmount = [0.0, 0.0, 0.0]
   
    var body: some View {
        
        ZStack {
            RadialGradient(stops:[
                .init(color: Color(red: 0.1,green: 0.2,blue: 0.45), location: 0.3),
                .init(color: Color(red:0.76,green: 0.15,blue: 0.26), location: 0.3)
            ],center: .top,startRadius:200,endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing : 30){
                    
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .foregroundColor(.black)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            //flag was tapped
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .modifier(FlagOpacityModifier(selectedButton: selectedButton, number: number))
                                .modifier(FlagRotationModifier(animationAmount: animationAmount[number]))
                                .modifier(FlagScaleModifier(selectedButton: selectedButton, number: number))
                                .modifier(FlagFlipModifier(selectedButton: selectedButton, number: number))
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score \(scorePoint)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Game Remaining \(gameCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        } .alert(scoreTitle,isPresented: $showingScore){
            Button("Continue",action: askQuestion)
        }message: {
            Text("Your score mark \(scorePoint)")
        }
        .alert("Game is End.You got \(scorePoint)/8 marks",isPresented: $showingScan){
            Button("New Game",action:{
                startNewGame()
                askQuestion()
            })
        }
      
    }
    
    func flagTapped(_ number : Int){
        if number == correctAnswer{
            scoreTitle = "Correct Answer"
            scorePoint += 1
            gameCount -= 1
            showingScore = true
        }else{
            scoreTitle = "Wrong Answer.That's the flag of \(countries[number]) "
            gameCount -= 1
            showingScore = true
        }
        
        
        if gameCount == 0{
            showingScan = true
        }
    }
    func askQuestion(){
        selectedButton = nil
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func startNewGame(){
        scorePoint = 0
        gameCount = 8
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

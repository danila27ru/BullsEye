//
//  ContentView.swift
//  BallsEye
//
//  Created by Danila Gorelko on 3.4.20.
//  Copyright © 2020 Danila Gorelko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var roundValue = 1
    
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT", size: 18))
        }
    }

    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }

    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }

    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }

    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 14))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100")
            }
            .modifier(LabelStyle())
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit me")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(alertTitle()),
                             message: Text(
                                "The slider's value is \(sliderValueRounded()).\n" +
                                "You scored \(awardPoints()) points this round."),
                             dismissButton: .default(Text("Click here")) {
                                self.startNewRound()
                    }
                )}
                .background(Image("Button"))
                .modifier(ButtonLargeTextStyle())
            Spacer()
            
            // Score row //
            HStack {
                //Start Over
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Again").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                Spacer()
                
                // Score counter
                Text("Score:")
                    .foregroundColor(Color.white)
                Text("\(totalScore)").modifier(ValueStyle())
                Spacer()
                
                // Round counter
                Text("Round:")
                    .foregroundColor(Color.white)
                Text("\(roundValue)").modifier(ValueStyle())
                Spacer()
                
                // Information
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    func startNewGame() {
        resetScore()
        resetRound()
        updateTarget()
    }
    
    func startNewRound() {
        updateScore()
        updateRound()
        updateTarget()
    }
    
    func resetScore() {
        totalScore = 0
    }
    
    func resetRound() {
        roundValue = 0
    }
    
    func updateScore() {
        totalScore += awardPoints()
    }
    
    func updateTarget() {
        target = Int.random(in: 1...100)
    }
    
    func updateRound() {
        roundValue += 1
    }
    
    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    
    func awardPoints() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        
        return maximumScore - difference + bonus
    }
   
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().padding().previewLayout(.fixed(width: 896, height: 414))
    }
}

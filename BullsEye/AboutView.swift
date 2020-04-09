//
//  AboutView.swift
//  BullsEye
//
//  Created by Danila Gorelko on 8.4.20.
//  Copyright © 2020 Danila Gorelko. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    struct Heading: ViewModifier {
        func body(content: Content) -> some View {
            return
                content
                    .font(Font.custom("Arial Rounded MT Bold", size: 30))
                    .foregroundColor(Color.black)
                    .padding(.vertical, 20.0)
        }
    }
    
    struct TextView: ViewModifier {
        func body(content: Content) -> some View {
            return
                content
                    .font(Font.custom("Arial Rounded MT Bold", size: 16))
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 60)
                    .padding(.bottom, 20)
        }
    }
    
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯")
                    .modifier(Heading())
                Text("This is Bullseye, the game where you can win points and earn fame by draggin a slider")
                    .modifier(TextView())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(TextView())
                Text("Enjoy!")
                .modifier(TextView())
            }
            .background(Color(red: 255.0 / 255.0, green: 214 / 255.0, blue: 179 / 255.0))
            .navigationBarTitle("About Bullseye")
            .multilineTextAlignment(.center)
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().padding().previewLayout(.fixed(width: 896, height: 414))
    }
}

//
//  ContentView.swift
//  DogvsDog
//
//  Created by zan on 3/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var dog1: Dog?
    @State var dog2: Dog?
    @State var streak: Int = 0
    @State var upClicked: Bool = false
    @State var downClicked: Bool = false
    @State var streakIncrease: Bool = false
    @State private var angle: Double = 0
    @State private var angle2: Double = 0
    var body: some View {
        ZStack {
            Image("background").resizable().background()
            VStack {
                if let top_dog = dog1 {
                    DogImageView(dog: top_dog)
                }
                HStack {
                    Button(
                        action: {
                            print("Upvote")
                            Task {
                                await changeBottomDog()
                                upClicked = true
                                downClicked = false
                                angle += 360
                            }
                        },
                        label: {
                                Image("upvote")
                                .resizable()
                                .frame(width: 90, height: 105)
                        }
                    )
                    .rotationEffect(.degrees(angle))
                    .animation(.spring(), value: angle)
                    Button(
                        action: {
                            print("Downvote")
                            Task {
                                await changeTopDog()
                                downClicked = true
                                upClicked = false
                                angle2 += 360
                            }
                        },
                        label: {
                                Image("downvote")
                                .resizable()
                                .frame(width: 90, height: 105)
                        }
                    )
                    .rotationEffect(.degrees(angle2))
                    .animation(.spring(), value: angle2)
                }
                if let bottom_dog = dog2 {
                    DogImageView(dog: bottom_dog)
                }
            }
            if streakIncrease {
                Text("STREAK: \(streak) ").offset(y: 310).font(.title).foregroundColor(.red)
            }
        }.task {
            await getInitialDogs()
        }
    }
    
    func getInitialDogs() async {
        do {
            dog1 = try await getRandomDog()
            dog2 = try await getRandomDog()
        }
        catch {
            
        }
    }
    func changeTopDog() async {
        do {
            dog1 = try await getRandomDog()
        }
        catch {
            
        }
        if downClicked {
            streak += 1
            streakIncrease = true
        } else {
            streak = 0
            streakIncrease = false
        }
    }
    func changeBottomDog() async {
        do {
            dog2 = try await getRandomDog()
        }
        catch {
            
        }
        if upClicked {
            streak += 1
            streakIncrease = true
        }else {
            streak = 0
            streakIncrease = false
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

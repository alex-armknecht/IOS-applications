//
//  SettingsView.swift
//  CoolMathGame
//
//  Created by Aidan Dionisio on 3/7/22.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @EnvironmentObject var auth: Party_FinderAuth
    
    @State var requestLogin = false
    @State private var feedback: String = ""
    @State private var feedbackColor: Color = .red
    var body: some View {
        ZStack {
            Image("AppIcon").resizable().aspectRatio(contentMode: .fit).opacity(0.3)
            VStack {
                VStack {
                    Text("Settings")
                        .font(.title)
                        .bold()
//                    Picker("Operations", selection: $currentOps) {
//                        Label("Random", systemImage: "dice").tag(Operation.random)
//                        Label("Addition", systemImage: "plus").tag(Operation.add)
//                        Label("Subtraction", systemImage: "minus").tag(Operation.sub)
//                        Label("Multiplication", systemImage: "multiply").tag(Operation.mul)
//                        Label("Division", systemImage: "divide").tag(Operation.div)
//                    }.frame(width: 140, height: 40)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 3))
//                        .background(.white.opacity(0.8)).clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    if let authUI = auth.authUI {
                        HStack {
                            if (auth.user != nil) {
                                Button() {
                                    do {
                                        try auth.signOut()
                                    } catch {
                                        //error handling
                                        feedback = "Unable to sign out. Please try again."
                                        feedbackColor = .red
                                    }
                                } label : {
                                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                                }.frame(width: 150, height: 35)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.red, lineWidth: 3))
                                    .background(.red).clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Button() {
                                    requestLogin = true
                                } label : {
                                    Label("Sign In", systemImage: "square.and.pencil")
                                }.frame(width: 150, height: 35)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.green, lineWidth: 3))
                                    .background(.green).clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }.sheet(isPresented: $requestLogin) {
                            AuthenticationViewController(authUI: authUI)
                        }
                    } else {
                        Text("Cannot access authentication client. 🤷")
                    }
                    
                    Text(feedback).frame(height: 10).foregroundColor(feedbackColor)
                }.padding()
                
            
//                Button("Save Settings"){
//                    Task {
//                        updateSettings()
//                        try? await Task.sleep(nanoseconds: 3_000_000_000)
//                        feedback = ""
//                    }
//                }.frame(width: 150, height: 30)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.green, lineWidth: 3))
//                    .background(.green).clipShape(RoundedRectangle(cornerRadius: 10))

                VStack {
                    Text("Credits")
                        .font(.title)
                        .bold()
                    Text("Geocoding API by Google Maps")
                    VStack {
                        Text("Developers:").font(.headline)
                        VStack {
                            Text("Map Views:").font(.subheadline)
                            Text("Alexandria Armknecht")
                            Text("Tanya Nobal")
                        }.padding(.bottom, 1)
                        VStack {
                            Text("List Views / Firebase Backend").font(.subheadline)
                            Text("Alex Abrams")
                            Text("Aidan Dionisio")
                        }.padding(.bottom,1)
                        VStack {
                            Text("App Icon/Graphic:").font(.subheadline)
                            Text("Alexandria Armknecht")
                        }.padding(.bottom)
                    }
                    
                    Text("Made by the non-party people,\n for the party people.").italic()
                }.multilineTextAlignment(.center)
            }.padding()
        }
    }
    
//    func updateSettings() {
//        feedback = "Settings saved!"
//    }
}
    
    


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(Party_FinderAuth())
    }
}

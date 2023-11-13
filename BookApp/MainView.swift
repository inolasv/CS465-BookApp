//
//  MainView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/8/23.
//

import SwiftUI

struct FlipButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .background(Color("Beige4"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 1))
    }
}

struct MainView: View {
    @State private var isFlipped = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }) {
                    if isFlipped {
                        // The back of the card
                        BackView()
                            .frame(width: 340, height: 550)
                            .background(Color("lightGray"))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2))
                            .rotation3DEffect(.degrees(isFlipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                    } else {
                        // The front of the card
                        Image("cover")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 340, height: 550)
                            .background(Color("Beige3"))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 2))
                            .rotation3DEffect(.degrees(isFlipped ? -180 : 0), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .buttonStyle(FlipButton())
            }
            HStack {
                VStack {
                    Text("Listed By:")
                        .font(.custom("GochiHand-Regular", size: 25))
                        .frame(width: 220, height: 20, alignment: .leading)
                    Text("FirstName LastName")
                        .font(.custom("GochiHand-Regular", size: 25))
                        .frame(width: 220, height: 20, alignment: .leading)
                }
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.leading)
                
                    .padding(.vertical)
            }
            HStack {
                VStack {
                    Text("Also Borrowed By:")
                        .font(.custom("GochiHand-Regular", size: 25))
                        .frame(width: 290, height: 20, alignment: .leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<5, id: \.self) { _ in
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        
                    }
                }
            }
        }
    }
}

struct BackView: View {
    var body: some View {
        VStack {
            // Add the back view content
            Text("Back View")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

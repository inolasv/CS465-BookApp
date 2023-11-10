//
//  ProfileView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/8/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            VStack {
                Image("book_cover")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 196, height: 196, alignment: .center)
                    .clipShape(Circle())
                Text("FirstName LastName")
                    .font(.custom("GochiHand-Regular", size: 30))
                    .foregroundColor(.black)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. \n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    .font(.custom("GochiHand-Regular", size: 17))
                    .frame(width: 300, height: .infinity, alignment: .leading)
                    .foregroundColor(.black)
            }
            VStack {
                LazyHStack(alignment: .center, spacing: 130) {
                    Text("Listings")
                        .font(.custom("GochiHand-Regular", size: 26))
                        .foregroundColor(.black)
                    Button(action: {print("add listing clicked")}) {
                        Text("Add Listing")
                            .font(.custom("GochiHand-Regular", size: 15))
                            .foregroundColor(.black)
                            .frame(width: 100, height: 30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                                .stroke(.black, lineWidth: 2))
                    }
                }
                .frame(width: 330, height: 40, alignment: .leading)
                
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(1..<10) { index in
                            VStack() {
                                Button(action: {print("exit clicked")}) {
                                    Image("Exit")
                                        .frame(width: 120, height: 1, alignment: .trailing)
                                }
                                Text("Book \(index)")
                                    .font(.custom("GochiHand-Regular", size: 25))
                                    .frame(width: 120, height: 20, alignment: .leading)

                                Text("Author \(index)")
                                    .font(.custom("GochiHand-Regular", size: 16))
                                    .frame(width: 120, height: 10, alignment: .leading)

                                Image("book_cover")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 85, height: 110, alignment: .center)
                                    .clipped()
                                Button(action: {print("button clicked")}) {
                                    Text("Available")
                                        .font(.custom("GochiHand-Regular", size: 15))
                                        .foregroundColor(.black)
                                        
                                        .frame(width: 100, height: 30)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                            .stroke(.black, lineWidth: 1))
                                            .background(Color("lightGray"))
                                }

                            }
                            .frame(width: 150, height: 230, alignment: .center)
                            .background(.white)
                            .cornerRadius(25)
                            .overlay(RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color.black, lineWidth: 3))
                            }
                        }
                    }
                    .frame(width: .infinity, height: 230, alignment: .center)
            }
            .frame(width: 460, height: 330)
            .background(Color("lightGray"))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//
//  WishlistView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/8/23.
//

import SwiftUI

import BookApp

struct WhiteRoundedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("GochiHand-Regular", size: 15))
            .foregroundColor(.black)
            .frame(width: 100, height: 30)
            .background(Color(UIColor.white))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 1))
    }
}

struct WishlistView: View {
    
    @State private var showingBorrowSheet = false
    
    var body: some View {
       Text("hello")
        ZStack {
            VStack {
                Text("My Wishlist")
                    .font(.custom("GochiHand-Regular", size: 30))
                    .foregroundColor(.black)
                VStack {
                    LazyHStack(alignment: .center, spacing: 130) {
                        Text("Current Borrowing")
                            .font(.custom("GochiHand-Regular", size: 26))
                            .foregroundColor(.black)
                    }
                    .frame(width: 330, height: 40, alignment: .leading)
                    GeometryReader { geometry in
                        ScrollView(.horizontal) {
                            LazyHStack(alignment: .center, spacing: 20) {
                                ForEach(1..<3) { index in
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
                                        Button("Borrowing"){
                                            showingBorrowSheet.toggle()
                                        }
                                        .buttonStyle(RoundedButton())
                                        .sheet(isPresented: $showingBorrowSheet) {
                                            BorrowView()
                                        }
                                    }
                                    .frame(width: 150, height: 230, alignment: .center)
                                    .background(Color("lightGray"))
                                    .cornerRadius(25)
                                    .overlay(RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(Color.black, lineWidth: 3))
                                }
                            }
                            .frame(width: geometry.size.width, height: 230, alignment: .center)
                        }
                    }
                }
                .frame(width: 460, height: 310)
                .background(Color("Beige3"))
                VStack {
                    LazyHStack(alignment: .center, spacing: 130) {
                        Text("Considering")
                            .font(.custom("GochiHand-Regular", size: 26))
                            .foregroundColor(.black)
                        Button("Add Books")
                        {
                            showingBorrowSheet.toggle()
                        }
                        .buttonStyle(WhiteRoundedButton())
                        .sheet(isPresented: $showingBorrowSheet) {
                            BorrowView()
                        }
                    }
                    .frame(width: 330, height: 40, alignment: .leading)
                    ScrollView(.horizontal) {
                        LazyHStack(alignment: .center, spacing: 20) {
                            ForEach(3..<7) { index in
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
                                    if index % 2 == 0 {
                                        Button("Available"){
                                            showingBorrowSheet.toggle()
                                        }
                                        .buttonStyle(RoundedButton())
                                        .sheet(isPresented: $showingBorrowSheet) {
                                            BorrowView()
                                        }
                                    } else {
                                        Button("Unavailable"){
                                            showingBorrowSheet.toggle()
                                        }
                                        .buttonStyle(RoundedButton())
                                        .sheet(isPresented: $showingBorrowSheet) {
                                            BorrowView()
                                        }
                                    }
                                }
                                .frame(width: 150, height: 230, alignment: .center)
                                .background(Color("lightGray"))
                                .cornerRadius(25)
                                .overlay(RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.black, lineWidth: 3))
                            }
                        }
                        .frame(width: .infinity, height: 230, alignment: .center)
                    }
                }
                .frame(width: 460, height: 330)
                .background(Color("Beige3"))
            }
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}

//
//  ProfileView.swift
//  BookApp
//
//  Created by Saloni Vaishnav on 11/8/23.
//

import SwiftUI

//struct BorrowView: View {
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        BorrowConfirmationView()
//    }
//}

struct RoundedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Futura", size: 15))
            .foregroundColor(.white)
            .frame(width: 100, height: 30)
            .background(Color("magenta"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 1))
    }
}


struct ProfileView: View {
    
    
    @Binding var user: Person
    @Binding var booksFromJson: [Book2]
    var editable: Bool

    
    @State private var showingBorrowSheet = false
    @State private var titleToOpen: String = "none"
    
    @State private var books =
        [Book(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "Title2", coverImage: "cover", author: "Author", tags: ["tag1"], description: "description", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "Title3", coverImage: "cover", author: "Author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false),
         Book(title: "Title4", coverImage: "cover", author: "Author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false)]
    
    
    @State private var users = Person.allPersons

    @State private var currentBook: Book2 = Book2(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false, someoneInterested: false)

    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
        VStack {
                            
            VStack {
                AsyncImage(url: URL(string: user.profilePicture)) { phase in
                    switch phase {
                        case .empty:
                            ProgressView() // Shown while loading
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Image(systemName: "photo") // Shown on failure
                        @unknown default:
                            EmptyView()
                    }
                }
                .frame(width: 180, height: 180, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("magenta"), lineWidth: 10))
                .padding()
            
                Text(user.name + " " + user.lastname)
                    .font(.custom("Futura", size: 30))
                    .foregroundColor(.black)
                    .frame(width: 400, height: 30, alignment: .center)
                Text(user.bio)
                    .font(.custom("Futura", size: 18))
                    .frame(width: 310, height: 100, alignment: .leading)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)


            }
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(user.bookListings, id: \.self) { book in
                            if let i = booksFromJson.firstIndex(where: { $0.title == book }) {
                                VStack() {
                                    Button(action: {booksFromJson[i].lendedByMe=false}) {
                                        Image("Exit")
                                            .frame(width: 120, height: 1, alignment: .trailing)
                                    }
                                    Text(booksFromJson[i].title)
                                        .font(.custom("Futura", size: 18))
                                        .frame(width: 120, height: 20, alignment: .leading)
                                    
                                    Text(booksFromJson[i].author)
                                        .font(.custom("Futura", size: 13))
                                        .frame(width: 120, height: 10, alignment: .leading)
                                    
                                    AsyncImage(url: URL(string: booksFromJson[i].coverImage)) { phase in
                                        switch phase {
                                            case .empty:
                                                ProgressView() // Shown while the image is loading
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            case .failure:
                                                Image(systemName: "photo") // Fallback image or icon in case of failure
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            @unknown default:
                                                EmptyView()
                                        }
                                    }
                                    .frame(width: 85, height: 110, alignment: .center)
                                    .clipped()
                                    Button(booksFromJson[i].availability ? "Available" : "Borrowed") {
                                        if booksFromJson[i].someoneInterested {
                                            showingBorrowSheet.toggle()
                                            titleToOpen = booksFromJson[i].title
                                        }
                                    }
                                    .buttonStyle(RoundedButton())
                                    .sheet(isPresented: $showingBorrowSheet) {
                                        AcceptConfirmationView(booksFromJson: $booksFromJson, bookTitle: titleToOpen, borrower: $users[Int.random(in: 0..<19)], showingBorrowSheet: $showingBorrowSheet)
                                     }
                                }
                                .frame(width: 150, height: 240, alignment: .center)
                                .background(Color("cream"))
                                .cornerRadius(25)
                                .overlay(RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.black, lineWidth: booksFromJson[i].someoneInterested ? 6 : 3))
                            }
                        }
                    }
                }
                .frame(width: .infinity, height: 240, alignment: .center)

            }
            .frame(width: 460, height: 310)
            .background(Color("yellow"))
        }
        }
    }
}
//
//    struct ProfileView_Previews: PreviewProvider {
//        static var previews: some View {
//            ProfileView()
//        }
//    }
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a constant binding to an array of 'Book2' which contains the example book
//        let exampleBooks = [Book2(title: "Sample Book", coverImage: "SampleCover", author: "Sample Author", tags: ["Fiction", "Adventure"], description: "This is a sample book description.", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false)]
//        
//        ProfileView(booksFromJson: .constant(exampleBooks))
//    }
//}

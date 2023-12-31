//
//  MainView2.swift
//  BookApp
//
//  Created by Aditi Shah on 11/13/23.
//
import SwiftUI
import Foundation

struct FlipButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
//          .background(Color("Beige4"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 1))
    }
}


struct Book: Codable, Identifiable {
    var id: String{title}
    var title: String
    var coverImage: String?
    var author: String
    var tags: [String]
    var description: String
    var availability: Bool
    var borrowedByMe: Bool
    var lendedByMe: Bool
    var wishlistedByMe: Bool

    enum CodingKeys: String, CodingKey {
        case title, author, tags, description, availability, borrowedByMe, lendedByMe, wishlistedByMe
        case coverImage = "cover_image"
    }
}

struct User: Codable, Identifiable {
    var id: String{name + lastname}
    var name: String
    var lastname: String
    var bio: String
    var favoriteGenre: String
    var profilePicture: String?

    enum CodingKeys: String, CodingKey {
        case name, lastname, bio, favoriteGenre
        case profilePicture = "profile_picture"
    }
}





struct BookIconView: View {
    @State var isFlipped: Bool
    @Binding var book: Book2
    var body: some View {
        HStack {
            ZStack {
                if book.availability {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 25, height: 25)
                        .position(x: 35, y: 45)
                        .zIndex(10)

                    
//                    Text("Available to Borrow")
//                        .frame(width: 50, height: 50)
//                        .font(.custom("Futura", size: 12))
//                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green))
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
//                        .zIndex(10)
//                        .position(x: 30, y: 30)
                }
//                else {
//                    Text("Not Available to Borrow")
//                        .font(.custom("Futura", size: 12))
//                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.red))
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0.5))
//                        .zIndex(10)
//                        .position(x: 30, y: 30)
//
//                }
                
                Button(action: {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }) {
                    if isFlipped {
                        // The back of the card
                        ZStack(alignment: .topTrailing) {
                            Image("FlipIcon").resizable().frame(width: 50, height: 50)
                            BackView(book: $book)
                        }.frame(width: 310, height: 470)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("magenta"), lineWidth: 10))
                            .rotation3DEffect(.degrees(isFlipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                        
                        
                    } else {
                        // The front of the card
                        ZStack(alignment: .topTrailing) {
                            AsyncImage(url: URL(string: book.coverImage)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            Image("FlipIcon").resizable().frame(width: 50, height: 50)
                        }
                        .frame(width: 310, height: 470)
                        .background()
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 2))
                        .rotation3DEffect(.degrees(isFlipped ? -180 : 0), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .buttonStyle(FlipButton())
            }
            
        }
    }
}


struct ListedByView: View {
    @Binding var lender: Person
    @Binding var booksFromJson: [Book2]
    @State private var showingProfileSheet = false
    @State var available: Bool
    
    
    var body: some View {
        HStack {
            HStack {
                VStack {
                    Text("Listed By:")
                        .font(.custom("Futura", size: 20))
                    Text(lender.name + " " + lender.lastname)
                        .font(.custom("Futura", size: 25))
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            AsyncImage(url: URL(string: lender.profilePicture)) { phase in
                switch phase {
                    case .empty:
                        ProgressView() // Shown while loading
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image("ProfileIcon") // Fallback image in case of failure
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    @unknown default:
                        EmptyView()
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding(.leading)
            .padding(.vertical)
            .onTapGesture {
                showingProfileSheet.toggle()

            }
            .sheet(isPresented: $showingProfileSheet) {
                ProfileView(user: $lender, booksFromJson: $booksFromJson, editable: false)
            }
        }
    }
}


struct BorrowedByView: View {
    @Binding var borrowers: [Person]
    @State private var showingProfileSheet = false

    
    var body: some View {
        HStack {
            VStack {
                Text("Also Borrowed By:")
                    .font(.custom("Futura", size: 20))
                    .frame(width: 300, height: 20, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -10) {
                        ForEach([borrowers.randomElement()!, borrowers.randomElement()!, borrowers.randomElement()!, borrowers.randomElement()!, borrowers.randomElement()!]) { user in
                            AsyncImage(url: URL(string: user.profilePicture)) { phase in
                                switch phase {
                                    case .empty:
                                        ProgressView() // Shown while loading
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    case .failure:
                                        Image("ProfileIcon") // Fallback image in case of failure
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    @unknown default:
                                        EmptyView()
                                }
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .onTapGesture {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    
                }
            }
        }
    }
}


struct BackView: View {
    @Binding var book: Book2
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text(book.title)
                .font(.custom("Futura", size: 30))
                .padding([.top, .horizontal])
            Text(book.author)
                .font(.custom("Futura", size: 25))
                .padding([.horizontal])
            Text(book.description)
                .font(.custom("Futura", size: 14))
                .padding()
            
            VStack (alignment: .center){
                HStack (alignment: .center) {
                    TagView(tag: "Fantasy")
                    TagView(tag: "Fiction")
                    TagView(tag: "Set in London")
                }
                HStack (alignment: .center) {
                    TagView(tag: "Plot Twist")
                    TagView(tag: "WOW")
                    TagView(tag: "Powerful")
                }
                HStack (alignment: .center) {
                    TagView(tag: "Ambitious Main Character")
                    TagView(tag: "Short Book")
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical)
            .padding(.vertical)
        }
    }
}


struct TagView: View {
    var tag: String

    var body: some View {
        Text(tag)
            .padding(.horizontal, 10) // Add horizontal padding inside the tag
            .padding(.vertical, 10) // Add vertical padding to make the tag taller
            .background(Color("yellow").opacity(0.6))
            .clipShape(Capsule())
            .font(.caption) // You can adjust the font size as needed
    }
}


struct CardView: View {
    @State private var offset = CGSize.zero
    @State private var isFlipped = false
    @State private var swipeStatus = 0
    @State private var color = Color("cream")
    
    @Binding var booksFromJson: [Book2]
    @Binding var book: Book2
    @Binding var lender: Person
    @Binding var borrowers: [Person]
    @Binding var cardIndex: Int
    
    @State private var sideModal: SideModal? = nil

    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
        //Color("lightGray").ignoresSafeArea()
            if swipeStatus == 0 {
                VStack {
                    BookIconView(isFlipped: isFlipped, book: $book)
                    ListedByView(lender: $lender, booksFromJson: $booksFromJson, available: book.availability)
                    BorrowedByView(borrowers: $borrowers)
                }
            }
            else if swipeStatus == 1 {
                ZStack {
                    StarsBlinkView()
                    VStack {
                        BookIconView(isFlipped: isFlipped, book: $book)
                        ListedByView(lender: $lender, booksFromJson: $booksFromJson, available: book.availability)
                        BorrowedByView(borrowers: $borrowers)
                    }
                }
                
            }
            if cardIndex > 0 {
                Button("Undo") {
                    cardIndex = cardIndex - 1
                    booksFromJson[cardIndex].wishlistedByMe = false
                }.buttonStyle(RoundedButton())
            }
        }
        .padding()
        .background(color).padding()
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20).stroke(color, lineWidth: 12).padding()
        )
        .offset(x: offset.width, y: offset.height*0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                withAnimation {
                    sparkle(width: offset.width)
                }
            }.onEnded { _ in
                withAnimation {
                    swipeCard(width: offset.width)
                    sparkle(width: offset.width)
                }
            }
        )
        .modalView(sideModal: $sideModal)
    }
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            cardIndex = cardIndex + 1
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            cardIndex = cardIndex + 1
        default:
            offset = .zero
        }
    }
    
    func sparkle(width: CGFloat) {
        switch width {
        case -500...(-200): // swipe left
            color = .red
        case 100...500: // swipe right
            swipeStatus = 1
            if (book.availability) {
                sideModal = SideModal(title: "Available to Borrow", message: book.title + " is currently available to borrow! Check your wishlist to proceed", color: "yellow")
            }
            book.wishlistedByMe = true
        default:
            color = Color("cream")
            swipeStatus = 0
        }
    }
}


struct MainView2: View {
    @Binding var booksFromJson: [Book2]
    @State private var users = Person.allPersons
    
    let spacing: CGFloat = 10
    @State var cardIndex = 0
    var body: some View {
        VStack {
            ZStack {
                //ForEach(booksFromJson.indices, id: \.self) { i in
                CardView(booksFromJson: $booksFromJson, book: $booksFromJson[cardIndex+1], lender: $users[cardIndex+1], borrowers: $users, cardIndex: $cardIndex).id(UUID())
                CardView(booksFromJson: $booksFromJson, book: $booksFromJson[cardIndex], lender: $users[cardIndex], borrowers: $users, cardIndex: $cardIndex).id(UUID())
                //}
            }
        }
    }
}

struct PreviewView: View {
    @State private var booksFromJson = Book2.allBooks
    var body: some View {
        MainView2(booksFromJson: $booksFromJson)
    }
}

struct MainView2_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
//struct MainView2_Previews: PreviewProvider {
//    static var previews: some View {
//        // Create a constant binding to an array of 'Book2' which contains the example book
//        let exampleBooks = [Book2(title: "Sample Book", coverImage: "SampleCover", author: "Sample Author", tags: ["Fiction", "Adventure"], description: "This is a sample book description.", availability: true, borrowedByMe: false, lendedByMe: false, wishlistedByMe: false)]
//
//        MainView2(booksFromJson: .constant(exampleBooks))
//    }
//}

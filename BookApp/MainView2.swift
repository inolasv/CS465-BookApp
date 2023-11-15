//
//  MainView2.swift
//  BookApp
//
//  Created by Aditi Shah on 11/13/23.
//
import SwiftUI

struct FlipButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
//            .background(Color("Beige4"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 1))
    }
}
struct MainView2: View {
    @State private var isFlipped = false
    @State private var sideModal: SideModal? = nil

    var body: some View {
        ZStack {
            Color("lightGray").ignoresSafeArea()
                .zIndex(0)
            
            Button("hello"){
                print("opening")
                sideModal = SideModal(title: "Available to Borrow", message: "The book is currently available to borrow! Check your wishlist to proceed")
            }
            .modalView(sideModal: $sideModal)
            .zIndex(99)
            
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
//                                .background(Color("Beige1"))
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

    enum CodingKeys: String, CodingKey {
        case title, author, tags, description, availability, borrowedByMe, lendedByMe
        case coverImage = "cover_image"
    }
}


struct BookIconView: View {
    @State var isFlipped: Bool
    let book: Book
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    isFlipped.toggle()
                }
            }) {
                if isFlipped {
                    // The back of the card
                    BackView(book: book)
                        .frame(width: 340, height: 550)
                    //                                .background(Color("Beige1"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 2))
                        .rotation3DEffect(.degrees(isFlipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                } else {
                    // The front of the card
                    Image(book.coverImage!)
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
<<<<<<< HEAD

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
                            
=======
            }
            .buttonStyle(FlipButton())
        }
    }
}


struct ListedByView: View {
    var body: some View {
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
    }
}


struct BorrowedByView: View {
    var body: some View {
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
>>>>>>> 90b7d2faad0854a6bec72a5b8d3a16cc97aa3917
                        }
                    }
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    
                }
                
            }
            .zIndex(1)
            

        }
    }
}


struct BackView: View {
    let book: Book
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text(book.title)
                .font(.custom("GochiHand-Regular", size: 40))
                .padding([.top, .horizontal])
            Text(book.author)
                .font(.custom("GochiHand-Regular", size: 25))
                .padding([.horizontal])
            Text(book.description)
                .font(.custom("GochiHand-Regular", size: 16))
                .padding()
            
            VStack (alignment: .center){
                HStack {
                    TagView(tag: "Fantasy")
                    TagView(tag: "Historical Fiction")
                    TagView(tag: "Set in London")
                }
                HStack {
                    TagView(tag: "Plot Twist")
                    TagView(tag: "WOW")
                    TagView(tag: "Powerful")
                }
                HStack {
                    TagView(tag: "Ambitious Main Character")
                    TagView(tag: "Short Book")
                }
            }
        }

    }
}


struct TagView: View {
    var tag: String

    var body: some View {
        Text(tag)
            .padding(.horizontal, 10) // Add horizontal padding inside the tag
            .padding(.vertical, 10) // Add vertical padding to make the tag taller
            .background(Color.gray.opacity(0.2))
            .clipShape(Capsule())
            .font(.caption) // You can adjust the font size as needed
    }
}


struct CardView: View {
    @State private var offset = CGSize.zero
    @State private var isFlipped = false
    @State private var swipeStatus = 0
    @State private var color = Color("lightGray")
    let book: Book
    
    var body: some View {
        ZStack {
        //Color("lightGray").ignoresSafeArea()
            if swipeStatus == 0 {
                VStack {
                    BookIconView(isFlipped: isFlipped, book: book)
                    ListedByView()
                    BorrowedByView()
                }
            }
            else if swipeStatus == 1 {
                ZStack {
                    StarsBlinkView()
                    VStack {
                        BookIconView(isFlipped: isFlipped, book: book)
                        ListedByView()
                        BorrowedByView()
                    }
                }
                
            }
            
//            List(books, id: \.title) { book in
//                VStack(alignment: .leading) {
//                    Text(book.title).font(.headline)
//                    Text(book.author).font(.subheadline)
//                    // Display other properties as needed
//                }
//            }
//            .onAppear {
//                loadBooks()
//            }
        }
        .padding()
        .background(color).padding()
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 5).padding()
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
    }
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    func sparkle(width: CGFloat) {
        switch width {
        case -500...(-200): //swipe left
            color = .red
        case 100...500: //swipe right
            swipeStatus = 1
        default:
            color = Color("lightGray")
            swipeStatus = 0
        }
    }
}


struct MainView2: View {
    //@State private var offset: CGFloat = 0
    //@State private var index = 0
    
    @State private var books =
        [Book(title: "title1", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false),
         Book(title: "title2", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false),
         Book(title: "title3", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false),
         Book(title: "title4", coverImage: "cover", author: "author", tags: ["tag1"], description: "description", availability: false, borrowedByMe: false, lendedByMe: false)]
    let spacing: CGFloat = 10

    var body: some View {
        VStack {
            ZStack {
                ForEach(self.books) {
                    book in CardView(book: book)
                }
            }
        }
//        GeometryReader { geometry in
//            return ScrollView(.horizontal, showsIndicators: true) {
//                HStack(spacing: self.spacing) {
//                    ForEach(self.books) { book in
//                        CardView(book: book)
//                            .frame(width: geometry.size.width)
//                    }
//                }
//            }
//            .content.offset(x: self.offset)
//            .frame(width: geometry.size.width, alignment: .leading)
//            .gesture(
//                DragGesture()
//                    .onChanged({ value in
//                        self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
//                    })
//                    .onEnded({ value in
//                        if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.books.count - 1 {
//                            self.index += 1
//                        }
//                        if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
//                            self.index -= 1
//                        }
//                        withAnimation { self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index) }
//                    })
//            )
//        }
    }
    
    func loadBooks() {
        // Load the JSON file from the bundle
        guard let url = Bundle.main.url(forResource: "books", withExtension: "json", subdirectory: "Data") else {
            print("JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            books = try JSONDecoder().decode([Book].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}


struct MainView2_Previews: PreviewProvider {
    static var previews: some View {
        MainView2()
    }
}



//                HStack {
//                    Button(action: {
//                        withAnimation {
//                            isFlipped.toggle()
//                        }
//                    }) {
//                        if isFlipped {
//                            // The back of the card
//                            BackView(book: book)
//                                .frame(width: 340, height: 550)
//                                .background(Color("Beige1"))
//                                .cornerRadius(20)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .stroke(.black, lineWidth: 2))
//                                .rotation3DEffect(.degrees(isFlipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
//                        } else {
//                            // The front of the card
//                            Image(book.coverImage!)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 340, height: 550)
//                                .background(Color("Beige3"))
//                                .cornerRadius(20)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .stroke(.black, lineWidth: 2))
//                                .rotation3DEffect(.degrees(isFlipped ? -180 : 0), axis: (x: 0, y: 1, z: 0))
//                        }
//                    }
//                    .buttonStyle(FlipButton())
//                }
//                HStack {
//                    VStack {
//                        Text("Listed By:")
//                            .font(.custom("GochiHand-Regular", size: 25))
//                            .frame(width: 220, height: 20, alignment: .leading)
//                        Text("FirstName LastName")
//                            .font(.custom("GochiHand-Regular", size: 25))
//                            .frame(width: 220, height: 20, alignment: .leading)
//                    }
//                    Image(systemName: "person.crop.circle.fill")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .clipShape(Circle())
//                        .padding(.leading)
//
//                        .padding(.vertical)
//                }
//                HStack {
//                    VStack {
//                        Text("Also Borrowed By:")
//                            .font(.custom("GochiHand-Regular", size: 25))
//                            .frame(width: 290, height: 20, alignment: .leading)
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(0..<5, id: \.self) { _ in
//                                    Image(systemName: "person.crop.circle.fill")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 40, height: 40)
//                                        .clipShape(Circle())
//                                }
//                            }
//                            .padding(.horizontal)
//                            .padding(.horizontal)
//                            .padding(.horizontal)
//
//                        }
//                    }
//                }

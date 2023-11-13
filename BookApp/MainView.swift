import SwiftUI

// Define your custom colors in the asset catalog
// Example: Color("Beige4"), Color("lightGray")

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("GochiHand-Regular", size: 20))
            .foregroundColor(.black)
            .frame(width: 120, height: 40)
//            .background(Color("Beige4"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 1))
    }
}

struct MainView: View {
    // Use @State to manage view state changes
    @State private var showingDetail = false

    var body: some View {
        ZStack {
            Color("lightGray").ignoresSafeArea()
            VStack {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1659824718i/61180151.jpg")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 155, height: 230)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    HStack (spacing: 20){
                        //                    GeometryReader { geometry in
                        VStack (spacing: 10){
                            // Profile Image
                            Image(systemName: "person.crop.circle.fill") // Replace with your image name
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80,  height: 80)
                                .clipShape(Circle())
                            // Name and Description
                            Text("Name")
                                .font(.custom("GochiHand-Regular", size: 30))
                                .foregroundColor(.black)
                        }
                        Text("Tags ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                            .font(.custom("GochiHand-Regular", size: 17))
                            .frame(width: 200, alignment: .leading)
                            .foregroundColor(.black)
                    }
                    // Description
                    Text("Description ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                        .font(.custom("GochiHand-Regular", size: 17))
                        .frame(width: 300, alignment: .leading)
                        .foregroundColor(.black)
                    // Action Buttons
                    HStack {
                        Button("Accept") {
                            // Handle accept action
                        }
                        .buttonStyle(CustomButtonStyle())
                        Button("Decline") {
                            // Handle decline action
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                }
            }
//             Additional content can be added here
            .frame(width: 320) // Set the desired width for the VStack here
            .padding() // This adds padding inside the VStack, creating a margin from the edges of the screen
            .background(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 1)) // This creates the outline with rounded corners
            .padding() // This adds padding outside the background, so it doesn't touch the edges of the screen
        }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

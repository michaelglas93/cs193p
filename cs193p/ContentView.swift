import SwiftUI

struct ContentView: View {
    @State private var emojis: [String] = []
    
    let halloweenEmojis = ["👻", "👻", "🎃", "🎃", "🕷️", "🕷️", "😈", "😈", "💀", "💀"]
    let animalEmojis = ["🐉", "🐉", "🐇", "🐇", "🐆", "🐆", "🐰", "🐰", "🦊", "🦊", "🐸", "🐸"]
    let natureEmojis = ["🐻", "🐻", "🐻‍❄️", "🐻‍❄️", "🌲", "🌲", "🍂", "🍂", "🏝️", "🏝️", "🌻", "🌻", "⛰️", "⛰️"]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .padding(.top)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(emojis.indices, id: \.self) { index in
                        CardView(content: emojis[index])
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.orange)
                .padding()
            }
            
            Spacer()
            
            HStack {
                themeButton(title: "Halloween", symbol: "moon.fill", theme: halloweenEmojis)
                themeButton(title: "Animals", symbol: "pawprint.fill", theme: animalEmojis)
                themeButton(title: "Nature", symbol: "leaf.fill", theme: natureEmojis)
            }
            .padding(.bottom)
        }
    }
    
    func themeButton(title: String, symbol: String, theme: [String]) -> some View {
        Button(action: {
            emojis = theme.shuffled()
        }) {
            VStack {
                Image(systemName: symbol)
                    .font(.largeTitle)
                Text(title)
                    .font(.caption)
            }
        }
        .buttonStyle(.bordered)
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State private var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}

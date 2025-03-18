//
//  ContentView.swift
//  cs193p
//
//  Created by Glas, Michael on 11.03.25.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈","🐉","🐇","🐆","🐰"];
    //let emojis: [String] = ["👻", "🎃", "🕷️", "😈"]; means the same

    @State var cardCount: Int = 4
    var body: some View {
        ScrollView{
            cards
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cardCountAdjusters: some View {
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(
            action: {
                    cardCount += offset
            
            },
            label: {
                Image(systemName: symbol)
            
            })
        .disabled(cardCount + offset < 0 || cardCount + offset > emojis.count)
        
    }
    
    var cardRemover: some View{
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View{
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
}




struct CardView: View {
    var content: String;
    @State var isFaceUp = true;
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)

            
        }.onTapGesture {
            //isFaceUp = !isFaceUp - it is the same
            isFaceUp.toggle()
        }
    }
}






#Preview {
    ContentView()
}

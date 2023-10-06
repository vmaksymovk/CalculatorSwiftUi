//
//  ContentView.swift
//  Calculator
//
//  Created by Влад on 10/6/23.
//

import SwiftUI

enum CalcButton : String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
}

struct ContentView: View {
    
    let buttons : [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
        
    ]
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                //Text display
                HStack {
                    Spacer()
                    Text("0")
                        .bold()
                        .font(.system(size: 62))
                        .foregroundColor(.white)
                    
                }.padding()
                
                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12){
                        ForEach(row, id: \.self) {item in
                            Button(action: {}, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .background(Color.orange)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                                    .foregroundColor(.white)
                            })
                        }
                    }.padding(.bottom, 3)
                    
                }
                
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

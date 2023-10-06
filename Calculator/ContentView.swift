import SwiftUI

enum CalcButton: String {
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
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, percent, none
}

struct ContentView: View {
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Text display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }) {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal, .percent:
            if button == .equal {
                let currentValue = Double(self.value) ?? 0.0
                let runningValue = self.runningNumber
                switch self.currentOperation {
                case .add:
                    self.value = "\(currentValue + runningValue)"
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                case .percent:
                    self.value = "\((currentValue / 100) * runningValue)"
                case .multiply:
                    self.value = "\(currentValue * runningValue)"
                case .divide:
                    if runningValue != 0.0 {
                        self.value = "\(runningValue / currentValue)"
                    } else {
                        // Handle division by zero error
                        self.value = "Error"
                    }
                case .none:
                    break
                }
            } else {
                if button == .add {
                    self.currentOperation = .add
                } else if button == .subtract {
                    self.currentOperation = .subtract
                } else if button == .multiply {
                    self.currentOperation = .multiply
                } else if button == .divide {
                    self.currentOperation = .divide
                } else if button == .percent {
                    self.currentOperation = .percent
                
                }
                self.runningNumber = Double(self.value) ?? 0.0
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            self.runningNumber = 0
            self.currentOperation = .none
        case .decimal:
                if !self.value.contains(".") {
                    self.value += "."
                }
//            case .percent:
//                let currentValue = Double(self.value) ?? 0
//                self.value = "\(currentValue / 100)"
            case .negative:
                let currentValue = Double(self.value) ?? 0
                self.value = "\(-currentValue)"
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
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

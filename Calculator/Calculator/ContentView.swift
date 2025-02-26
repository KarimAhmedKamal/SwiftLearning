//
//  ContentView.swift
//  Calculator
//
//  Created by Mac on 26/12/2024.
//

import SwiftUI

enum CalcBtn: String {
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
    case multiply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negativePositive = "+/-"
    
    var buttonColor : Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negativePositive, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

enum DivisionError: Error {
    case dividedByZero
}

struct ContentView: View {
    
    @State var value = "0"
    @State var displayValue = "0"
    @State var currentOperation : Operation = .none
    @State var runningNumber : Float = 0.0
    @State var isFirstOperation = true
    @State var valueUpdatedByUser = false
    
    let buttons: [[CalcBtn]] = [
        [.clear, .negativePositive, .percent, .divide],
        [.seven, .eight, .nine,  .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(self.displayValue)
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button(
                                action: {
                                    self.didTap(item: item)
                                },
                                label: {
                                    Text(item.rawValue)
                                        .frame(
                                            width: self.buttonWidth(item: item),
                                            height: self.buttonHeight()
                                        )
                                        .font(.system(size: 40))
                                        .foregroundColor(.white)
                                        .background(item.buttonColor)
                                        .cornerRadius(self.buttonWidth(item: item) / 2)
                                }
                            )
                        }
                    }
                    .padding(.bottom, 3 )
                    
                }
                
            }
        }
    }
    
    func didTap(item: CalcBtn) {
        switch item {
        case .add:
            if self.isFirstOperation {
                self.isFirstOperation = false
                self.runningNumber = Float(self.value) ?? 0
                self.value = "0"
                self.valueUpdatedByUser = false
                self.displayValue = "0"
            }
            else {
                self.equalOperation()
                //                self.runningNumber += Float(self.value) ?? 0
                //                self.value = "0"
                //                self.displayValue = "\(self.runningNumber)"
            }
            self.currentOperation = .add
            
            //            self.equalOperation()
            //            self.currentOperation = .add
            //            self.equalOperation()
            //            self.value = "0"
            
            //            self.runningNumber = Float(self.value) ?? 0
        case  .subtract:
            if self.isFirstOperation {
                self.isFirstOperation = false
                self.runningNumber = Float(self.value) ?? 0
                self.value = "0"
                self.valueUpdatedByUser = false
                self.displayValue = "0"
            }
            else {
                self.equalOperation()
                //                self.runningNumber -= Float(self.value) ?? 0
                //                self.value = "0"
                //                self.displayValue = "\(self.runningNumber)"
            }
            self.currentOperation = .subtract
            
            //            self.equalOperation()
            //            self.currentOperation = .subtract
            //            self.equalOperation()
            //            self.value = "0"
            //            self.currentOperation = .subtract
            //            self.runningNumber = Float(self.value) ?? 0
            //            self.value = "0"
            //            break
        case .divide:
            if self.isFirstOperation {
                self.isFirstOperation = false
                self.runningNumber = Float(self.value) ?? 0
                self.value = "0"
                self.valueUpdatedByUser = false
                self.displayValue = "0"
            }
            else {
                self.equalOperation()
                //                self.runningNumber /= Float(self.value) ?? 0
                //                self.value = "0"
                //                self.displayValue = "\(self.runningNumber)"
            }
            self.currentOperation = .divide
            
            //            self.equalOperation()
            //            self.currentOperation = .divide
            //            self.equalOperation()
            //            self.value = "0"
            
            //            self.currentOperation = .divide
            //            self.runningNumber = Float(self.value) ?? 0
            //            self.value = "0"
            //            break
        case .multiply:
            if self.isFirstOperation {
                self.isFirstOperation = false
                self.runningNumber = Float(self.value) ?? 0
                self.value = "0"
                self.valueUpdatedByUser = false
                self.displayValue = "0"
            }
            else {
                self.equalOperation()
            }
            self.currentOperation = .multiply
            
            //            self.equalOperation()
            //            self.currentOperation = .multiply
            //            self.equalOperation()
            //            self.value = "0"
            
            //            self.currentOperation = .multiply
            //            self.runningNumber = Float(self.value) ?? 0
            //            self.value = "0"
            //            break
        case .equal:
            self.equalOperation()
            
            //            self.isFirstOperation = true
            //            value = "0"
            ////            runningNumber = 0
            //            self.currentOperation = .none
            //            self.displayValue = "\(self.runningNumber)"
        case .clear:
            self.value = "0"
            self.valueUpdatedByUser = false
            self.displayValue = "0"
            self.runningNumber = 0
            self.currentOperation = .none
            self.isFirstOperation = true
            break
        case .decimal, .negativePositive, .percent:
            break
        default:
            let number = item.rawValue
            if self.value == "0" {
                self.value = number
                self.displayValue = number
            }
            else {
                self.value = "\(self.value)\(number)"
                self.displayValue = "\(self.displayValue)\(number)"
            }
            self.valueUpdatedByUser = true
            //            if self.currentOperation == .none {
            //                self.runningNumber = 0
            //            }
        }
    }
    
    func addTwoValues() {
        //        print("hiii")
        self.runningNumber += Float(self.value) ?? 0
        self.value = "0"
        self.valueUpdatedByUser = false
        self.displayValue = "\(self.runningNumber)"
        self.currentOperation = .none
        //        self.isFirstOperation = true
        
        //        self.isFirstOperation = false
        //        let currentValue = Float(self.value) ?? 0
        //        if self.isFirstOperation {
        //            self.runningNumber = currentValue
        //            isFirstOperation = false
        //        }
        //        else {
        //            self.runningNumber += currentValue
        //        }
        ////        self.runningNumber += currentValue
        //        //        self.value = "\(self.runningNumber)"
        //        self.displayValue = "\(self.runningNumber)"
        //        self.value = "0"
    }
    
    func subtractTwoValues() {
        self.runningNumber -= Float(self.value) ?? 0
        self.value = "0"
        self.valueUpdatedByUser = false
        self.displayValue = "\(self.runningNumber)"
        self.currentOperation = .none
        
        //        let currentValue = Float(self.value) ?? 0
        //        if self.isFirstOperation {
        //            self.runningNumber = currentValue
        //            isFirstOperation = false
        //        }
        //        else {
        //            self.runningNumber -= currentValue
        //        }
        //        //        self.value = "\(self.runningNumber)"
        //        self.displayValue = "\(self.runningNumber)"
        //        self.value = "0"
    }
    
    func multiplyTwoValues() {
        if (valueUpdatedByUser) {
            self.runningNumber *= Float(self.value) ?? 0
            self.value = "0"
            self.valueUpdatedByUser = false
            self.displayValue = "\(self.runningNumber)"
            self.currentOperation = .none
        }
        
        //        let currentValue = Float(self.value) ?? 0
        //        if self.isFirstOperation {
        //            self.runningNumber = currentValue
        //            isFirstOperation = false
        //        }
        //        else {
        //            self.runningNumber *= currentValue
        //        }
        //        //        self.value = "\(self.runningNumber)"
        //        self.displayValue = "\(self.runningNumber)"
        //        self.value = "0"
    }
    
    func divideTwoValues() throws{
        if self.value == "0" {
            throw DivisionError.dividedByZero
        }
        else {
            self.runningNumber /= Float(self.value) ?? 0
            self.value = "0"
            self.valueUpdatedByUser = false
            self.displayValue = "\(self.runningNumber)"
            self.currentOperation = .none
        }
        
        //        let currentValue = Float(self.value) ?? 0
        //        if currentValue == 0 {
        //            throw DivisionError.dividedByZero
        //        }
        //        self.runningNumber /= currentValue
        //        //        self.value = "\(self.runningNumber)"
        //        self.displayValue = "\(self.runningNumber)"
        //        self.value = "0"
        
        //        let currentValue = Float(self.value) ?? 0
        //        if currentValue == 0 {
        //            throw DivisionError.dividedByZero
        //        }
        //        self.runningNumber /= currentValue
        //        self.value = "\(self.runningNumber)"
    }
    
    func equalOperation() {
        //let runningValue = self.runningNumber
        //let currentValue = Float(self.value) ?? 0
        switch self.currentOperation {
        case .add: self.addTwoValues()// self.value = "\(runningValue + currentValue)"
        case .subtract: self.subtractTwoValues()//self.value = "\(runningValue - currentValue)"
        case .divide:
            do {
                try self.divideTwoValues() //self.value = "\(runningValue / currentValue)"
            }
            catch  DivisionError.dividedByZero{
                print("cannot divide by zero")
            }
            catch {
                print("unexpected division error")
            }
        case .multiply: self.multiplyTwoValues() //self.value = "\(runningValue *  currentValue)"
        case .none:
            break
        }
    }
    
    func buttonWidth(item: CalcBtn) -> CGFloat {
        if item == .zero {
            return (UIScreen.main.bounds.width - (3*12)) / 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    // create throwing function using throws keyword
    func division(numerator: Int, denominator: Int) throws {
        
        // throw error if divide by 0
        if denominator == 0 {
            throw DivisionError.dividedByZero
        }
    }
}

#Preview {
    ContentView()
}

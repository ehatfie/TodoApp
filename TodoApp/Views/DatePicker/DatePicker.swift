//
//  DatePicker.swift
//  TodoApp
//
//  Created by Erik Hatfield on 12/1/20.
//

import SwiftUI

struct DatePicker1: View {
    @Binding var selectedDate: String
    @State var selectedIndex = 10
    var gridItemLayout = [GridItem(.flexible())]
    var dates: [Date]
    
    let newGesture = TapGesture().onEnded {
            print("Tap on VStack.")
        }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            ScrollViewReader { sp in
                LazyHGrid(rows: gridItemLayout, alignment: .center ,spacing: 20) {
                    ForEach(0 ..< dates.count) { i in
                        let date = dates[i]
                        let cell = DatePickerCell(date: date, index: i, isSelected: self.selectedIndex == i)
                        cell.onTapGesture{
                            print("did tap \(i)")
                            sp.scrollTo(i, anchor: .center)
                            selectedIndex = i
                            selectedDate = dates[i].getMonthAndDay() // this should be an actual mm/dd/yyyy date probably
                            print("dp selected date \(selectedDate)")
                        }
                    }
                }.onAppear(perform: {
                    sp.scrollTo(getTodayIndex(), anchor: .center)
                })
                
            }
        }.animation(.easeIn)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
        .padding()
        .border(Color.black, width: 1)
    }
    
    func getDates() -> [Date] {
        let today = Date()
        var returnDates: [Date] = [today]
        
        for i in 1 ... 10 {
            let offset: Double = 60 * 60 * 24 * Double(i)
            let timeInterval = today.timeIntervalSinceNow + offset
            let forwardDate = today.addingTimeInterval(timeInterval)
            let backwardDate = today.addingTimeInterval((timeInterval * -1))
            returnDates.append(forwardDate)
            returnDates.insert(backwardDate, at: 0)
        }
        
        return returnDates
    }
    
    func getTodayIndex() -> Int {
        let todayDate = Date().getMonthAndDay()
        let index = self.dates.firstIndex(where: {$0.getMonthAndDay() == todayDate})
        
        self.selectedIndex = index ?? 10
        self.selectedDate = dates[self.selectedIndex].getMonthAndDay()
        return index ?? 10
    }
    
    private func getReadableDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "day"
        
        return dateFormatter.string(from: date)
    }
}

//struct DatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        DatePicker(dates: [Date()])
//    }
//}

extension Date {
    func getDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func getMonthAndDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: self)
    }
}

//extension Array where Element: Date {
//    
//}


struct DatePickerCell: View {
    var date: Date
    var index: Int
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Text(date.getDayOfWeek())
            Text(date.getMonthAndDay())
        }
        .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
        .border(isSelected ? Color.red : Color.black, width: 1)
        .id(index)
    }
}
//Image(systemName: symbols[$0 % symbols.count])
//.font(.system(size: 30))
//.frame(width: 50, height: 50)
//.background(colors[$0 % colors.count])
//.cornerRadius(10)

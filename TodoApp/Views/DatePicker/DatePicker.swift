//
//  DatePicker.swift
//  TodoApp
//
//  Created by Erik Hatfield on 12/1/20.
//

import SwiftUI

struct DatePicker: View {
    var gridItemLayout = [GridItem(.flexible())]
    var dates: [Date]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            ScrollViewReader { sp in
                
                LazyHGrid(rows: gridItemLayout, alignment: .center ,spacing: 20) {
                            ForEach(dates, id: \.self) { date in
                                //let ourDate = getReadableDate(from: date)
                                DatePickerCell(date: date)
                            }
                }.onAppear(perform: {
                    sp.scrollTo(dates[10])
                })
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
        .padding()
        .border(Color.black, width: 1)
    }
    
    func getDates() -> [Date] {
        let today = Date()
        var returnDates: [Date] = [today]
        
        for i in 0 ... 10 {
            let offset: Double = 60 * 60 * 24 * Double(i)
            let timeInterval = today.timeIntervalSinceNow + offset
            let forwardDate = today.addingTimeInterval(timeInterval)
            let backwardDate = today.addingTimeInterval((timeInterval * -1))
            returnDates.append(forwardDate)
            returnDates.insert(backwardDate, at: 0)
        }
        
        return returnDates
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


struct DatePickerCell: View {
    var date: Date
    
    var body: some View {
        VStack {
            Text(date.getDayOfWeek())
            Text(date.getMonthAndDay())
        }
        .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
        .border(Color.black, width: 1)
       
            //.frame(width: 25, height: 25, alignment: .center)
            
    }
}
//Image(systemName: symbols[$0 % symbols.count])
//.font(.system(size: 30))
//.frame(width: 50, height: 50)
//.background(colors[$0 % colors.count])
//.cornerRadius(10)

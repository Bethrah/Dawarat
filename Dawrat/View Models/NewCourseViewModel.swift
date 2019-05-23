/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

extension NewCourseViewController {
  
  class ViewModel {
    
    private let course : Course
    
    var title: String? {
      get {
        return course.title
      }
      set {
        course.title = newValue
      }
    }
   
    var StartDate: Date {
      get {
        return course.StartDate
      }
      set {
       course.StartDate = newValue
      }
    }
    
//    let reminderOptions: [String] = [ToDo.Reminder.none.rawValue,
//                                     ToDo.Reminder.halfHour.rawValue,
//                                     ToDo.Reminder.oneHour.rawValue,
//                                     ToDo.Reminder.oneDay.rawValue,
//                                     ToDo.Reminder.oneWeek.rawValue]
//    var reminder: String? {
//      get {
//        return toDo.reminder.rawValue
//      }
//      set {
//        if let value = newValue {
//          toDo.reminder = ToDo.Reminder(rawValue: value)!
//        }
//      }
//    }
 
    var image: UIImage? {
      get {
        if let data = course.image {
          return UIImage(data: data)
        }
        return nil
      }
      set {
        if let img = newValue {
          course.image = UIImagePNGRepresentation(img)
        } else {
          course.image = nil
        }
      }
    }
    
//    let priorityOptions: [String] = [ToDo.Priority.low.rawValue,
//                                     ToDo.Priority.medium.rawValue,
//                                     ToDo.Priority.high.rawValue]
//
//    var priority: String {
//      get {
//        return toDo.priority.rawValue
//      }
//      set {
//        toDo.priority = ToDo.Priority(rawValue: newValue)!
//      }
//    }
        let genderOptions: [String] = [Course.Gender.male.rawValue,
                                        Course.Gender.famale.rawValue,
                                        Course.Gender.both.rawValue]
    
        var gender: String {
          get {
            return course.gender.rawValue
          }
          set {
            course.gender = Course.Gender(rawValue: newValue)!
          }
        }
    
    var categoryOptions: [String] = [Course.Category.computer.rawValue,
                                     Course.Category.finance.rawValue,
                                     Course.Category.photophrapy.rawValue]
    var category: String? {
      get {
        return course.category?.rawValue
      }
      set {
        if let value = newValue {
          course.category = Course.Category(rawValue: value)!
        }
      }
    }
    
//    let repeatOptions: [String] = [ToDo.RepeatFrequency.never.rawValue,
//                                   ToDo.RepeatFrequency.daily.rawValue,
//                                   ToDo.RepeatFrequency.weekly.rawValue,
//                                   ToDo.RepeatFrequency.monthly.rawValue,
//                                   ToDo.RepeatFrequency.annually.rawValue]
//
//    var repeatFrequency: String {
//      get {
//        return toDo.repeats.rawValue
//      }
//      set {
//        toDo.repeats = ToDo.RepeatFrequency(rawValue: newValue)!
//      }
//    }
    
    // MARK: - Life Cycle
    
    init(course: Course) {
      self.course = course
    }
    
    // MARK: - Actions
    
    func delete() {
        NotificationCenter.default.post(name: .deleteCourseNotification, object: nil, userInfo: [ Notification.Name.deleteCourseNotification : course ])
    }
  }
}

extension Notification.Name {
  static let deleteCourseNotification = Notification.Name("delete course")
}

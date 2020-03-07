//
//  Utils.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/8.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit

public let rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController

public class Utils: NSObject {
   
    public class func delay(_ delay: Double, closure:@escaping () -> Void) {
        let delay = min(delay, Double.greatestFiniteMagnitude) //防止突破Double 上限
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + delay, execute: closure)
    }
    
    public class func randNumberBetween(min: Double, max: Double) -> Double {
        return min + (max-min) * Double(arc4random()%1000) / 1000
    }
    
    class func classNameAsString(_ obj: Any) -> String {
        return String(describing: type(of: obj))
    }
    
    public class func timeElapsedInSecondsWhenRunningCode(operation: ()->()) -> Double {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        return Double(timeElapsed)
    }
    public class func appVersion() -> String {
        let infoDictionary = Bundle.main.infoDictionary
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    public class func appVersionNum() -> String {
        return self.appVersion().replacingOccurrences(of: ".", with: "")
    }
}


//執行時間檢查 相關
extension Utils {
    public class func makeTimerSource(interval: DispatchTimeInterval, handler:@escaping () -> Void)
        -> DispatchSourceTimer {
            let result = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            result.setEventHandler {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    handler()
                })
            }
            result.schedule(deadline: .now(), repeating: interval ,leeway:.milliseconds(0));
            result.resume()
            return result
    }
    
    
    public class func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(title): \(timeElapsed) s.")
    }
}

struct WeakStruct {
    weak var weakObject: AnyObject?
    let objectName: String
}


public class RetainCycleLogger {
    var weakStructs = [WeakStruct]()
    public static let sharedInstance = RetainCycleLogger()
    
    public func addObject(object: AnyObject) {
        weakStructs.append(WeakStruct(weakObject: object, objectName: classNameAsString(object)))
    }
    
    func count(object: AnyObject) -> Int {
        let classname = classNameAsString(object)
        return weakStructs.filter({$0.objectName == classname}).flatMap({$0.weakObject}).count
    }
    
    func classNameAsString(obj: Any) -> String {
        return String(reflecting: obj)
    }
    
    public func allCounts() -> String {
        let classes = weakStructs.filter({$0.weakObject != nil}).map({$0.objectName})
        let uniqueClasses: [String] = Array(Set(classes))
        var output: String = ""
        for className in uniqueClasses {
            output += "Class: \(className) \(classes.filter({$0 == className}).count)\n"
        }
        return output == "" ? "No retained objects" : output
    }
}

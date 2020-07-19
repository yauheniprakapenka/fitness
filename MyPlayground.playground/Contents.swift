import UIKit

var test = ["car", "dog"]

if test.contains(where: {$0 == "dog"}) {
    print("it exists, do something")
} else {
    print("item could not be found")
}

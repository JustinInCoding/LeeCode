//: [Previous](@previous)

import Foundation

/*****   My answer   ****/

class Solution {
	func romanToInt(_ s: String) -> Int {
		return sumOfRoman(s)
	}

	let dictUnit = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
	let dictComponnet = ["IV": 4, "IX": 9, "XL": 40, "XC": 90, "CD": 400, "CM": 900]

	func sumOfRoman(_ s: String) -> Int {
		for (key, _) in dictComponnet {
			if s.contains(key) {
				let subSs = s.components(separatedBy: key)
				var result = dictComponnet[String(key)] ?? 0
				for subS in subSs {
					result += sumOfRoman(subS)
				}
				return result
			}
		}
		var result = 0
		for subS in s {
			result += dictUnit[String(subS)] ?? 0
		}
		return result
	}

}

let solution = Solution()
let answer = solution.sumOfRoman("MCMXCIV")
answer

/*****   My answer   ****/

//: [Next](@next)

//: [Previous](@previous)

import Foundation

/*
	判断一个整数是否是回文数。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。

	示例 1:
		输入: 121
		输出: true

	示例 2:
		输入: -121
		输出: false
		解释: 从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。

	示例 3:
		输入: 10
		输出: false
		解释: 从右向左读, 为 01 。因此它不是一个回文数。

	进阶:
		你能不将整数转为字符串来解决这个问题吗？
*/

/*****   My answer   ****/
class Solution {
	func isPalindrome(_ x: Int) -> Bool {
		var theX = x
		var xArray: [Int] = []
		repeat {
			let xNumber = theX % 10
			xArray.append(xNumber)
			theX /= 10
		} while theX / 10 != 0
		xArray.append(theX)
		var resultNum: Int = 0
		for i in 0..<xArray.count {
			resultNum += xArray[i] * Int(powf(10, Float(xArray.count - 1 - i)))
		}
		return x == resultNum
	}
}

// 没考虑溢出情况
// 没考虑负数情况

//var inputNum = 10001
//let solution = Solution()
//solution.isPalindrome(inputNum)

/*****   My answer   ****/

/*
	思路

	映入脑海的第一个想法是将数字转换为字符串，并检查字符串是否为回文。但是，这需要额外的非常量空间来创建问题描述中所不允许的字符串。

	第二个想法是将数字本身反转，然后将反转后的数字与原始数字进行比较，如果它们是相同的，那么这个数字就是回文。 但是，如果反转后的数字大于 int.MAX，我们将遇到整数溢出问题。

	按照第二个想法，为了避免数字反转可能导致的溢出问题，为什么不考虑只反转 int 数字的一半？毕竟，如果该数字是回文，其后半部分反转后应该与原始数字的前半部分相同。

	例如，输入 1221，我们可以将数字 “1221” 的后半部分从 “21” 反转为 “12”，并将其与前半部分 “12” 进行比较，因为二者相同，我们得知数字 1221 是回文。

	让我们看看如何将这个想法转化为一个算法。

	算法

	首先，我们应该处理一些临界情况。所有负数都不可能是回文，例如：-123 不是回文，因为 - 不等于 3。所以我们可以对所有负数返回 false。

	现在，让我们来考虑如何反转后半部分的数字。 对于数字 1221，如果执行 1221 % 10，我们将得到最后一位数字 1，要得到倒数第二位数字，我们可以先通过除以 10 把最后一位数字从 1221 中移除，1221 / 10 = 122，再求出上一步结果除以 10 的余数，122 % 10 = 2，就可以得到倒数第二位数字。如果我们把最后一位数字乘以 10，再加上倒数第二位数字，1 * 10 + 2 = 12，就得到了我们想要的反转后的数字。如果继续这个过程，我们将得到更多位数的反转数字。

	现在的问题是，我们如何知道反转数字的位数已经达到原始数字位数的一半？

	我们将原始数字除以 10，然后给反转后的数字乘上 10，所以，当原始数字小于反转后的数字时，就意味着我们已经处理了一半位数的数字。

作者：LeetCode
链接：https://leetcode-cn.com/problems/two-sum/solution/hui-wen-shu-by-leetcode/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

*/

/*****   Official Answer   ****/

class OfficialSolution {
	func isPalindrome(_ x: inout Int) -> Bool {
		// 特殊情况：
		// 如上所述，当 x < 0 时，x 不是回文数。
		// 同样地，如果数字的最后一位是 0，为了使该数字为回文，
		// 则其第一位数字也应该是 0
		// 只有 0 满足这一属性
		if x < 0 || (x % 10 == 0 && x != 0) {
			return false
		}

		var reverseNumber = 0
		while x > reverseNumber {
			reverseNumber = reverseNumber * 10 + x % 10
			x /= 10
		}

		// 当数字长度为奇数时，我们可以通过 revertedNumber/10 去除处于中位的数字。
		// 例如，当输入为 12321 时，在 while 循环的末尾我们可以得到 x = 12，revertedNumber = 123，
		// 由于处于中位的数字不影响回文（它总是与自己相等），所以我们可以简单地将其去除。

		return x == reverseNumber || x == reverseNumber / 10
	}
}

var inputNum = -10001
let officialSolution = OfficialSolution()
officialSolution.isPalindrome(&inputNum)

/*
	复杂度分析

	时间复杂度：O(log_{10}(n))，对于每次迭代，我们会将输入除以10，因此时间复杂度为 O(log_{10}(n))
	空间复杂度：O(1)
*/




/*****   Official Answer   ****/



//: [Next](@next)

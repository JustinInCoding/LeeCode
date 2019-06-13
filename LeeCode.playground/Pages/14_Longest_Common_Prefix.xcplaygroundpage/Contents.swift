//: [Previous](@previous)

import Foundation

/*
	编写一个函数来查找字符串数组中的最长公共前缀。

	如果不存在公共前缀，返回空字符串 ""。

	示例 1:
		输入: ["flower","flow","flight"]
		输出: "fl"

	示例 2:
		输入: ["dog","racecar","car"]
		输出: ""
		解释: 输入不存在公共前缀。

	说明:
		所有输入只包含小写字母 a-z 。


*/

/*****   My answer   ****/

class Solution {
	func longestCommonPrefix(_ strs: [String]) -> String {
		if strs.count == 0 { return "" }
		if strs.count == 1 { return strs[0] }
		let compareStr = strs[0]
		var subStrRet = ""
		var allContainsSubStr = true
		for i in 1..<compareStr.count {
			let endIndex = compareStr.index(compareStr.startIndex, offsetBy: i)
			let subStr = compareStr[compareStr.startIndex..<endIndex]
			for str in strs {
				if str == compareStr { continue }
				if !str.contains(subStr) {
					allContainsSubStr = false
					break
				}
			}
			if allContainsSubStr {
				subStrRet = String(subStr)
			} else {
				return subStrRet
			}
		}
		return subStrRet
	}
}

//let solution = Solution()
//let answer = solution.longestCommonPrefix(["dog", "racecar", "car"])
//answer

/*****   My answer   ****/

//let range = "aaa".range(of: "aa")
//range?.lowerBound

/*****   Official Answer   ****/

/*
	方法一：水平扫描法

	思路

	首先，我们将描述一种查找一组字符串的最长公共前缀LCP(S1...Sn)的简单方法。 我们将会用到这样的结论：
	LCP(S1...Sn)=LCP(LCP(LCP(S1,S2),S3),...Sn)

	算法

	为了运用这种思想，算法要依次遍历字符串[S1...Sn],当遍历到第 i 个字符串的时候，找到最长公共前缀LCP(S1...Si).当LCP(S1...Si)是一个空串的时候，算法就结束了。否则，在执行了 nn 次遍历之后，算法就会返回最终答案LCP(S1...Sn)
*/

/*

public String longestCommonPrefix(String[] strs) {
	if (strs.length == 0) return "";
	String prefix = strs[0];
	for (int i = 1; i < strs.length; i++)
		while (strs[i].indexOf(prefix) != 0) {
			prefix = prefix.substring(0, prefix.length() - 1);
			if (prefix.isEmpty()) return "";
		}
	return prefix;
}

作者：LeetCode
链接：https://leetcode-cn.com/problems/two-sum/solution/zui-chang-gong-gong-qian-zhui-by-leetcode/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
*/

class OfficialSolution_1 {
	func longestCommonPrefix(_ strs: [String]) -> String {
		guard strs.count != 0 else { return "" }
		var prefix = strs[0]
		for i in 1..<strs.count {
			let str = strs[i]
			var range = str.range(of: prefix)
//			print(range)
//			print(str.startIndex)
			while range?.lowerBound != str.startIndex {
				let endIndex = prefix.index(prefix.startIndex, offsetBy: prefix.count - 1)
				let subPrefix = prefix[prefix.startIndex..<endIndex]
				prefix = String(subPrefix)
				range = str.range(of: prefix)
				if prefix.isEmpty { return "" }
			}
		}
		return prefix
	}
}

let officialSolution = OfficialSolution_1()
let theAnswer = officialSolution.longestCommonPrefix(["flow", "flow", "flow"])
theAnswer

/*
	复杂度分析

		时间复杂度：O(S), S是所有字符串中字符数量的总和。
		最坏的情况下，n 个字符串都是相同的。算法会将 S1 与其他字符串 [S2...Sn]都做一次比较。这样就会进行 S 次字符比较，其中 S 是输入数据中所有字符数量。

		空间复杂度：O(1)，我们只需要使用常数级别的额外空间。

作者：LeetCode
链接：https://leetcode-cn.com/problems/two-sum/solution/zui-chang-gong-gong-qian-zhui-by-leetcode/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
*/

/*****   Official Answer   ****/

//: [Next](@next)

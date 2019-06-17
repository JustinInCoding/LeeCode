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

//let officialSolution = OfficialSolution_1()
//let theAnswer = officialSolution.longestCommonPrefix(["flow", "flow", "flow"])
//theAnswer

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

/*
	算法二：水平扫描

	算法

	想象数组的末尾有一个非常短的字符串，使用上述方法依旧会进行S​次比较。优化这类情况的一种方法就是水平扫描。我们从前往后枚举字符串的每一列，先比较每个字符串相同列上的字符（即不同字符串相同下标的字符）然后再进行对下一列的比较。

	作者：LeetCode
	链接：https://leetcode-cn.com/problems/two-sum/solution/zui-chang-gong-gong-qian-zhui-by-leetcode/
	来源：力扣（LeetCode）
	著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

*/

class OfficialSolution_2 {
	func longestCommonPrefix(_ strs: [String]) -> String {
		guard strs.count != 0 else { return "" }
		for i in 0..<strs[0].count {
			let index = strs[0].index(strs[0].startIndex, offsetBy: i)
			let c = strs[0][index]
			for j in 1..<strs.count {
				if i == strs[j].count || strs[j][index] != c {
					return String(strs[0][..<index])
				}
			}
		}
		return strs[0]
	}
}

//let officialSolution = OfficialSolution_2()
//let theAnswer = officialSolution.longestCommonPrefix(["flower", "flow", "flight"])
//theAnswer

/*
	复杂度分析

	时间复杂度：O(S)，S 是所有字符串中字符数量的总和。

	最坏情况下，输入数据为n个长度为m的相同字符串，算法会进行S=m*n次比较。可以看到最坏情况下，本算法的效率与算法一相同，但是最好的情况下，算法只需要进行 n*minLen 次比较，其中 minLen 是数组中最短字符串的长度。

	空间复杂度：O(1)，我们只需要使用常数级别的额外空间。

*/

/*
    算法三：分治
 
    思路
 
    这个算法的思路来自于LCP操作的结合律。 我们可以发现：LCP(S_1...S_n) = LCP(LCP(S_1...S_k), LCP (S_{k+1}...S_n))，其中 LCP(S_1...S_n)是字符串 [S_1...S_n] 的最长公共前缀，1 < k < n。
 
    算法
 
    为了应用上述的结论，我们使用分治的技巧，将原问题 LCP(Si...Sj)分成两个子问题LCP(Si...Smid)与LCP(S{mid+1}...Sj),其中mid= (i+j)/2,我们用子问题的解lcpLeft与lcpRight构造原问题的解LCP(Si...Sj).从头到尾挨个比较lcpLeft与lcpRight中的字符，直到不能再匹配为止。 计算所得的 lcpLeft 与 lcpRight最长公共前缀就是原问题的解LCP(Si...Sj)
 
 作者：LeetCode
 链接：https://leetcode-cn.com/problems/two-sum/solution/zui-chang-gong-gong-qian-zhui-by-leetcode/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 */

class OfficialSolution_3 {
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 {
            return ""
        }
        return longestCommonPrefix(strs, 0, strs.count - 1)
    }
    
    func longestCommonPrefix(_ strs: [String], _ l: Int, _ r: Int) -> String {
        if l == r {
            return strs[l]
        }
        let mid = (l + r) / 2
        let lcpLeft = longestCommonPrefix(strs, l, mid)
        let lcpRight = longestCommonPrefix(strs, mid + 1, r)
        return commonPrefix(lcpLeft, lcpRight)
    }
    
    func commonPrefix(_ left: String, _ right: String) -> String {
        let min: Int = [left.count, right.count].min() ?? 0
        var index = left.index(left.startIndex, offsetBy: 0)
        for i in 0..<min {
            index = left.index(left.startIndex, offsetBy: i)
            if left[index] != right[index] {
                return String(left[..<index])
            }
        }
        index = left.index(left.startIndex, offsetBy: min)
        return String(left[..<index])
    }
}


let officialSolution = OfficialSolution_3()
let theAnswer = officialSolution.longestCommonPrefix(["flow", "flow", "flow"])
theAnswer

/*
 
    复杂度分析
 
    最坏情况下，我们有 n 个长度为 m 的相同字符串。
 
    时间复杂度：O(S), S是所有字符串中字符数量的总和, S = m * n
 时间复杂度的递推式为 T(n) = 2 * T(n/2) + O(m), 化简后可知其就是O(S),最好情况下，算法会进行minLen * n次比较，其中minLen是数组中最短字符串的长度.
 
    空间复杂度: O(m*log(n))
 
    内存开支主要是递归过程中使用的栈空间所消耗的。 一共会进行log(n)次递归，每次需要 m的空间存储返回结果，所以空间复杂度为O(m * log(n))
 
 */

/*****   Official Answer   ****/



//: [Next](@next)

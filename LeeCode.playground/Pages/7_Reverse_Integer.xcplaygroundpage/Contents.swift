import UIKit

/*
 给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。

 示例 1:

     输入: 123
     输出: 321
 
 示例 2:

     输入: -123
     输出: -321

 示例 3:

     输入: 120
     输出: 21

 注意:

    假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−2^31,  2^31 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。

    来源：力扣（LeetCode）
    链接：https://leetcode-cn.com/problems/reverse-integer
    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */

/*****   My answer   ****/

-1 % 10

class Solution {
    func reverse(_ x: Int) -> Int {
//        guard x != 0 else { return 0 }
        var inputX = x
        let sign = inputX > 0 ? 1 : -1
        inputX = abs(inputX)
        var answer = 0
        repeat {
            answer *= 10            // 这里可能会溢出 当answer > Int32.max / 10的时候  或者  当 answer == Int32.max &&
            answer += inputX % 10
            inputX = inputX / 10
        } while inputX != 0
        answer = answer * sign
        return (answer >= Int32.min && answer <= Int32.max) ? answer : 0
    }
}

//let solution = Solution()
//solution.reverse(0)
/*****   My answer   ****/

/*
 为了便于解释，我们假设 rev 是正数。

    - 如果 temp = rev * 10 + pop 导致溢出，那么一定有 rev >= Int32.max / 10
    - 如果 rev > Int32.max / 10, 那么 temp = rev * 10 + pop 一定会溢出。
    - 如果 rev > Int32.max / 10，那么只要 pop > 7， temp = rev * 10 + pop 就会溢出。

 当 rev 为负时可以应用类似的逻辑。

作者：LeetCode
链接：https://leetcode-cn.com/problems/two-sum/solution/zheng-shu-fan-zhuan-by-leetcode/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

 */
 
/*****   Official Answer   ****/

class OfficialSolution {
    func reverse(_ x: inout Int) -> Int {
        var rev = 0
        while x != 0 {
            let pop = x % 10
            x /= 10
            guard rev < Int32.max / 10 || (rev == Int32.max / 10 && pop <= 7) else { return 0 }
            guard rev > Int32.min / 10 || (rev == Int32.min / 10 && pop < -8) else { return 0 }
            rev = rev * 10 + pop
        }
        return rev
    }
}

var number = Int(Int32.min)
let officialSolution = OfficialSolution()
officialSolution.reverse(&number)

/*
复杂度分析

时间复杂度：O(log(x)) x 中大约有log_{10}(x)位数字。
空间复杂度：O(1)。

作者：LeetCode
链接：https://leetcode-cn.com/problems/two-sum/solution/zheng-shu-fan-zhuan-by-leetcode/
来源：力扣（LeetCode）
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

/*****   Official Answer   ****/

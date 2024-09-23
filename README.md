# KhaznaTask
this repo is created for Khazna company task 

The Problem solving solution 


func missingNumber(arr: [Int]) -> Int {

	var mutableArray = arr

	let count = mutableArray.count

	for index in 0..<count {
		var number = mutableArray[index]

		while number > 0 && number <= count && mutableArray[number - 1] != number  {
			mutableArray.swapAt(number - 1, index)
			number = mutableArray[index]
		}
	}

	for index in 0..<count {
		if mutableArray[index] != index + 1{
			return index + 1
		}
	}

	return count + 1
}

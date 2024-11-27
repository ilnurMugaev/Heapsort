import Foundation

// MARK: - УРОВЕНЬ JUNIOR -

// 1. Реализация SelectionSort

func selectionSort(_ array: inout [Int]) -> (comparisons: Int, swaps: Int) {
    var comparisons = 0
    var swaps = 0

    for i in 0..<array.count - 1 {
        var minIndex = i
        for j in (i + 1)..<array.count {
            comparisons += 1
            if array[j] < array[minIndex] {
                minIndex = j
            }
        }
        if i != minIndex {
            array.swapAt(i, minIndex)
            swaps += 1
        }
    }
    return (comparisons, swaps)
}

print("SelectionSort")

var selectionArray = [64, 34, 25, 12, 22, 11, 90]
print("Исходный массив: \(selectionArray)")

let selectionResult = selectionSort(&selectionArray)
print("Отсортированный массив: \(selectionArray)")
print("Сравнений: \(selectionResult.comparisons), перестановок: \(selectionResult.swaps)\n")


// 2. Реализация HeapSort

func heapify(
    _ array: inout [Int],
    size: Int,
    root: Int,
    comparisons: inout Int,
    swaps: inout Int
) {
    var largest = root
    let left = 2 * root + 1
    let right = 2 * root + 2

    if left < size {
        comparisons += 1
        if array[left] > array[largest] {
            largest = left
        }
    }

    if right < size {
        comparisons += 1
        if array[right] > array[largest] {
            largest = right
        }
    }

    if largest != root {
        array.swapAt(root, largest)
        swaps += 1
        heapify(
            &array,
            size: size,
            root: largest,
            comparisons: &comparisons,
            swaps: &swaps
        )
    }
}

func heapSort(_ array: inout [Int]) -> (comparisons: Int, swaps: Int) {
    var comparisons = 0
    var swaps = 0

    // Построение кучи
    for i in stride(from: array.count / 2 - 1, through: 0, by: -1) {
        heapify(
            &array,
            size: array.count,
            root: i,
            comparisons: &comparisons,
            swaps: &swaps
        )
    }

    // Извлечение элементов из кучи
    for i in stride(from: array.count - 1, through: 1, by: -1) {
        array.swapAt(0, i)
        swaps += 1
        heapify(
            &array,
            size: i,
            root: 0,
            comparisons: &comparisons,
            swaps: &swaps
        )
    }

    return (comparisons, swaps)
}

print("HeapSort")

var heapArray = [64, 34, 25, 12, 22, 11, 90]
print("Исходный массив: \(heapArray)")

let heapResult = heapSort(&heapArray)
print("Отсортированный массив: \(heapArray)")
print("Сравнений: \(heapResult.comparisons), перестановок: \(heapResult.swaps)\n")


// MARK: - УРОВЕНЬ MIDDLE -

// 3. Измерение времени выполнения

func measureExecutionTime(for algorithm: (inout [Int]) -> (comparisons: Int, swaps: Int), with array: [Int]) -> Double {
    var arr = array
    let start = CFAbsoluteTimeGetCurrent()
    _ = algorithm(&arr)
    let end = CFAbsoluteTimeGetCurrent()
    return end - start
}

func generateRandomArray(size: Int, range: ClosedRange<Int> = 0...1_000_000) -> [Int] {
    return (0..<size).map { _ in Int.random(in: range) }
}

// Сравнение для массивов разного размера
//let sizes = [100, 1_000, 10_000, 100_000]
let sizes = [100, 1_000, 2_000, 5_000]

print(String(format: "%-12@ | %-12@ | %-12@", "Array Size", "SelectionSort", "HeapSort"))

print(String(repeating: "-", count: 40))

for size in sizes {
    let array = generateRandomArray(size: size)
    let selectionTime = measureExecutionTime(for: selectionSort, with: array)
    let heapTime = measureExecutionTime(for: heapSort, with: array)
    
    print(String(format: "%-12d | %-12.5f | %-12.5f", size, selectionTime, heapTime))
}

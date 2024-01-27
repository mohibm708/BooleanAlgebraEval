// big thanks to alex s.

func main() {
    let bools: Set<String> = ["true", "t", "1",
                              "false", "f", "0"]
    let yes: Set<String> = ["y", "yes"]
    let L = Bool(input("value of first variable: ", require: bools))!
    let R = Bool(input("value of second variable: ", require: bools))!
    let result = evaluate(L:L,R:R)
    print("result is \(result) \(result ? ":]" : ":[")")
    print("evaluate new? (y for yes, press any other key to exit): ")
    if yes.contains(readLine()!.lowercased()) {main()}
}

func input(_ string: String, require: Set<String>) -> String {
    print(string, terminator: "")
    var output = readLine()!.lowercased()
    guard require.contains(output) else {
        print("invalid value :[")
        return input(string, require: require)
    }
    rewrite(&output)
    return output
}

func rewrite(_ string: inout String) {
    switch string {
    case "true", "t", "1": string = "true"
    case "false", "f", "0": string = "false"
    case "and", "∧", "a": string = "and"
    case "or", "∨", "o": string = "or"
    case "not", "¬", "n": string = "not"
    case "xor", "⊕", "≠", "x": string = "xor"
    case "imply", "→", "i": string = "imply"
    case "equals", "=", "e": string = "equals"
    default: fatalError("unexpected argument \(string) :[[[")
    }
}

func evaluate(L: Bool, R: Bool, _ notCount: Int = 0) -> Bool {
    var notCount = notCount
    let operations: Set<String> = ["and", "∧", "a",
                                   "or", "∨", "o",
                                   "not", "¬", "n",
                                   "xor", "⊕", "≠", "x",
                                   "imply", "→", "i",
                                   "equals", "=", "e"]
    let operation = input("\(notCount > 0 ? String(repeating: "negation of ", count: notCount-1) : "")which operation: ", require: operations)
    switch operation {
    case "and": return L && R
    case "or": return L || R
    case "not": print("negating ", terminator: ""); notCount += 1; return !evaluate(L:L,R:R, notCount)
    case "xor": return L != R
    case "imply": return !L || R
    case "=": return L == R
    default: fatalError("unexpected argument \(operation) :[[[")
    }
}

main()

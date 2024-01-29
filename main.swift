// big thanks to alex s.

func main() {
    let bools: Set<String> = ["true", "t", "1", "⊤",
                              "false", "f", "0", "⊥"] // all (most) bool values
    let yes: Set<String> = ["y", "yes"]
    let L = Bool(input("value of first variable: ", require: bools))! // get bool values for right and left
    let R = Bool(input("value of second variable: ", require: bools))!
    let result = evaluate(L:L,R:R) // calculate truth
    print("result is \(result) \(result ? ":]" : ":[")") // boolean emoticon :]:
    print("evaluate new? (y for yes, press any other key to exit): ", terminator: "")
    if yes.contains(readLine()!.lowercased()) {main()} // if yes then retry if anything else then leave
}

func input(_ string: String, require: Set<String>) -> String {
    print(string, terminator: "")
    var output = readLine()!.lowercased() // .lowercased() immediately narrows down output possiblities
    guard require.contains(output) else { // if the output is one of the specified strings in require
        print("invalid value :[")
        return input(string, require: require) // recurses without halting process
    }
    rewrite(&output) // narrows output possiblities again to ideal string value
    return output
}

func rewrite(_ string: inout String) {
    switch string {
    case "true", "t", "1", "⊤": string = "true"
    case "false", "f", "0", "⊥": string = "false"
    case "and", "∧", "a": string = "and"
    case "or", "∨", "o": string = "or"
    case "not", "¬", "n": string = "not"
    case "xor", "⊕", "≠", "x": string = "xor"
    case "imply", "→", "i": string = "imply"
    case "equals", "=", "e": string = "equals"
    default: fatalError("unexpected argument \(string) :[[[") // this technically cannot happen, given that nothing interferes with the values during run. a default is still needed, however
    }
}

func evaluate(L: Bool, R: Bool, _ notCount: Int = 0) -> Bool {
    var notCount = notCount // how many times negated
    let operations: Set<String> = ["and", "∧", "a",
                                   "or", "∨", "o",
                                   "not", "¬", "n",
                                   "xor", "⊕", "≠", "x",
                                   "imply", "→", "i",
                                   "equals", "=", "e"]
    let operation = input("\(notCount > 0 ? String(repeating: "negation of ", count: notCount-1 /*only appears on second negation ("negating negation of which operation")*/) : "")which operation: ", require: operations)
    switch operation {
    case "and": return L && R
    case "or": return L || R
    case "not": print("negating ", terminator: ""); notCount += 1; return !evaluate(L:L,R:R, notCount) // adds a negation and requests binary operator; doesn't make sense to resolve with only a unary operator when 2 values are given
    case "xor": return L != R
    case "imply": return !L || R
    case "equals": return L == R
    default: fatalError("unexpected argument \(operation) :[[[") // refer to line 36
    }
}

main()

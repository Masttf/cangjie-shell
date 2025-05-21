package lsh
import std.console.*
func lsh_read_line() : String{
    let txt = Console.stdIn.readln()
    return txt ?? ""
}

func lsh_split_line(line: String) : Array<String>{
    
    return [""]
}

func lsh_execute(args: Array<String>) : Bool{
    return false
}

func lsh_loop() : Unit{
    var status: Bool = false
    do{
        print("> ")
        let line: String = lsh_read_line()
        let args: Array<String> = lsh_split_line(line)
        status = lsh_execute(args)
    } while(status == true)
}

main() : Int64{
    lsh_loop()
    return 0
}
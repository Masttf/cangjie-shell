package lsh
import std.console.*
import std.os.posix.chdir
import std.os.posix.getcwd

func lsh_cd(args: Array<String>) : Bool {
    if(args.size == 1){
        println("lsh: cd: missing argument")
    }else{
        if(chdir(args[1]) != Int32(0)){
            println("lsh: No such file or directory")
        }
    }
    
    return true
}

func lsh_read_line() : String{
    return Console.stdIn.readln() ?? ""
    
}
// 使用separator分割字符串
// removeEmpty: 是否去除空字符串
func lsh_split_line(line: String, separator: String) : Array<String>{
    return line.split(separator, removeEmpty: true)
}

func lsh_execute(args: Array<String>) : Bool{
    //空参直接返回
    if(args.size == 0){
        return true
    }
    if(args[0] == "cd"){
        return lsh_cd(args)
    }

    return false
}

func lsh_loop() : Unit{
    var status: Bool = false
    do{
        print(getcwd() + "> ")
        let line: String = lsh_read_line()
        // println(line)
        let args: Array<String> = lsh_split_line(line, " ")
        // println(args)
        status = lsh_execute(args)
    } while(status == true)
}

main() : Int64{
    lsh_loop()
    return 0
}
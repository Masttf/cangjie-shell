/*
@author:Masttf
*/
package lsh
import std.console.*
import std.os.posix.chdir
import std.os.posix.getcwd
import std.os.process.CurrentProcess
import std.collection.HashMap

func lsh_launch(args: Array<String>) : Bool{
    CurrentProcess.run(args[0], args.slice(1, args.size - 1))
    return true;
}

func lsh_cd(args: Array<String>) : Bool {
    if(args.size == 1){
        println("lsh: cd: missing argument")
    }else{
        // 通过指定路径的方式，更改调用进程的当前工作目录
        //返回值：Int32 - 设置成功，返回 0，设置失败, 返回 -1
        if(chdir(args[1]) != Int32(0)){
            println("lsh: No such file or directory")
        }
    }
    return true
}

func lsh_help(args: Array<String>) : Bool{
    println("LSH - Cangjie Shell")
    println("输入程序名称和参数，然后按 Enter 键执行。")
    println("内置命令列表:")
    println("  cd       更改当前目录")
    println("  help     显示此帮助信息")
    println("  exit     退出 LSH")
    println("对于其他外部程序,请使用其各自的帮助选项(例如 'man <程序名>' 或 '<程序名> --help').")
    return true
}


func lsh_exit(args: Array<String>) : Bool{
    return false;
}

type CommandHandler = (Array<String>) -> Bool
// 定义 builtInCommands 映射表
let builtInCommands = HashMap<String, CommandHandler>([
    ("cd",lsh_cd),
    ("help",lsh_help),
    ("exit",lsh_exit)
])

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
    let commandName = args[0]
    if(builtInCommands.contains(commandName)){
        return builtInCommands[commandName](args) 
    }else{
        return lsh_launch(args)
    }
}

func lsh_loop() : Unit{
    var status: Bool = false
    do{
        print(getcwd() + "> ")
        let line: String = lsh_read_line()
        let args: Array<String> = lsh_split_line(line, " ")
        status = lsh_execute(args)
    } while(status == true)
}

main() : Int64{
    lsh_loop()
    return 0
}
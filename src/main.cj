/*
author:Masttf
*/
package lsh
import std.console.*
import std.os.posix.chdir
import std.os.posix.getcwd
import std.os.process.CurrentProcess


func lsh_launch(args: Array<String>) : Bool{
    // println("lsh: ${args[0]}")
    let exitCode = CurrentProcess.run(args[0], args.slice(1, args.size - 1))
    // println("lsh: ${args[0]} exited with code ${exitCode}")
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

func lsh_help() : Bool{
    println("LSH")
    println("输入程序的名字和参数，按回车运行")
    println("下面是内置的程序")
    println("help")
    println("cd")
    println("exit")
    println("对于其他的程序使用man函数")
    return true
}

func lsh_exit() : Bool{
    return false;
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
    }else if(args[0] == "help"){
        return lsh_help()
    }else if(args[0] == "exit"){
        return lsh_exit()
    }else{
        return lsh_launch(args)
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
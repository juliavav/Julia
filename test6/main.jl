function counting(num1,num2,operation,file)
    if operation == '+'
        answer=num1 + num2
    elseif operation == '-'
        if num1>num2 
            answer=num1-num2
        else 
            answer="ERROR"
        end
    elseif operation == '*'
        answer=num1 * num2
    elseif operation == '/'
        answer=num1 % num2
    elseif operation == '<'
        answer=num1<num2
    elseif operation == '>'
        answer=num1>num2
    else operation == '='
        answer=num1==num2
    end
    write(file,"$answer\n")       
end

n=15
operations =['+','-','/','*','=','>','<']
fileTest=open("test1","w");
fileAnsw=open("answ","w");
for i=1:n
    num1=rand(UInt128)
    num2=rand(UInt128)
    oper=rand(operations)
    write(fileTest,"$num1\n$num2\n$oper\n")
    counting(num1,num2,oper,fileAnsw)

end
close(fileTest)
close(fileAnsw)
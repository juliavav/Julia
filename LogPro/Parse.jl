membersD=Dict()
file = open("family.txt");
text=readstring(file)
close(file)

indi = matchall(r"0 @I.*@",text)
names = matchall(r"1 NAME.*\n",text)

for i=1:size(indi,1)
        indi[i]=replace(indi[i],"0 ","")
        #indi[i]=chop(indi[i])
        names[i]=replace(names[i],"1 NAME ","")
        names[i]=replace(names[i]," //","")
        names[i]=replace(names[i],"\r\n","")
        # if ismatch(r"\s\s.+",names[i]) #check regex
        #     println("OOOOOOOO")
        #     names[i]=replace(names[i]," ","")
        # end
        #names[i]=replace(names[i]," /","")
        names[i]=replace(names[i],"/","")
        membersD[indi[i]]=names[i]
#print(indi[i])
#println(membersD)
end
families = matchall(r"0 @F.*?1 RIN"sm, text)
struct father
    father
    child
end

struct mother
    mother
    child
end
#fathers=Array{FatherS,1}
#mothers=Array{MotherS,1}
# families = matchall(r"0 @F.*@ FAM", text)
for j in eachindex(families)
    if contains(families[j],"HUSB")&&contains(families[j],"CHIL")
        husb=match(r"HUSB @.*",families[j]).match
        husb=replace(husb,"HUSB ","")
        husb=replace(husb,"\r","")
        chil=matchall(r"CHIL .*",families[j])
        #println(husb)
        for k in eachindex(chil)
            chil[k]=replace(chil[k],"CHIL ","")
            chil[k]=replace(chil[k],"\r","")
            #println(chil[k])
            nameH=membersD[husb]
            if nameH!=""
                str=father(nameH,membersD[chil[k]])
                print(str)
                println(".")
            end
            #fathers[husbCount]=str
            #husbCount++
        end
    end
    if contains(families[j],"WIFE")&&contains(families[j],"CHIL")
        wife=match(r"WIFE @.*",families[j]).match
        wife=replace(wife,"WIFE ","")
        wife=replace(wife,"\r","")
        chil=matchall(r"CHIL .*",families[j])
        #println(husb)
        for k in eachindex(chil)
            chil[k]=replace(chil[k],"CHIL ","")
            chil[k]=replace(chil[k],"\r","")
            #println(chil[k])s
            nameM=membersD[wife]
            if nameM!=""
                str=mother(nameM,membersD[chil[k]])
                print(str)
                println(".")
                end
            #fathers[husbCount]=str
            #husbCount++
        end  
    end
end

#println(fathers)
#println(names)


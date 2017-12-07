membersD=Dict()
file = open("family.txt");
text=readstring(file)
close(file)

indi = matchall(r"0 @I.*@",text)
names = matchall(r"1 NAME.*\n",text)

for i=1:size(indi,1)
        indi[i]=replace(indi[i],"0 ","")
        names[i]=replace(names[i],"1 NAME ","")
        names[i]=replace(names[i]," //","")
        names[i]=replace(names[i],"\r\n","")
        names[i]=replace(names[i],"/","")
        membersD[indi[i]]=names[i]
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

for j in eachindex(families)
    if contains(families[j],"HUSB")&&contains(families[j],"CHIL")
        husb=match(r"HUSB @.*",families[j]).match
        husb=replace(husb,"HUSB ","")
        husb=replace(husb,"\r","")
        chil=matchall(r"CHIL .*",families[j])
        for k in eachindex(chil)
            chil[k]=replace(chil[k],"CHIL ","")
            chil[k]=replace(chil[k],"\r","")
            nameH=membersD[husb]
            if nameH!=""
                str=father(nameH,membersD[chil[k]])
                open("myFamily.pl","a") do file
                    write(file,("father('$(str.father)', '$(str.child)').\n"))
                end
            end
        end
    end
    if contains(families[j],"WIFE")&&contains(families[j],"CHIL")
        wife=match(r"WIFE @.*",families[j]).match
        wife=replace(wife,"WIFE ","")
        wife=replace(wife,"\r","")
        chil=matchall(r"CHIL .*",families[j])
        for k in eachindex(chil)
            chil[k]=replace(chil[k],"CHIL ","")
            chil[k]=replace(chil[k],"\r","")
            nameM=membersD[wife]
            if nameM!=""
                str=mother(nameM,membersD[chil[k]])
                open("myFamily.pl","a") do file
                    write(file,("mother('$(str.mother)', '$(str.child)').\n"))
                end
            end
        end  
    end
end

file=open("family.txt")
# index=size(names)
sex=String[]
for line in eachline(file)
    if contains(line, "1 SEX M")
    #    sex[index]="M"
    push!(sex,"male")
    end
    if contains(line, "1 SEX F")
    #    sex[index]="F"
    push!(sex,"female")
    end
end
close(file)

#show(sex)

for j in eachindex(names)
    temp=pop!(sex)
    open("myFamily.pl","a") do file
        if names[size(names,1)-j+1]!=""
    write(file,"$temp('$(names[size(names,1)-j+1])').\n")
        end
    end
end


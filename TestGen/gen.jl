file = open("input.txt");
words=String[]
for ln in eachline(file)
    ln=chomp(ln)   
    push!(words,ln)
end

close(file)
wordsSize=size(words,1)
patternSize=rand(1:5)
textSize=rand(30:100)

patternNums=rand(1:wordsSize,patternSize)
#show(patternNums)
push!(words,"\n")
push!(words,"\n")
push!(words,"\n")
push!(words,"\n")
wordsSize=size(words,1)
textNums=rand(1:wordsSize,textSize)

file=open("test.txt","w");
for j in eachindex(patternNums)
    write(file,"$(words[patternNums[j]]) ")
end
write(file,"\n")

for j in eachindex(textNums)
    write(file,"$(words[textNums[j]])")
    if (words[textNums[j]]!="\n")
        write(file," ")
    end
end
write(file,"\n")
close(file)
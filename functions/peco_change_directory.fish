function _peco_change_directory
  if [ (count $argv) ]
    peco --query "$argv" | perl -pe 's/([ ()])/\\\\$1/g' | read foo
  else
    peco | perl -pe 's/([ ()])/\\\\$1/g' | read foo
  end
  if [ $foo ]
    builtin cd $foo
  else
    commandline ''
  end
end

function ghq-list
  find $GOPATH/src -d 3 -maxdepth 3 | grep -v DS_Store
end

function peco_change_directory
  begin
    echo $HOME/.config
    ls -ad */ | perl -pe "s#^#$PWD/#" | egrep -v "^$PWD/\." | head -n 5
    sort -r -t '|' -k 3 $Z_DATA | sed -e 's/\|.*//'
    ghq-list
    ls -ad */ | perl -pe "s#^#$PWD/#" | grep -v \.git
  end | sed -e 's/\/$//' | awk '!a[$0]++' | _peco_change_directory $argv
end


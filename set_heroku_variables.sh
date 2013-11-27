cat ~/.bash_profile  | grep "T[WR][UE]L\?L\?O\?" | cut -d' ' -f2 | sed s/localhost:9393/twu-toolkit.herokuapp.com/ | xargs heroku config:set

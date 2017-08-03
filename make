#!/bin/bash -e
#-----------------------------

#terraform bootstraper util

bootstrap() {
  terraform get
}
#-----------------------------

#terraform updater util

update() {
  terraform refresh
  terraform apply
}
#-----------------------------

#Continius Integration

ci() {
    if [ $1 == "tf" ]; then
        for m in `ls -1 */*.tf | xargs -I % dirname %`; do (terraform validate "$m" && echo "√ $m") || exit 1 ; done
	    (terraform validate . && echo "√ .") || exit 1
	else
	    echo "Need indicate specific test"
	    exit 1
    fi
}
#-----------------------------

#garbage collector

gc() {

    for file in `find lambda -mindepth 1 -name '*.zip'`; do rm $file; done
    #TODO: check why the next line generate etc folder in process for download dependencies
    for file in `find lambda -mindepth 1 -maxdepth 1 -type d`; do npm --prefix $file install $file; done
    for file in `find lambda -mindepth 1 -maxdepth 1 -type d`; do zip -r ./$file/handler.zip "$file" \
    --exclude=**.tf* --exclude=*package.json* --exclude=*package-lock.json* --exclude=*.gitignore* --exclude=*etc*; done

}
#-----------------------------

#lambda generator

new() {

 cd ./lambda/
 if [ -d "$1" ]; then
  echo "Directory already exist, please asign other name to new directory for lambda function"
  exit 1
 else
  mkdir -pv $1
  cd $1
  npm init -y
  touch index.js
  echo "module.exports.handler = function (evt, ctx, cbc) {};" > index.js
  echo "Create successful, begin play with lambda"
  exit 1
 fi

}
#-----------------------------

#case switch for options


  case "$1" in
    gc)
        gc
        ;;
    ci)
        ci $2
        ;;
    update)
        update
        ;;
    bootstrap)
        bootstrap
        ;;
    new)
        new $2
        ;;
    *)
        echo "new | gc | ci | bootstrap"
        exit 1
  esac

  exit 0


#-----------------------------
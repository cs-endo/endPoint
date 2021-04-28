#!/bin/bash

function crun {
        [[ -n $1 || -n $2 ]] || return
        case $1 in
                java)
                        ExtFile="java"; ExtComp="class"
                        ScrCom="javac $2.$ExtFile"
                        ScrRun="java $2"
                        ;;
                cpp)
                        ExtFile="cpp"; ExtComp="out"
                        ScrCom="g++ $2.$ExtFile -o $2.$ExtComp"
                        ScrRun="./$2.$ExtComp"
                        ;;
                as)
                        ExtFile="s"; ExtComp="out"
                        ScrCom="gcc $2.$ExtFile -no-pie -o $2.$ExtComp"
                        ScrRun="./$2.$ExtComp"
                        ;;
                go)
                        ExtFile="go"; ExtComp="out"
                        ScrCom="gccgo $2.$ExtFile -o $2.$ExtComp"
                        ScrRun="./$2.$ExtComp"
                        ;;
                groff)
                        ExtFile="ms"; ExtComp="ps"
                        groff -ems "$2.$ExtFile" > "$2.$ExtComp"
                        return
                        ;;
                *)
                        return
                        ;;
        esac
}

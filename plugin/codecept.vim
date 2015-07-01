" codecept.vim - A codeception wrapper to enable running tests frmo vim
" Maintainer: John Evans<john@grandadevans.com>
" Version: 0.0.1
" GetLatestVimScript: ???

   
let g:codecept                  = {}
let g:codecept.exec = {}

let g:codecept.exec.path     = "./vendor/bin/codecept"
let g:codecept.testsToRunOnSave = "unit"

let g:codecept.db               = {}
let g:codecept.db.user          = 'john'
let g:codecept.db.password      = 'password'
let g:codecept.db.name          = 'dbName'
let g:codecept.db.host          = '127.0.0.1'
let g:codecept.db.port          = "3306"

if exists('g:codecept.loaded') || &cp
    finish
endif

if !exists('g.codecept.exec.path')
    let g:codecept.exec.path = './vendor/bin/codecept'
endif

autocmd  BufWriteCmd  Test*.php call: s:RunUnitTests()

"source "../autoload/codecept.vim"
"
function! s:CreateConfig()
    " Make a copy that we can edit in place
    :!cp ./templates/codeception.yml ./codeception.yml

    " Edit the copy that we have just made
    execute "!sed -i -e 's/{port}/".g:codecept.db.port."/' codeception.yml"
    execute "!sed -i -e 's/{user}/".g:codecept.db.user."/' codeception.yml"
    execute "!sed -i -e 's/{password}/".g:codecept.db.password."/' codeception.yml"
    execute "!sed -i -e 's/{host}/".g:codecept.db.host."/' codeception.yml"
    execute "!sed -i -e 's/{name}/".g:codecept.db.name."/' codeception.yml"
    return true
endfunction

function! s:RunUnitTests()
    call: s:CreateConfig()
    call: s:RunUnitTestsCommand()
    return true
endfunction

function! s:RunUnitTestsCommand()
   execute ":!".g:codecept.exec.path." run unit"
    return true
endfunction

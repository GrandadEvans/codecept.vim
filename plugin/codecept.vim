let g:codecept                  = {}

let g:codecept.plugin      = {}
let g:codecept.plugin.path = '/home/john/projects/vimPlugins/codeception'

let g:codecept.exec = {}
let g:codecept.exec.path     = "./vendor/bin/codecept"
let g:codecept.testsToRunOnSave = "unit"

let g:codecept.db               = {}
let g:codecept.db.user          = 'john'
let g:codecept.db.password      = 'password'
let g:codecept.db.name          = 'dbName'
let g:codecept.db.host          = '127.0.0.1'
let g:codecept.db.port          = "3306"


:function! s:CreateConfig()
    " Make a copy that we can edit in place
    execute ":!cp" g:codecept.plugin.path."/templates/codeception.yml" g:codecept.plugin.path."/codeception.yml"

    " Edit the copy that we have just made
    execute "!sed -i -e 's/{port}/".g:codecept.db.port."/'         "g:codecept.plugin.path."/codeception.yml"
    execute "!sed -i -e 's/{user}/".g:codecept.db.user."/'         "g:codecept.plugin.path."/codeception.yml"
    execute "!sed -i -e 's/{password}/".g:codecept.db.password."/' "g:codecept.plugin.path."/codeception.yml"
    execute "!sed -i -e 's/{host}/".g:codecept.db.host."/'         "g:codecept.plugin.path."/codeception.yml"
    execute "!sed -i -e 's/{name}/".g:codecept.db.name."/'         "g:codecept.plugin.path."/codeception.yml"
:endfunction

:function! g:RunUnitTests()
    echo "Here!"
    call s:CreateConfig()
    call s:RunUnitTestsCommand()
:endfunction

:function! s:RunUnitTestsCommand()
   execute ":!".g:codecept.exec.path." run unit"
:endfunction

autocmd  BufWriteCmd  Test*.php call g:RunUnitTests()

let g:ale_echo_msg_format = '[%linter%] [%severity%] %code% %s'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_yaml_yamllint_options =
        \ '-d
        \ "{extends: default,
        \ rules: {line-length: false, document-start: disable}}"'

function config
    set -l options --stop-nonopt --exclusive 'a,e,l,s' --exclusive 'g,U'
    set -a options 'h/help' 'a/add' 'e/edit' 'l/list' 's/show'
    set -a options 'g/global' 'U/universal'
    argparse -n config $options -- $argv
    if set -q _flag_help
        __fish_print_help config
    end
    set -l config_scope
    if set -q _flag_global
        set config_scope --global
    else if set -q _flag_universal
        set config_scope --universal
    end

    if set -q _flag_add
        __user_config_add $argv
    else if set -q _flag_edit
        __user_config_edit $argv
    else if set -q _flag_list
        __user_config_list $argv
    else if set -q _flag_show
        __user_config_show $argv
    else
        echo else
    end

end


function __user_config_add --no-scope-shadowing
    if not set -q argv[2]
        printf ( _ "%s %s: Requires at least two arguments\n" ) config --add >&2
        return 1
    end
    set -l config_name $argv[1]
    set -l escaped_config_name (string escape -- $config_name)
    if string match -q "* *" -- $config_name
        set -l msg ( _ "%s %s: Config %s cannot have spaces in the word\n" )
        printf $msg config --add $escaped_config_name >&2
        return 1
    end
    set -l config_path $argv[2]
    set -l config_var_name _fish_config_(string escape --style=var -- $config_name)
    if not set -q $config_scope
        set config_scope --universal
    end
    true
    set $config_scope $config_var_name $config_path
end

function __user_config_edit
    if not set -q argv[1]
        printf ( _ "%s %s: Requires an argument\n" ) config --edit >&2
        return 1
    end
    set -l config_name $argv[1]
    set -l config_var_name _fish_config_(string unescape --style=var -- $config_name)
    if not set -q $config_var_name
        printf ( _ "%s %s: Config %s does not exist\n" ) config --edit $config_name >&2
        return 1
    end
    edit $$config_var_name
end

function __user_config_list --no-scope-shadowing
    if set -q argv[1]
        printf ( _ "%s %s: Unexpected argument\n" ) config --list >&2
        return 1
    end
    for var_name in (set --names)
        if not string match -q '_fish_config_*' $var_name 
            continue
        end

        set -l config_name (string unescape --style=var -- (string sub -s 13 -- $var_name))
        echo $config_name
    end
end

function __user_config_show --no-scope-shadowing
    if set -q argv[1]
        printf ( _ "%s %s: Unexpected argument\n" ) config --show >&2
        return 1
    end
    for var_name in (set --names)
        if not string match -q '_fish_config_*' $var_name 
            continue
        end

        set -l config_name (string unescape --style=var -- (string sub -s 13 -- $var_name))
        echo $config_name $$var_name
    end
end
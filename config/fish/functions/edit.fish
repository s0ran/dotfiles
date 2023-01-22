function edit
    argparse -n edit -s -i i/info -- $argv or return 1
    if set -lq _flag_info
        echo "Editor: $EDITOR"
        $EDITOR --version
        return 0
    end
    $EDITOR $argv
end

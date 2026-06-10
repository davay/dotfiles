function submodule
    set repo_path $argv[1]
    set full_path (realpath $repo_path)
    set rel_path (string replace $HOME/ "" $full_path)
    set url (git -C $full_path remote get-url origin 2>/dev/null)
    if test -z "$url"
        echo "No remote 'origin' found in $repo_path"
        return 1
    end
    echo "Found URL: $url"
    fish -c "cd ~ && yadm rm --cached -f '$rel_path'; yadm submodule add $url '$rel_path'"
end

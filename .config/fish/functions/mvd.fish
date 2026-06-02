function mvd -d "Move the most recent file from Downloads directory"
    set latest_file (find ~/Downloads -type f -maxdepth 1 -print0 | xargs -0 ls -t | head -1)
    
    if test -z "$latest_file"
        echo "No files found in Downloads directory"
        return 1
    end
    
    echo "Most recent file is: $latest_file"
    read -P "Do you want to move this file? (y/n) " confirm
    
    if string match -qi "y" $confirm
        mv "$latest_file" (test -n "$argv[1]"; and echo $argv[1]; or echo ".")
    else
        echo "Move cancelled"
    end
end
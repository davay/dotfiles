function recycle -d "Move files/folders to ~/Recycle instead of deleting them"
    if test (count $argv) -eq 0
        echo "Usage: recycle <file_or_folder>..."
        return 1
    end

    set -l dest ~/Recycle
    set -l logfile "$dest/.recycle.log"
    mkdir -p $dest

    set -l status_code 0
    for item in $argv
        if not test -e "$item"; and not test -L "$item"
            echo "recycle: '$item' does not exist"
            set status_code 1
            continue
        end

        set -l base (basename "$item")

        # Record the absolute original location (without resolving the item itself,
        # so a recycled symlink is restored as a symlink)
        set -l parent (realpath -- (dirname -- "$item") 2>/dev/null; or dirname -- "$item")
        set -l orig "$parent/$base"

        set -l target "$dest/$base"

        # Avoid clobbering an existing entry in ~/Recycle by appending a counter
        if test -e "$target"; or test -L "$target"
            set -l n 1
            while test -e "$dest/$base.$n"; or test -L "$dest/$base.$n"
                set n (math $n + 1)
            end
            set target "$dest/$base.$n"
        end

        if mv "$item" "$target"
            echo "recycled: $item -> $target"
            # Log so `recover` can restore it: epoch <tab> stored-name <tab> original-path
            printf '%s\t%s\t%s\n' (date +%s) (basename "$target") "$orig" >>$logfile
        else
            set status_code 1
        end
    end

    return $status_code
end

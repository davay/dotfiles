function recover -d "Interactively restore items from ~/Recycle to their original location"
    set -l dest ~/Recycle
    set -l logfile "$dest/.recycle.log"

    if not test -s "$logfile"
        echo "recover: nothing to recover (no items recorded in $logfile)"
        return 1
    end

    # Build menu entries for logged items that still exist in ~/Recycle.
    # Each menu line is tab-separated: <display>\t<stored-name>\t<original-path>
    # so we can show a friendly display column yet recover the exact fields.
    set -l menu
    for line in (cat $logfile)
        set -l parts (string split \t -- $line)
        test (count $parts) -ge 3; or continue
        set -l epoch $parts[1]
        set -l stored $parts[2]
        set -l orig $parts[3]

        if test -e "$dest/$stored"; or test -L "$dest/$stored"
            set -l when (date -r $epoch "+%Y-%m-%d %H:%M" 2>/dev/null; or echo $epoch)
            set -a menu (printf '%s   %s   →   %s\t%s\t%s' "$when" "$stored" "$orig" "$stored" "$orig")
        end
    end

    if test (count $menu) -eq 0
        echo "recover: nothing to recover (recycle bin empty or items removed)"
        return 1
    end

    # Present most-recently-recycled first.
    set -l ordered
    for i in (seq (count $menu) -1 1)
        set -a ordered $menu[$i]
    end

    set -l choice (printf '%s\n' $ordered | fzf \
        --delimiter \t \
        --with-nth 1 \
        --header 'Recover which item?  (enter = restore, esc = cancel)' \
        --preview 'printf "Restores to:\n  %s\n" {3}' \
        --preview-window down,3,wrap)

    if test -z "$choice"
        echo "recover: cancelled"
        return 1
    end

    set -l sel (string split \t -- $choice)
    set -l stored $sel[2]
    set -l orig $sel[3]
    set -l src "$dest/$stored"

    if not test -e "$src"; and not test -L "$src"
        echo "recover: '$src' no longer exists"
        return 1
    end

    set -l parent (dirname -- "$orig")
    mkdir -p "$parent"

    # Don't clobber something now sitting at the original path.
    set -l target "$orig"
    if test -e "$target"; or test -L "$target"
        set -l tbase (basename -- "$orig")
        set -l n 1
        while test -e "$parent/$tbase.$n"; or test -L "$parent/$tbase.$n"
            set n (math $n + 1)
        end
        set target "$parent/$tbase.$n"
        echo "recover: original path is occupied; restoring to $target"
    end

    if mv "$src" "$target"
        echo "recovered: $stored -> $target"
        # Drop this item's line(s) from the log.
        set -l tmp (mktemp)
        grep -vF (printf '\t%s\t' "$stored") $logfile >$tmp 2>/dev/null
        mv $tmp $logfile
    else
        echo "recover: failed to restore $src"
        return 1
    end
end

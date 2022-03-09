        cd `dirname $0` # Come back to the dotfiles directory
        sudo cp tools/XTBook /usr/local/bin/
        sudo chmod +x /usr/local/bin/XTBook
        while true; do
            echo -n "Your dictionary path: "; read dict
            echo -n "Correct (${dict}) [Y/n]? "; read key
            if [ "$key" != "n" ]; then
                break
            fi
        done
        sudo sed -i -e "s%^DICTDIR=.*%DICTDIR=${dict}%" -e "s%^PLIST=.*%PLIST=$(cd `dirname $0`; pwd)%" /usr/local/bin/XTBook
        echo "Done."
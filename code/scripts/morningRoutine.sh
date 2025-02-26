#!/bin/bash
function performMorningRoutine {
  openArc && oktaLogin && vpnOn && githubLogin && girondeSignIn && runCaffeinateInTmux && sendNotification
}

function openArc {
  open "/Applications/Arc.app"
  sleep 1
}

function oktaLogin {
  clickNextButton=$(
    openTabInArc "https://pinterest.okta.com"
    osascript <<EOF
      tell application "Arc"
        tell front window
            tell active tab
                execute javascript "
                    var button = document.getElementById('idp-discovery-submit');
                    var clicked = false;
                    if (button) {
                        button.click();
                        clicked = true;
                    }
                "
            end tell
        end tell
    end tell
EOF
  )
  [[ "$clickNextButton" == "true" ]] && sleep 12
  sleep 5
  closeActiveTabInArc
}

# NOTE: GlobalProtect must be running.
# REF: https://gist.github.com/kaleksandrov/3cfee92845a403da995e7e44ba771183
function vpnOn {
  osascript <<EOF
    tell application "System Events" to tell process "GlobalProtect"
        if not (exists window 1) then click menu bar item 1 of menu bar 2  # activate GlobalProtect menubar window
        if (exists (first UI element of window 1 whose title is "Connect")) then
            click (first UI element of window 1 whose title is "Connect")

            set displayingDisconnect to false

            repeat while displayingDisconnect is false
                try
                    set currDisplayingDisconnect to (exists (first UI element of window 1 whose title is "Disconnect"))
                    if currDisplayingDisconnect is true then
                        set displayingDisconnect to true
                    else
                        delay 5
                    end if
                on error
                    -- Do nothing; just continue the loop
                end try
            end repeat

        end if
        if exists window 1 then click menu bar item 1 of menu bar 2  # close GlobalProtect menubar window
    end tell
EOF
}

function githubLogin {
  openTabInArc "https://github.com/pinternal"
  osascript <<EOF
tell application "Arc"
    tell front window
        tell active tab
            execute javascript "
                var button = Array.from(document.querySelectorAll('button[type=\"submit\"]'))
                    .find(b => b.textContent.trim() === 'Continue');
                if (button) {
                    button.click();
                }
            "
        end tell
    end tell
end tell
EOF
closeActiveTabInArc
}

function girondeSignIn {
  gironde sign # devapp + GitHub
}

function runCaffeinateInTmux {
  sh ~/code/scripts/run_caffeinate_in_tmux.sh
}

function sendNotification {
  osascript <<EOF
    display notification "Morning routine was completed at $(date +"%Y-%m-%d %H:%M")!" with title "Success"
EOF
}

# Utilities
function openTabInArc {
  osascript <<EOF
    tell application "Arc"
      activate
      delay 1
      open location "$1"
    end tell 
EOF
  sleep 2
}

function closeActiveTabInArc {
  osascript <<EOF
    tell application "Arc"
      activate
      tell front window
          close (active tab)
      end tell
    end tell
EOF
}
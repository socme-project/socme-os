{ pkgs, config, inputs, ... }:
let

  configDirectory = "/etc/nixos";
  hostname = config.networking.hostName;

  nixy = pkgs.writeShellScriptBin "nixy"
    # bash
    ''
      hostname=""
      if [[ ${hostname} == "Node-"* ]];then
        hostname="node"
      elif [[ ${hostname} == "Core-"* ]];then
        hostname="core"
      elif [[ ${hostname} == "Hermes-"* ]];then
        hostname="hermes"
      else
        echo "Unknown hostname"
        exit 0
      fi

      function exec() {
        $@
      }

      function ui(){
        DEFAULT_ICON="󰘳"

        # "icon;name;command"[]
        apps=(
          "󰑓;Rebuild;nixy rebuild"
          "󰦗;Upgrade;nixy upgrade"
          "󰚰;Update;nixy update"
          ";Collect Garbage;nixy gc"
          "󰍜;Clean Boot Menu;nixy cb"
        )

        # Apply default icons if empty:
        for i in "''${!apps[@]}"; do
          apps[i]=$(echo "''${apps[i]}" | sed 's/^;/'$DEFAULT_ICON';/')
        done

        fzf_result=$(printf "%s\n" "''${apps[@]}" | awk -F ';' '{print $1" "$2}' | ${pkgs.fzf}/bin/fzf)
        [[ -z $fzf_result ]] && exit 0
        fzf_result=''${fzf_result/ /;}
        line=$(printf "%s\n" "''${apps[@]}" | grep "$fzf_result")
        command=$(echo "$line" | sed 's/^[^;]*;//;s/^[^;]*;//')

        exec "$command"
        exit 0
      }

      [[ $1 == "" ]] && ui

      if [[ $1 == "rebuild" ]];then
        sudo nixos-rebuild switch --flake ${configDirectory}#$hostname
      elif [[ $1 == "upgrade" ]];then
        sudo nixos-rebuild switch --upgrade --flake '${configDirectory}#$hostname'
      elif [[ $1 == "update" ]];then
        cd ${configDirectory} && sudo nix flake update
      elif [[ $1 == "gc" ]];then
        cd ${configDirectory} && sudo nix-collect-garbage -d
      elif [[ $1 == "cb" ]];then
        sudo /run/current-system/bin/switch-to-configuration boot
      else
        echo "Unknown argument"
      fi
    '';

in { environment.systemPackages = with pkgs; [ nixy ]; }

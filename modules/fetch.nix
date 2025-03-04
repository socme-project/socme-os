{ pkgs, ... }:
let
  generateCertsScript = pkgs.writeShellScriptBin "generate-wazuh-certs" ''
    OUTDIR=$(mktemp -d)
    cd "$OUTDIR" && ${pkgs.python3}/bin/python3.11 -m http.server &
    # Store the fastfetch conf

    while :; do
      {
        fastfetch -c ./config
      } >"$OUTDIR/index.html"
      sleep 10
    done
  '';
in {

}

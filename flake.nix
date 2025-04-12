{
  description = "autom. bud. oprogr.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.zsh
	  pkgs.oh-my-zsh
	  pkgs.git
	  pkgs.python3
	  pkgs.docker
	  pkgs.python3Packages.flask
	  pkgs.python3Packages.mock
	  pkgs.python3Packages.pytest
	  pkgs.python3Packages.flake8
        ];

        shellHook = ''
	  export DOCKER_HOST=unix:///var/run/docker.sock
	  export SHELL=${nixpkgs.legacyPackages.${system}.zsh}/bin/zsh
	  exec ${nixpkgs.legacyPackages.${system}.zsh}/bin/zsh --login
	  export PS1="[nix-env] $PS1"
	'';
      };
    };
}

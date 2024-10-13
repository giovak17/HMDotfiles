.PHONY: update
update:
	home-manager switch --flake .#giovak

.PHONY: clean
clean:
	nix-collect-garbage -d

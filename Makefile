all: brew-all sync fish post-install config

sync:
	mkdir -p ~/.config/ghostty
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/fish/functions.local
	mkdir -p ~/.config/fish/functions
	mkdir -p ~/.config/fish/fzf
	mkdir -p ~/.config/fish/conf.d
	mkdir -p ~/.tmux/
	mkdir -p ~/.gnupg/
	mkdir -p ~/.ssh
	mkdir -p ~/.ssh/sockets
	mkdir -p ~/.1password
	mkdir -p ~/.config/git
	mkdir -p ~/Developer
	mkdir -p ~/.mitmproxy/
	mkdir -p ~/.config/bat/
	mkdir -p ~/.config/opencode/
	mkdir -p ~/.claude
	mkdir -p ~/.claude/commands/bd
	mkdir -p ~/.claude/hooks
	mkdir -p ~/.gemini
	mkdir -p ~/.codex
	mkdir -p ~/Library/LaunchAgents

	[ -f ~/.config/ghostty/config ] || ln -s $(PWD)/ghostty/config ~/.config/ghostty/config
	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	ln -sf $(PWD)/fish/fish_plugins ~/.config/fish/fish_plugins
	ln -sf $(PWD)/fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish
	ln -sf $(PWD)/fish/functions/fzf_key_bindings.fish ~/.config/fish/functions/fzf_key_bindings.fish
	ln -sf $(PWD)/fish/functions/hidden.fish ~/.config/fish/functions/hidden.fish
	ln -sf $(PWD)/fish/functions/sync_theme.fish ~/.config/fish/functions/sync_theme.fish
	ln -sf $(PWD)/fish/functions/_pure_set_gruvbox.fish ~/.config/fish/functions/_pure_set_gruvbox.fish
	ln -sf $(PWD)/fish/functions/upgrade.fish ~/.config/fish/functions/upgrade.fish
	ln -sf $(PWD)/fish/functions/cdr.fish ~/.config/fish/functions/cdr.fish
	ln -sf $(PWD)/fish/functions/co.fish ~/.config/fish/functions/co.fish
	ln -sf $(PWD)/fish/functions/hb.fish ~/.config/fish/functions/hb.fish
	ln -sf $(PWD)/fish/functions/hc.fish ~/.config/fish/functions/hc.fish
	ln -sf $(PWD)/fish/functions/ghpr.fish ~/.config/fish/functions/ghpr.fish
	ln -sf $(PWD)/fish/functions/claude_sync.fish ~/.config/fish/functions/claude_sync.fish
	ln -sf $(PWD)/fish/fzf/gruvbox-dark-hard.fish ~/.config/fish/fzf/gruvbox-dark-hard.fish
	ln -sf $(PWD)/fish/fzf/gruvbox-light-hard.fish ~/.config/fish/fzf/gruvbox-light-hard.fish
	ln -sf $(PWD)/fish/conf.d/_done.fish ~/.config/fish/conf.d/_done.fish
	ln -sf $(PWD)/fish/conf.d/pure_theme.fish ~/.config/fish/conf.d/pure_theme.fish
	[ -f ~/.config/bat/config ] || ln -s $(PWD)/bat/config ~/.config/bat/config
	[ -f ~/.mitmproxy/config.yaml ] || ln -s $(PWD)/mitmproxy/config.yaml ~/.mitmproxy/config.yaml
	[ -f ~/.config/opencode/opencode.json ] || ln -s $(PWD)/opencode/opencode.json ~/.config/opencode/opencode.json
	ln -sf $(PWD)/opencode/AGENTS.md ~/.config/opencode/AGENTS.md
	ln -sf $(PWD)/claude/CLAUDE.md ~/.claude/CLAUDE.md
	[ -f ~/.claude/settings.json ] || ln -s $(PWD)/claude/settings.json ~/.claude/settings.json
	ln -sf $(PWD)/claude/statusline.sh ~/.claude/hooks/statusline.sh
	ln -sf $(PWD)/claude/subagent-start.sh ~/.claude/hooks/subagent-start.sh
	ln -sf $(PWD)/claude/commands/bd/log.md ~/.claude/commands/bd/log.md
	ln -sf $(PWD)/claude/commands/bd/checkpoint.md ~/.claude/commands/bd/checkpoint.md
	ln -sf $(PWD)/claude/npx-packages.txt ~/.claude/npx-packages.txt
	ln -sf $(PWD)/claude/marketplaces.txt ~/.claude/marketplaces.txt
	ln -sf $(PWD)/claude/plugins.txt ~/.claude/plugins.txt
	[ -f ~/.gemini/settings.json ] || ln -s $(PWD)/gemini/settings.json ~/.gemini/settings.json
	ln -sf $(PWD)/gemini/gruvbox-dark.json ~/.gemini/gruvbox-dark.json
	ln -sf $(PWD)/gemini/gruvbox-light.json ~/.gemini/gruvbox-light.json
	[ -f ~/.codex/config.toml ] || ln -s $(PWD)/codex/config.toml ~/.codex/config.toml
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	[ -f ~/.tmux/tmuxline-dark.conf ] || ln -s $(PWD)/tmux/tmuxline-dark.conf ~/.tmux/tmuxline-dark.conf
	[ -f ~/.tmux/tmuxline-light.conf ] || ln -s $(PWD)/tmux/tmuxline-light.conf ~/.tmux/tmuxline-light.conf
	[ -f ~/.gnupg/gpg.conf ] || ln -s $(PWD)/gnupg/gpg.conf ~/.gnupg/gpg.conf
	[ -f ~/.gnupg/gpg-agent.conf ] || ln -s $(PWD)/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/.tigrc ~/.tigrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/.gitconfig ~/.gitconfig
	[ -f ~/.gitconfig-github ] || ln -s $(PWD)/.gitconfig-github ~/.gitconfig-github
	[ -f ~/.gitignore ] || ln -s $(PWD)/gitignore ~/.gitignore
	[ -f ~/.ssh/config ] || ln -s $(PWD)/ssh/config ~/.ssh/config
	[ -f ~/.ssh/config.local ] || touch ~/.ssh/config.local
	[ -S ~/.1password/agent.sock ] || ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
	ln -sfn $(PWD)/git/hooks ~/.config/git/hooks
	[ -f ~/.dockerignore ] || ln -s $(PWD)/.dockerignore ~/.dockerignore
	[ -f ~/.ignore ] || ln -s $(PWD)/.ignore ~/.ignore
	[ -f ~/.gitconfig.local ] || touch ~/.gitconfig.local
	[ -f ~/.config/git/allowed_signers ] || touch ~/.config/git/allowed_signers
	[ -f ~/.config/fish/local.fish ] || touch ~/.config/fish/local.fish
	[ -f ~/.config/opencode/opencode.local.json ] || echo '{}' > ~/.config/opencode/opencode.local.json
	[ -f ~/.hushlogin ] || ln -s $(PWD)/.hushlogin ~/.hushlogin
	[ -f ~/.psqlrc ] || ln -s $(PWD)/.psqlrc ~/.psqlrc
	[ -f ~/.psqlrc.local ] || touch ~/.psqlrc.local
	[ -f ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist ] || ln -s $(PWD)/dark-notify.plist ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist
	-launchctl load ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist 2>/dev/null

	gpgconf --kill dirmngr
	chown -R $$USER ~/.gnupg/
	find ~/.gnupg -type f -exec chmod 600 {} \;
	find ~/.gnupg -type d -exec chmod 700 {} \;

brew:
	brew bundle --verbose

brew-personal:
	brew bundle --file=Brewfile.personal --verbose

brew-all: brew brew-personal

fish:
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"
	@grep -q /opt/homebrew/bin/fish /etc/shells || (echo "Adding fish to /etc/shells (requires sudo)..." && echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells)
	@[ "$$SHELL" = "/opt/homebrew/bin/fish" ] && echo "Fish is already the default shell" || chsh -s /opt/homebrew/bin/fish

vim-plugins:
	[ -f ~/.vim/autoload/plug.vim ] || curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall

tmux-plugins:
	[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

docker-completions:
	mkdir -p ~/.config/fish/completions
	@[ -f /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion ] && \
		ln -sf /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion ~/.config/fish/completions/docker.fish && \
		ln -sf /Applications/Docker.app/Contents/Resources/etc/docker-compose.fish-completion ~/.config/fish/completions/docker-compose.fish && \
		echo "Docker completions installed" || echo "Docker.app not found, skipping completions"

npm-global:
	@echo "Installing global npm packages..."
	@grep -v '^#' $(PWD)/npm-global-packages.txt 2>/dev/null | grep -v '^$$' | while read -r pkg; do \
		npm list -g "$$pkg" >/dev/null 2>&1 || npm install -g "$$pkg"; \
	done

claude-npx:
	@grep -v '^#' ~/.claude/npx-packages.txt 2>/dev/null | grep -v '^$$' | while read -r cmd; do \
		eval npx $$cmd; \
	done

claude-plugins:
	@echo "Adding marketplaces..."
	@installed=$$(claude plugin marketplace list --json 2>/dev/null | jq -r '.[].repo'); \
	grep -v '^#' ~/.claude/marketplaces.txt 2>/dev/null | grep -v '^$$' | while read -r repo; do \
		if ! echo "$$installed" | grep -qx "$$repo"; then \
			claude plugin marketplace add "$$repo" 2>&1 || true; \
		fi; \
	done
	@echo "Updating marketplaces..."
	@claude plugin marketplace update
	@echo "Installing plugins..."
	@grep -v '^#' ~/.claude/plugins.txt 2>/dev/null | grep -v '^$$' | while read -r plugin; do \
		claude plugin install "$$plugin" 2>&1 || true; \
	done

claude-plugins-prune: claude-plugins
	@echo "Pruning unlisted marketplaces..."
	@desired=$$(grep -v '^#' ~/.claude/marketplaces.txt 2>/dev/null | grep -v '^$$'); \
	claude plugin marketplace list --json 2>/dev/null | jq -r '.[] | "\(.name)|\(.repo)"' | while read -r entry; do \
		mp_name=$$(echo "$$entry" | cut -d'|' -f1); \
		mp_repo=$$(echo "$$entry" | cut -d'|' -f2); \
		if ! echo "$$desired" | grep -qx "$$mp_repo"; then \
			echo "Removing marketplace: $$mp_name"; \
			claude plugin marketplace remove "$$mp_name" 2>&1 || true; \
		fi; \
	done
	@echo "Pruning unlisted plugins (user scope)..."
	@desired=$$(grep -v '^#' ~/.claude/plugins.txt 2>/dev/null | grep -v '^$$' | sed 's/@.*//'); \
	npx_pkgs=$$(grep -v '^#' ~/.claude/npx-packages.txt 2>/dev/null | grep -v '^$$' | sed 's/@.*//' | sed 's/-cc$$//'); \
	claude plugin list --json 2>/dev/null | jq -r '.[] | select(.scope == "user") | .id' | sort -u | while read -r id; do \
		name=$$(echo "$$id" | sed 's/@.*//'); \
		if ! echo "$$desired" | grep -qx "$$name"; then \
			if echo "$$npx_pkgs" | grep -qx "$$name"; then \
				echo "Skipping npx plugin: $$name"; \
			else \
				echo "Removing plugin: $$name"; \
				claude plugin uninstall "$$name" --scope user 2>&1 || true; \
			fi; \
		fi; \
	done

post-install: tmux-plugins vim-plugins docker-completions npm-global claude-npx claude-plugins

config:
	./macos

clean:
	-launchctl unload ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist 2>/dev/null
	rm -f ~/Library/LaunchAgents/com.joaodrp.dark-notify.plist
	rm -f ~/.vimrc
	rm -f ~/.config/ghostty/config
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/fish_plugins
	rm -f ~/.config/fish/functions/fish_user_key_bindings.fish
	rm -f ~/.config/fish/functions/fzf_key_bindings.fish
	rm -f ~/.config/fish/functions/hidden.fish
	rm -f ~/.config/fish/functions/sync_theme.fish
	rm -f ~/.config/fish/functions/_pure_set_gruvbox.fish
	rm -f ~/.config/fish/functions/upgrade.fish
	rm -f ~/.config/fish/functions/cdr.fish
	rm -f ~/.config/fish/functions/co.fish
	rm -f ~/.config/fish/functions/hb.fish
	rm -f ~/.config/fish/functions/hc.fish
	rm -f ~/.config/fish/functions/ghpr.fish
	rm -f ~/.config/fish/functions/claude_sync.fish
	rm -f ~/.config/fish/fzf/gruvbox-dark-hard.fish
	rm -f ~/.config/fish/fzf/gruvbox-light-hard.fish
	rm -f ~/.config/fish/conf.d/_done.fish
	rm -f ~/.config/fish/conf.d/pure_theme.fish
	rm -f ~/.tmux.conf
	rm -f ~/.tmux/tmuxline-dark.conf
	rm -f ~/.tmux/tmuxline-light.conf
	rm -f ~/.gnupg/gpg.conf
	rm -f ~/.gnupg/gpg-agent.conf
	rm -f ~/.tigrc
	rm -f ~/.gitconfig
	rm -f ~/.gitconfig-github
	rm -f ~/.gitignore
	rm -rf ~/.config/git/hooks
	rm -f ~/.ssh/config
	rm -f ~/.1password/agent.sock
	rm -f ~/.dockerignore
	rm -f ~/.ignore
	rm -f ~/.hushlogin
	rm -f ~/.psqlrc
	rm -f ~/.config/bat/config
	rm -f ~/.mitmproxy/config.yaml
	rm -f ~/.config/opencode/opencode.json
	rm -f ~/.config/opencode/AGENTS.md
	rm -f ~/.claude/CLAUDE.md
	rm -f ~/.claude/settings.json
	rm -f ~/.claude/hooks/statusline.sh
	rm -f ~/.claude/hooks/subagent-start.sh
	rm -rf ~/.claude/commands/bd
	rm -f ~/.claude/npx-packages.txt
	rm -f ~/.claude/marketplaces.txt
	rm -f ~/.claude/plugins.txt
	rm -f ~/.gemini/settings.json
	rm -f ~/.gemini/gruvbox-dark.json
	rm -f ~/.gemini/gruvbox-light.json
	rm -f ~/.codex/config.toml

.PHONY: all sync brew brew-personal brew-all fish vim-plugins tmux-plugins docker-completions npm-global claude-npx claude-plugins claude-plugins-prune post-install config clean

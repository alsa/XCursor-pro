theme := XCursor-Pro-Light-alsa
theme_lower := xcursor-pro-light-alsa
install_path := $(HOME)/.icons
venv_name := .venv

all: clean render build uninstall install

clean:
	rm -rf "./themes/$(theme)"
	rm -rf "./bin/$(theme)"

clean-deps:
	rm -rf "./$(venv_name)"
	rm -rf "./node_modules"

clean-all: clean clean-deps

install-deps: 
	npm install cbmp
	python3 -m venv $(venv_name)
	$(venv_name)/bin/pip install clickgen attrs

render:
	yarn render:$(theme_lower)

build: clean
	. $(venv_name)/bin/activate && \
		yarn build:$(theme_lower)

install:
	mkdir -p "$(install_path)"
	mv "./themes/$(theme)" "$(install_path)/$(theme)"
	cp "./bitmaps/$(theme)/xterm.png" "$(install_path)/$(theme)/cursors/thumbnail.png"

uninstall:
	rm -rf "$(install_path)/$(theme)"

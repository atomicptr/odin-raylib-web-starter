PACKAGE := "game"

STACK_SIZE := 1048576
HEAP_SIZE := 67108864

build-web:
	mkdir -p out/web
	mkdir -p out/.intermediate
	odin build web -target=freestanding_wasm32 -out:"out/.intermediate/$(PACKAGE)" -build-mode:obj -debug -show-system-calls
	emcc -o out/web/index.html web/main.c out/.intermediate/$(PACKAGE).wasm.o web/raylib/libraylib.a -sUSE_GLFW=3 -sGL_ENABLE_GET_PROC_ADDRESS -DWEB_BUILD -sSTACK_SIZE=$(STACK_SIZE) -sTOTAL_MEMORY=$(HEAP_SIZE) -sERROR_ON_UNDEFINED_SYMBOLS=0 --shell-file web/shell.html

run:
	odin run $(PACKAGE) -debug

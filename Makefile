# override this by using WASI_SDK_PATH=foo make
export WASI_SDK_PATH?=$(HOME)/Build/wasi-sdk/build/install/opt

build:
	$(WASI_SDK_PATH)/bin/clang \
		--sysroot=$(WASI_SDK_PATH)/share/wasi-sysroot \
		--target=wasm32-wasi \
		-Wall \
		-Wextra \
		-Wno-sign-compare \
		-Wno-missing-field-initializers \
		-Wundef \
		-Wuninitialized \
		-Wunused \
		-Wno-unused-parameter \
		-Wwrite-strings \
		-Wchar-subscripts \
		-funsigned-char \
		-DNDEBUG \
		-D_HAVE_SQLITE_CONFIG_H \
		-DSQLITE_OS_UNIX \
		-DSQLITE_TEMP_STORE=0 \
		-DSQLITE_OMIT_LOAD_EXTENSION \
		-DSQLITE_OMIT_DECLTYPE \
		-DSQLITE_OMIT_POPEN \
		-D_WASI_EMULATED_SIGNAL \
		-D_WASI_EMULATED_MMAN \
		-D_WASI_EMULATED_PROCESS_CLOCKS \
		-lwasi-emulated-mman \
		-lwasi-emulated-getpid \
		-lwasi-emulated-signal \
		-lwasi-emulated-process-clocks \
		*.c \
		-o sqlite3.wasm
	# use curl to get it onto a-Shell
	python3 -m http.server 8001
	

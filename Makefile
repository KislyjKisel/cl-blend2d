LISP ?= sbcl
SYSNAME = cl-blend2d

ENV = LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):./blend2d/build/

LISP_START = $(LISP) \
	--noinform --lose-on-corruption --end-runtime-options \
	--eval '(asdf:load-asd (merge-pathnames "$(SYSNAME).asd" (uiop:getcwd)))' \
	--eval '(asdf:load-system :$(SYSNAME))'

.PHONY: repl repl_ alive-lsp build-lib

repl:
	$(ENV) rlwrap $(LISP_START)

repl_:
	$(ENV) $(LISP_START)

alive-lsp:
	$(ENV) $(LISP_START) \
		--eval '(setf *print-circle* t)' \
		--eval '(ql:quickload "bordeaux-threads")' \
		--eval '(ql:quickload "usocket")' \
		--eval '(ql:quickload "cl-json")' \
		--eval '(ql:quickload "flexi-streams")' \
		--eval '(asdf:load-system :alive-lsp)' \
		--eval '(alive/server:start)'

build-lib:
	cmake -S blend2d -B blend2d/build -DCMAKE_BUILD_TYPE=Release -DBLEND2D_NO_INSTALL=YES -DBLEND2D_NO_STDCXX=YES
	cmake --build blend2d/build

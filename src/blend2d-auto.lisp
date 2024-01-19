(in-package #:%blend2d)

(cffi:define-foreign-library blend2d
    (:darwin (:or "libblend2d.dylib" "libblend2d"))
    (:unix (:or "libblend2d.so" "libblend2d" "blend2d"))
    (t (:default "libblend2d")))
(cffi:use-foreign-library blend2d)

(autowrap:c-include
    '(cl-blend2d c-src "blend2d.h")
    :spec-path '(cl-blend2d autowrap-spec)
    :exclude-sources ("/usr/include/" "/usr/lib64/clang/[^/]*/include/.*")
    :include-sources ("stdint.h" "bits/types.h" "sys/types.h" "bits/stdint" "machine/_types.h" "stddef.h")
    :symbol-regex (("^BL_(.*)" () "\\1")
                   ("^BL(.*)" () "\\1")
                   ("^bl(.*)" () "\\1"))
    :symbol-exceptions (("BLRandom" . "bl-random"))
    :include-definitions ()
    :exclude-definitions ("blRuntimeMessageVFmt"
                          "blStringApplyOpFormatV"
                          "^_[A-Z]"))

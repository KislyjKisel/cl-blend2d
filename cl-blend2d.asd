(asdf:defsystem #:cl-blend2d
    :depends-on (#:cl-autowrap/libffi)
    :serial t
    :components ((:module c-src
                  :pathname "blend2d/src"
                  :components ((:static-file "blend2d.h")))
                 (:module autowrap-spec
                  :pathname "spec"
                  :components ((:static-file "blend2d.x86_64-pc-linux-gnu.spec")))
                 (:module src
                  :pathname "src"
                  :components ((:file "package")
                               (:file "blend2d-auto")
                               (:file "blend2d")))))

(use-modules
  (guix profiles)
  (guix packages)
  (guix download)
  (guix git-download)
  (guix build-system haskell)
  (guix build-system texlive)
  (guix build-system gnu)
  (guix build-system node)
  (guix gexp)
  ((guix licenses) #:prefix license:)
  (gnu packages haskell)
  (gnu packages haskell-web)
  (gnu packages haskell-xyz)
  (gnu packages haskell-check)
  (gnu packages agda)
  (gnu packages tex)
  (gnu packages gcc)
  (gnu packages linux)
  (gnu packages version-control)
  (gnu packages web)
  (gnu packages pdf)
  (gnu packages perl)
  (gnu packages python))

(define ghc-agda-fold-equations
  (package
    (name "ghc-agda-fold-equations")
    (version "0.1.0.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://git.amelia.how/amelia/agda-fold-equations.git")
               (commit "509bc021200b0de7713a0fdb27c730eaff3be206")))
        (file-name (git-file-name name version))
        (sha256 (base32 "0vvh59l3sipabvk44ry9509i27zwkzldw94085sn66cdspi95m6a"))))
    (build-system haskell-build-system)
    (inputs (list ghc-tagsoup))
    (home-page "https://git.amelia.how/amelia/agda-fold-equations/")
    (synopsis "")
    (description "")
    (license license:bsd-3)))
(define ghc-agda-reference-filter
  (package
    (name "ghc-agda-reference-filter")
    (version "0.1.0.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://git.amelia.how/amelia/agda-reference-filter.git")
               (commit "082b5576e799fe8aa28e7d09cf415ac6c9e0596b")))
        (file-name (git-file-name name version))
        (sha256 (base32 "1311qhdkqqismgi4ykjwxw08808p930nyjrnncqyajzvnb8775vk"))))
    (build-system haskell-build-system)
    (inputs (list
              ghc-tagsoup
              ghc-pandoc-types
              ghc-unordered-containers))
    (home-page "https://git.amelia.how/amelia/agda-reference-filter/")
    (synopsis "A Pandoc filter for linking Agda identifiers in inline code blocks.")
    (description "")
    (license license:bsd-3)))

(define ghc-js-dgtable
  (package
    (name "ghc-js-dgtable")
    (version "0.5.2")
    (source
      (origin
        (method url-fetch)
        (uri (hackage-uri "js-dgtable" version))
        (sha256
          (base32 "1b10kx703kbkb5q1ggdpqcrxqjb33kh24khk21rb30w0xrdxd3g2"))))
    (build-system haskell-build-system)
    (home-page "https://github.com/ndmitchell/js-dgtable#readme")
    (synopsis "Obtain minified jquery.dgtable code")
    (description
      "This package bundles the minified <https://github.com/danielgindi/jquery.dgtable
jquery.dgtable> code into a Haskell package, so it can be depended upon by Cabal
packages.  The first three components of the version number match the upstream
jquery.dgtable version.  The package is designed to meet the redistribution
requirements of downstream users (e.g.  Debian).")
    (license license:expat)))

(define ghc-heaps
  (package
    (name "ghc-heaps")
    (version "0.4")
    (source
      (origin
        (method url-fetch)
        (uri (hackage-uri "heaps" version))
        (sha256
          (base32 "1zbw0qrlnhb42v04phzwmizbpwg21wnpl7p4fbr9xsasp7w9scl9"))))
    (build-system haskell-build-system)
    (home-page "http://github.com/ekmett/heaps/")
    (synopsis "Asymptotically optimal Brodal/Okasaki heaps.")
    (description
      "Asymptotically optimal Brodal\\/Okasaki bootstrapped skew-binomial heaps from the
paper <http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.48.973 \"Optimal
Purely Functional Priority Queues\">, extended with a 'Foldable' interface.")
    (license license:bsd-3)))

(define ghc-shake
  (package
    (name "ghc-shake")
    (version "0.19.6")
    (source
      (origin
        (method url-fetch)
        (uri (hackage-uri "shake" version))
        (sha256
          (base32 "0hnm3h1ni4jq73a7b7yxhbg9wm8mrjda5kmkpnmclynnpwvvi7bx"))))
    (build-system haskell-build-system)
    (arguments '(#:tests? #f))
    (inputs
      (list ghc-extra
            ghc-filepattern
            ghc-hashable
            ghc-heaps
            ghc-js-dgtable
            ghc-js-flot
            ghc-js-jquery
            ghc-primitive
            ghc-random
            ghc-unordered-containers
            ghc-utf8-string))
    (native-inputs (list ghc-quickcheck))
    (home-page "https://shakebuild.com")
    (synopsis
      "Build system library, like Make, but more accurate dependencies.")
    (description
      "Shake is a Haskell library for writing build systems - designed as a replacement
for @make@.  See \"Development.Shake\" for an introduction, including an example.
The homepage contains links to a user manual, an academic paper and further
information: <https://shakebuild.com> .  To use Shake the user writes a Haskell
program that imports \"Development.Shake\", defines some build rules, and calls
the 'Development.Shake.shakeArgs' function.  Thanks to do notation and infix
operators, a simple Shake build system is not too dissimilar from a simple
Makefile.  However, as build systems get more complex, Shake is able to take
advantage of the excellent abstraction facilities offered by Haskell and easily
support much larger projects.  The Shake library provides all the standard
features available in other build systems, including automatic parallelism and
minimal rebuilds.  Shake also provides more accurate dependency tracking,
including seamless support for generated files, and dependencies on system
information (e.g.  compiler version).")
    (license license:bsd-3)))

(define texlive-latex-tikz-cd
  (package
    (name "texlive-latex-tikz-cd")
    (version (number->string %texlive-revision))
    (source (texlive-origin name version
                            (list "doc/latex/tikz-cd/" "tex/generic/tikz-cd/" "tex/latex/tikz-cd/")
                            (base32 "0yihh47a85khxmxl95hlsfma8n33yj95hsccsaq41zrap72psv37")))
    (outputs '("out" "doc"))
    (build-system gnu-build-system)
    (arguments
      `(#:tests? #f
        #:phases
        (modify-phases %standard-phases
          (delete 'configure)
          (replace 'build (const #t))
          (replace 'install
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (let ((doc (string-append (assoc-ref outputs "doc")
                                        "/share/texmf-dist/"))
                    (out (string-append (assoc-ref outputs "out")
                                        "/share/texmf-dist/")))
                (mkdir-p doc)
                (copy-recursively
                  (string-append (assoc-ref inputs "source") "/doc")
                  (string-append doc "/doc"))
                (mkdir-p out)
                (copy-recursively "." out)
                (delete-file-recursively (string-append out "/doc"))
                #t))))))
    (home-page "https://ctan.org/graphics/pgf/contrib/tikz-cd")
    (synopsis "Create commutative diagrams with TikZ")
    (description
      "The general-purpose drawing package TiKZ can be used to typeset commutative
diagrams and other kinds of mathematical pictures, generating high-quality
results.  The purpose of this package is to make the process of creation of such
diagrams easier by providing a convenient set of macros and reasonable default
settings.  This package also includes an arrow tip library that match closely
the arrows present in the Computer Modern typeface.")
    (license license:gpl3)))

(define node-commander
  (package
    (name "node-commander")
    (version "8.3.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/tj/commander.js")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1fwvjcmhj9vqav6s26bvxq7zbzd1v2gjc1n5j2wf4lbz1qqvy138"))))
    (build-system node-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("@types/jest"
                                        "@types/node"
                                        "@typescript-eslint/eslint-plugin"
                                        "@typescript-eslint/parser"
                                        "eslint"
                                        "eslint-config-standard"
                                        "eslint-plugin-jest"
                                        "jest"
                                        "standard"
                                        "ts-jest"
                                        "tsd"
                                        "typescript")))))
        #:tests? #f))
    (home-page "https://github.com/tj/commander.js#readme")
    (synopsis "node.js command-line interfaces made easy")
    (description "The complete solution for node.js command-line interfaces.")
    (license license:expat)))
(define node-graceful-fs
  (package
    (name "node-graceful-fs")
    (version "4.2.9")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/isaacs/node-graceful-fs")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "00fp6wqbdk5nkggcpl3jrrj7jqwqbyzckr2gil7q4an117rby698"))))
    (build-system node-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("import-fresh"
                                        "mkdirp"
                                        "rimraf"
                                        "tap")))))
        #:tests? #f))
    (home-page "https://github.com/isaacs/node-graceful-fs#readme")
    (synopsis "fs with incremental backoff on EMFILE")
    (description #f)
    (license license:isc)))
(define node-universalify
  (package
    (name "node-universalify")
    (version "2.0.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/RyanZim/universalify")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32 "15hffdahyb7hgrdlhrk9l382pf33wys3k6ddldvhq5aqphnlra6f"))))
    (build-system node-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("colortape"
                                        "coveralls"
                                        "nyc"
                                        "standard"
                                        "tape")))))
        #:tests? #f))
    (home-page "https://github.com/RyanZim/universalify")
    (synopsis "Make a callback- or promise-based function support both promises and callbacks.")
    (description #f)
    (license license:expat)))
(define node-jsonfile
  (package
    (name "node-jsonfile")
    (version "6.0.1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/jprichardson/node-jsonfile")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1zff9ihhd05p0dg0zla5mq4q72xzwj0341dll1hb5gh1sy0z71mh"))))
    (build-system node-build-system)
    (inputs (list node-universalify))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("mocha"
                                        "rimraf"
                                        "standard")))))
        #:tests? #f))
    (home-page "https://github.com/jprichardson/node-jsonfile")
    (synopsis "Easily read/write JSON files.")
    (description #f)
    (license license:expat)))
(define node-fs-extra
  (package
    (name "node-fs-extra")
    (version "10.0.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/jprichardson/node-fs-extra")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0amr6xx795rl926p60sflpr9gg2nrzganbrv5gs0pcvg0fa1q3mv"))))
    (build-system node-build-system)
    (inputs (list
              node-graceful-fs
              node-jsonfile
              node-universalify))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("at-least-node"
                                        "coveralls"
                                        "klaw"
                                        "klaw-sync"
                                        "minimist"
                                        "mocha"
                                        "nyc"
                                        "proxyquire"
                                        "read-dir-files"
                                        "standard")))))
        #:tests? #f))
    (home-page "https://github.com/jprichardson/node-fs-extra#readme")
    (synopsis "extra methods for the fs object like copy(), remove(), mkdirs()")
    (description #f)
    (license license:expat)))
(define node-fs.realpath
  (package
    (name "node-fs.realpath")
    (version "1.0.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/isaacs/fs.realpath")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1paqz15kz14ghq9mx8klngi7yqpmh9l4i7sr808jnkivqkpkn5k5"))))
    (build-system node-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("import-fresh"
                                        "mkdirp"
                                        "rimraf"
                                        "tap")))))
        #:tests? #f))
    (home-page "https://github.com/isaacs/fs.realpath#readme")
    (synopsis "Use node's fs.realpath, but fall back to the JS implementation if the native one fails")
    (description #f)
    (license license:isc)))
(define node-wrappy
  (package
    (name "node-wrappy")
    (version "1.0.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/npm/wrappy")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1ymlc61cja6v5438vwb04gq8wg2b784lj39zf0g4i36fvgcw9783"))))
    (build-system node-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("tap")))))
        #:tests? #f))
    (home-page "https://github.com/npm/wrappy#readme")
    (synopsis "Callback wrapping utility")
    (description #f)
    (license license:isc)))
(define node-once
  (package
    (name "node-once")
    (version "1.3.3")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/isaacs/once")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1n3kr5fmxw3k6gv7phvsff08qc12c38vyy4n46d91vyrm673k5i1"))))
    (build-system node-build-system)
    (inputs (list node-wrappy))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("tap")))))
        #:tests? #f))
    (home-page "https://github.com/isaacs/once#readme")
    (synopsis "Run a function exactly one time")
    (description #f)
    (license license:isc)))
(define node-inflight
  (package
    (name "node-inflight")
    (version "1.0.6")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/npm/inflight")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0jm60cik7yiblhwj7q14ndawrx9n91q7mww6ay3qpahzp8iljlc0"))))
    (build-system node-build-system)
    (inputs (list
              node-once
              node-wrappy))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("tap")))))
        #:tests? #f))
    (home-page "https://github.com/npm/inflight#readme")
    (synopsis "Add callbacks to requests in flight to avoid async duplication")
    (description #f)
    (license license:isc)))
(define node-inherits
  (package
    (name "node-inherits")
    (version "2.0.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/isaacs/inherits")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0cpsr5yqwkxpbbbbl0rwk4mcby6zbx841k2zb4c3gb1579i5wq9p"))))
    (build-system node-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("tap")))))
        #:tests? #f))
    (home-page "https://github.com/isaacs/inherits#readme")
    (synopsis "Browser-friendly inheritance fully compatible with standard node.js inherits()")
    (description #f)
    (license license:isc)))
(define node-balanced-match
  (package
    (name "node-balanced-match")
    (version "1.0.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/juliangruber/balanced-match")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0977r6hv9fyv6f8wvn31vcncxwhffnn05y0h4hmpkg8p2vs9ip0b"))))
    (build-system node-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("matcha"
                                        "tape")))))
        #:tests? #f))
    (home-page "https://github.com/juliangruber/balanced-match#readme")
    (synopsis "Match balanced character pairs, like \"{\" and \"}\"")
    (description #f)
    (license license:expat)))
(define node-concat-map
  (package
    (name "node-concat-map")
    (version "0.0.1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/substack/node-concat-map")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32 "0l30hn1w9incwahjbvv3kzw6p150vjiiji6dlxxawd3krfn7z3k5"))))
    (build-system node-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("tape")))))
        #:tests? #f))
    (home-page "https://github.com/substack/node-concat-map#readme")
    (synopsis "concatenative mapdashery")
    (description #f)
    (license license:expat)))
(define node-brace-expansion
  (package
    (name "node-brace-expansion")
    (version "1.1.11")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/juliangruber/brace-expansion")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32 "117k5p167k4sz739rr83cjhf7bsq0iidvm8ylvnybbj86varv9q1"))))
    (build-system node-build-system)
    (inputs (list
              node-balanced-match
              node-concat-map))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("matcha"
                                        "tape")))))
        #:tests? #f))
    (home-page "https://github.com/juliangruber/brace-expansion#readme")
    (synopsis "Brace expansion as known from sh/bash")
    (description #f)
    (license license:expat)))
(define node-minimatch
  (package
    (name "node-minimatch")
    (version "3.0.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/isaacs/minimatch")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1ik49n52siwfzmnh5mg4mm91k9gl6b4whsjyrawj0sqcmi790fxs"))))
    (build-system node-build-system)
    (inputs (list node-brace-expansion))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("tap")))))
        #:tests? #f))
    (home-page "https://github.com/isaacs/minimatch#readme")
    (synopsis "a glob matcher in javascript")
    (description #f)
    (license license:isc)))
(define node-path-is-absolute
  (package
    (name "node-path-is-absolute")
    (version "1.0.1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/sindresorhus/path-is-absolute")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1bbpsdwjqbmfjivfsrcxpkpbkki15bsvxdbk6q50q0g7c9y3kmk3"))))
    (build-system node-build-system)
    (inputs (list node-brace-expansion))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("xo")))))
        #:tests? #f))
    (home-page "https://github.com/sindresorhus/path-is-absolute#readme")
    (synopsis "Node.js 0.12 path.isAbsolute() ponyfill")
    (description #f)
    (license license:expat)))
(define node-glob
  (package
    (name "node-glob")
    (version "7.1.7")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/isaacs/node-glob")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1mncs6f34p9rabva8rfi7905z14ajzv03y89i03xc7prrzrlgy3z"))))
    (build-system node-build-system)
    (inputs (list
              node-fs.realpath
              node-inflight
              node-inherits
              node-minimatch
              node-once
              node-path-is-absolute))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("mkdirp"
                                        "rimraf"
                                        "tap"
                                        "tick")))))
        #:tests? #f))
    (home-page "https://github.com/isaacs/node-glob#readme")
    (synopsis "glob functionality for node.js")
    (description #f)
    (license license:isc)))
(define node-rimraf
  (package
    (name "node-rimraf")
    (version "3.0.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/isaacs/rimraf")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1j0wmwwrzqv5k5lsm1dfdik0f5ilprpwrb3i609x8qcm2k8as572"))))
    (build-system node-build-system)
    (inputs (list node-glob))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("mkdirp"
                                        "tap")))))
        #:tests? #f))
    (home-page "https://github.com/isaacs/rimraf#readme")
    (synopsis "A `rm -rf` util for nodejs")
    (description #f)
    (license license:isc)))
(define node-mkdirp
  (package
    (name "node-mkdirp")
    (version "1.0.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/isaacs/node-mkdirp")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1c9zmgnhldrrwim644qjlrfw4hcdvb6b2bawyhqh649gxpnkzb5m"))))
    (build-system node-build-system)
    (inputs (list node-glob))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("require-inject"
                                        "tap")))))
        #:tests? #f))
    (home-page "https://github.com/isaacs/node-mkdirp#readme")
    (synopsis "Recursively mkdir, like `mkdir -p`")
    (description #f)
    (license license:expat)))
(define node-sri-toolbox
  (package
    (name "node-sri-toolbox")
    (version "0.2.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/neftaly/npm-sri-toolbox")
               (commit "aaa89ac18127d0119f6e2bff86cf9e49099f9049")))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1anl950zbba04g0ak89xf9lkdcvk3x1i7z6a4izvnv1nq41hv7rz"))))
    (build-system node-build-system)
    (inputs (list node-glob))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("coveralls"
                                        "istanbul"
                                        "mocha")))))
        #:tests? #f))
    (home-page "https://github.com/neftaly/npm-sri-toolbox#readme")
    (synopsis "Subresource Integrity tools")
    (description #f)
    (license license:expat)))
(define node-rollup ; TODO
  (package
    (name "node-rollup")
    (version "2.21.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/rollup/rollup")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1anl950zbba04g0ak89xf9lkdcvk3x1i7z6a4izvnv1nq41hv7rz"))))
    (build-system node-build-system)
    (inputs (list node-glob))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("coveralls"
                                        "istanbul"
                                        "mocha")))))
        #:tests? #f))
    (home-page "https://github.com/rollup/rollup#readme")
    (synopsis "Next-generation ES module bundler")
    (description #f)
    (license license:expat)))
(define node-katex
  (package
    (name "node-katex")
    (version "0.15.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/KaTeX/KaTeX.git")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32 "1bd4nhn4rx6zpx5d8p8aigm4cj59pipk0p4jbc1033inxpgdh2i6"))))
    (build-system node-build-system)
    (native-inputs (list
                     perl
                     python
                     node-fs-extra
                     node-rimraf
                     node-mkdirp
                     node-sri-toolbox))
    (inputs (list
              node-commander))
    (arguments
      `(#:phases
        (modify-phases %standard-phases
                       (add-after 'patch-dependencies 'delete-dependencies
                                  (lambda args
                                    (delete-dependencies
                                      '("@babel/core"
                                        "@babel/eslint-parser"
                                        "@babel/plugin-proposal-class-properties"
                                        "@babel/plugin-syntax-flow"
                                        "@babel/plugin-transform-react-jsx"
                                        "@babel/plugin-transform-runtime"
                                        "@babel/preset-env"
                                        "@babel/preset-flow"
                                        "@babel/preset-react"
                                        "@babel/register"
                                        "@babel/runtime"
                                        "@rollup/plugin-alias"
                                        "@rollup/plugin-babel"
                                        "@semantic-release/changelog"
                                        "@semantic-release/git"
                                        "babel-jest"
                                        "babel-loader"
                                        "babel-plugin-istanbul"
                                        "babel-plugin-preval"
                                        "babel-plugin-version-inline"
                                        "benchmark"
                                        "browserslist"
                                        "browserstack-local"
                                        "caniuse-lite"
                                        "css-loader"
                                        "cssnano"
                                        "eslint"
                                        "eslint-import-resolver-webpack"
                                        "eslint-plugin-actions"
                                        "eslint-plugin-flowtype"
                                        "eslint-plugin-import"
                                        "eslint-plugin-react"
                                        "flow-bin"
                                        "got"
                                        "husky"
                                        "istanbul-lib-coverage"
                                        "istanbul-lib-report"
                                        "istanbul-reports"
                                        "jest"
                                        "jest-diff"
                                        "jest-matcher-utils"
                                        "jest-message-util"
                                        "jest-serializer-html"
                                        "js-yaml"
                                        "json-stable-stringify"
                                        "jspngopt"
                                        "less"
                                        "less-loader"
                                        "mini-css-extract-plugin"
                                        "p-retry"
                                        "pako"
                                        "postcss"
                                        "postcss-less"
                                        "postcss-loader"
                                        "postcss-preset-env"
                                        "prettier"
                                        "query-string"
                                        "selenium-webdriver"
                                        "semantic-release"
                                        "style-loader"
                                        "stylelint"
                                        "stylelint-config-standard"
                                        "terser-webpack-plugin"
                                        "webpack"
                                        "webpack-bundle-analyzer"
                                        "webpack-cli"
                                        "webpack-dev-server")))))
        #:tests? #f))
    (home-page "https://katex.org")
    (synopsis "Fast math typesetting for the web.")
    (description
      "KaTeX is a fast, easy-to-use JavaScript library for TeX math rendering on the web.")
    (license license:expat)))

(define shakefile
  (package
    (name "1lab-shake")
    (version "0")
    (source (local-file "Shakefile.hs"))
    (build-system gnu-build-system)
    (arguments
      `(#:tests? #f
        #:phases
        (modify-phases %standard-phases
          (delete 'configure)
          (replace 'build
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (apply invoke `(
                "ghc" "Shakefile.hs"
                "-fPIC"
                "-dynamic"
                ,(string-append "-optl=-Wl,-rpath="
                                (assoc-ref outputs "out")
                                "/lib/$compiler/$pkg-$version")
                ))))
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (mkdir-p (string-append (assoc-ref outputs "out")
                                      "/bin"))
              (copy-file
                "Shakefile"
                (string-append (assoc-ref outputs "out")
                                      "/bin/1lab-shake")))))))
    (inputs (list
              ghc
              ghc-shake
              ghc-tagsoup
							ghc-pandoc
              agda))
    (home-page #f)
    (synopsis #f)
    (description #f)
    (license license:bsd-3)))

(packages->manifest
  (list
    ghc gcc coreutils linux-libre-headers binutils findutils
    ghc-agda-fold-equations
    ghc-agda-reference-filter
    ghc-shake
    ghc-tagsoup
    ghc-uri-encode
    ghc-aeson
    agda
    texlive
    texlive-xcolor
    texlive-latex-preview
    texlive-latex-pgf
    texlive-latex-tikz-cd
    texlive-mathpazo
    texlive-latex-varwidth
    texlive-latex-xkeyval
    texlive-standalone
    git sassc
    ; node-katex
    poppler rubber
    shakefile))

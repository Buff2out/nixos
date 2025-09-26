#!/bin/sh
set -e

if [ -f flake.nix ]; then
    echo "⚠️  flake.nix already exists"
    exit 1
fi

cat > flake.nix << 'EOF'
{
  description = "C++ Project with Modern C++ tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      devEnv = with pkgs; [
        cmake
        clang
        clang-tools
        lld              # LLVM linker
        openssl
        openssl.dev
        pkg-config
        gtest
        bear             # для compile_commands.json
        gdb
        valgrind
        cppcheck         # статический анализ
        boost            # библиотеки общего назначения
        fmt              # форматирование строк
        nlohmann_json    # JSON парсер
        spdlog           # логирование
        ncurses          # TUI интерфейсы
        readline         # CLI readline
        zlib             # сжатие данных
        curl             # HTTP клиент
        sqlite           # база данных
      ];

    in {
      devShells.default = pkgs.mkShell {
        name = "cpp-dev-environment";

        buildInputs = devEnv;

        CC = "${pkgs.clang}/bin/clang";
        CXX = "${pkgs.clang}/bin/clang++";

        shellHook = ''
          export PATH="$HOME/.cargo/bin:$PATH"
          echo "🚀 C++ Development Environment (Clang Edition)"
          echo "📎 Available tools:"
          echo "   - cmake: $(cmake --version | head -n1)"
          echo "   - clang: $(${pkgs.clang}/bin/clang --version | head -n1)"
          echo "   - clang++: $(${pkgs.clang}/bin/clang++ --version | head -n1)"
          echo "   - openssl: ${pkgs.openssl.version}"
          echo "   - gtest: ${pkgs.gtest.version}"
          echo ""
          echo "🔧 Development workflow:"
          echo "   1. mkdir build && cd build"
          echo "   2. cmake .. -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++"
          echo "   3. make"
          echo "   4. ctest (for tests)"
          echo ""
          echo "✨ Clang advantages:"
          echo "   - Better error messages"
          echo "   - Faster compilation"
          echo "   - Excellent static analysis tools"
          echo "   - Great IDE integration"
          echo ""
          echo "Happy hacking with Clang! 🦉"
        '';
      };
    });
}
EOF

echo "✅ Created flake.nix for C++ project"
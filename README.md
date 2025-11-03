# 9cc

A small C compiler written in C, based on [低レイヤを知りたい人のためのCコンパイラ作成入門](https://www.sigbus.info/compilerbook).

## Directory Structure

```
.
├── 9cc.c              # Compiler source code
├── test.sh            # Test script
├── Makefile           # Build configuration
├── flake.nix          # Nix flake definition
└── .github/
    └── workflows/
        └── ci.yml     # CI configuration
```

## Requirements

- [Nix](https://github.com/NixOS/nix) with flakes enabled
- [direnv](https://github.com/direnv/direnv) (optional, for automatic environment loading)

## Usage

Work in progress.

## Development

Enter development environment with direnv:

```bash
direnv allow
```

Or without direnv:

```bash
nix develop
```

Build:

```bash
nix build
```

Run tests:

```bash
nix flake check
```

Format code:

```bash
nix fmt
```

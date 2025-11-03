# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

9cc is a small C compiler written in C, following the tutorial "低レイヤを知りたい人のためのCコンパイラ作成入門" (Introduction to Creating a C Compiler for Those Who Want to Know Low-Level Details). The compiler generates x86-64 assembly with Intel syntax.

## Project Structure

- **9cc.c**: Single-file compiler implementation that parses C input and generates x86-64 assembly
- **test.sh**: Test harness that compiles test cases, assembles them, and verifies exit codes
- **Makefile**: Traditional build system (runs under Nix)
- **flake.nix**: Nix flake providing reproducible builds, development environment, and CI checks

## Development Commands

### Environment Setup

The project uses Nix for reproducible builds. Enter the development environment:

```bash
nix develop
```

Or with direnv (automatic):

```bash
direnv allow
```

### Building

```bash
make         # Build using Makefile
nix build    # Build via Nix (creates result/ symlink)
```

### Testing

```bash
make test           # Run tests via Makefile
nix flake check     # Run all checks (build + tests)
bash test.sh        # Direct test execution
```

### Formatting

```bash
nix fmt      # Format all code (C, Nix, shell, assembly)
```

Configured formatters: clang-format (C), nixfmt (.nix), shfmt (shell), asmfmt (assembly)

## Architecture

The compiler currently implements a minimal subset of C:

1. **Input**: Takes a single numeric argument
2. **Code Generation**: Generates x86-64 assembly with Intel syntax
3. **Output**: Produces assembly that returns the input number as exit code

The test harness (`test.sh`) validates the compiler by:
- Running `./9cc <input>` to generate assembly (tmp.s)
- Assembling and linking with `cc -static` (creates tmp binary)
- Executing the binary and checking its exit code matches expected value

## Build System Notes

- **Nix flake**: Primary build system, provides reproducible environment with `glibc.static`
- **Makefile**: Uses `-std=c11 -g -static` flags
- **MCP Config**: The dev shell auto-generates `.mcp.json` for Claude Code integration (nixos and serena MCP servers)
- **CI**: GitHub Actions workflow defined in `.github/workflows/ci.yml`

## Language Notes

Error messages and some comments are in Japanese (引数の個数が正しくありません = "incorrect number of arguments").

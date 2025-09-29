# typst_playground


## Installation

Find the releases on the release page: 

- https://github.com/typst/typst/releases/


### Windows

Copy all files from zip direct to folder to c:\typst and add this to your windows path variable.

### Linux/WSL

Just use snap

```bash
sudo apt update
sudo apt install snapd
```

and then

```bash
sudo snap install typst
```

## Extention for VSCode: tinymist 

- This is recommendet for VSCode native on Windows the newest Version works fine.
- For WSL2 Users i recommend to use version 0.13.0. 


## Compile documents in this folder structure 

Stay in root folder use --root in compile command

```bash
typst compile --root . .\simple_presentation\main_presentation.typ
```
or 
```bash
typst compile --root . .\simple_document\main.typ
```

# My terminal prompt customization

## Installation

### Windows

Tested with Git Bash. It requires Git. Inside the Git Bash directory rename git-prompt.sh to git-prompt.backup and add [my git-prompt.sh file](git-prompt.sh)

```bash
# Rename currect git bash profile for backup

mv C:\Program Files\Git\etc\profile.d\git-prompt.sh C:\Program Files\Git\etc\profile.d\git-prompt.backup

cd ~ && git clone https://github.com/KonstantinosAng/my-terminal-prompt && cd my-terminal-prompt cp git-prompt.sh C:\Program Files\Git\etc\profile.d\

```

### Linux

Tested in Ubuntu. It requires Git. 

```bash

```

## Examples

<p align='center'>
  <p> (Time) User Current_Directory (No.Files - FileSize) </p>
  <img src="./img/img1.png"/>
  <p> Git Support (Branch - No.StagedFiles|No.UntrackedFiles|No.ModifiedFiles|Branch Status Compared To Github Repo (= Equal, > Ahead, < Behind, <> Diverged)) </p>
  <img src="./img/img2.png"/>
  <p> Python Virtual env support (Virtual Environment Name| Python version ) </p>
  <img src="./img/img3.png"/>
</p>
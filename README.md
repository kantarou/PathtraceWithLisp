# PathtraceWithLisp
Common Lisp

# 環境
SBCL 1.4.12
Emacs + SLIME

# 実行方法
## 実行ファイルを作成
```
sbcl --noinform --no-sysinit --no-userinit --load compile.lisp
```
上記を実行すると「pathtrace-lisp」という実行ファイルができる。

## 実行
```
./pathtrace-lisp
```
処理が終わると、sky.ppmというファイルが作成されます。


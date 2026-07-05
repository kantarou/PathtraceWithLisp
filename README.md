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

# ファイル間の依存関係
`src/`以下の各ファイルが手動で`(load ".../X.fasl")`を書く代わりに、
リポジトリ直下の`pathtrace.asd`でASDFのシステムとして依存関係を宣言しています。
新しいファイルを追加する場合は、`pathtrace.asd`の`:components`にそのファイルが
依存する既存ファイルを`:depends-on`で指定してください。ロードやコンパイルの
順序はASDFが依存グラフから自動的に解決します。


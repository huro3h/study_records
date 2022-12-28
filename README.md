### 環境構築手順
※ [Docker Desktop](https://docs.docker.jp/desktop/toc.html) がインストールされていることが前提です

1. このリポジトリをクローンする  

```shell
git clone git@github.com:huro3h/study_records.git
```

2. Docker Imageの作成

```shell
docker-compose build --no-cache
```

3. RailsサーバとDBサーバのコンテナを立ち上げる

```shell
docker-compose up

or 

docker-compose up -d (バックグラウンドで動きます)
```

4. (※1 ここから別窓のコンソールで) コンテナが立ち上がっていることを確認

```shell
docker ps

CONTAINER ID   IMAGE               COMMAND                  CREATED          STATUS          PORTS                    NAMES
33c3a30c9416   study_records-web   "entrypoint.sh /bin/…"   12 minutes ago   Up 12 minutes   0.0.0.0:3000->3000/tcp   study_records-web-1
8ee1f08fc4a6   postgres:15.1       "docker-entrypoint.s…"   12 minutes ago   Up 12 minutes   0.0.0.0:5432->5432/tcp   study_records-db-1
```

5. Railsサーバのコンテナ内に入る

```
docker exec -it study_records-web-1 /bin/bash
```

(コンテナ内に入るとコマンドプロンプトが変わります ↓ 例)
```
root@33c3a30c9416:/myapp#
```

6. Railsサーバのコンテナ内で、DBの初期セットアップをする
```shell
root@33c3a30c9416:/myapp# bin/rails db:prepare

# Created database 'study_records_development'
# Created database 'study_records_test'
```

7. Railsサーバを立ち上げる
```shell
bin/rails s -b 0.0.0.0

# => Booting Puma
# => Rails 7.0.4 application starting in development
# => Run `bin/rails server --help` for more startup options
# Puma starting in single mode...
# * Puma version: 5.6.5 (ruby 3.1.3-p185) ("Birdie's Version")
# *  Min threads: 5
# *  Max threads: 5
# *  Environment: development
# *          PID: 64
# * Listening on http://0.0.0.0:3000
# Use Ctrl-C to stop
```

8. ブラウザからアクセスしてみる

  http://localhost:3000/

  <img width="400" alt="ss 4" src="https://user-images.githubusercontent.com/16791696/208663764-871d5ddf-b3c0-4f75-aec5-f5c114222504.png">

9. (※2 ここからさらに別窓のコンソールで) JavaScript, CSSのファイルなどのassetsファイル監視用プロセスを起動しておく
```shell
docker exec -it study_records-web-1 /bin/bash

root@33c3a30c9416:/myapp# yarn install && bin/dev

# yarn install v1.22.19
# [1/4] Resolving packages...
# [2/4] Fetching packages...
# [3/4] Linking dependencies...
# [4/4] Building fresh packages...
# Done in 16.00s.
# 16:50:07 js.1   | started with pid 137
# 16:50:07 css.1  | started with pid 138
# 16:50:07 js.1   | yarn run v1.22.19
# 16:50:07 css.1  | yarn run v1.22.19
# 16:50:07 js.1   | $ esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets --watch
# 16:50:07 css.1  | $ sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules --watch
# 16:50:08 js.1   | [watch] build finished, watching for changes...
# 16:50:12 css.1  | Compiled app/assets/stylesheets/application.bootstrap.scss to app/assets/builds/application.css.
# 16:50:12 css.1  | Sass is watching for changes. Press Ctrl-C to stop.
# 16:50:12 css.1  |
# ....
```

※1, ※2 別窓のコンソールで合計3つ動いているイメージ画像

<img width="700" alt="ss 7" src="https://user-images.githubusercontent.com/16791696/208669977-e5366e47-5882-4a22-9e7d-53d839f407f1.png">

10. `develop` ブランチから `feature` ブランチを切って開発スタート

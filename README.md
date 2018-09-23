# Longinus

## Environment
- Ruby 2.5.1
- Rails 5.2.1

## 開発環境について
### 大まかな導入手順
1. `git clone`によりローカルにリポジトリを取得
2. `docker-compose build`を実行
3. `docker-compose up`でRailsが動くはず
4. このままではデータベースがない状態なので，`docker-compose exec web rails db:create`で作成
5. ブラウザで`localhost:3000`にアクセスしRuby on Railsの初期画面が表示されればOK
6. コンテナを止めたければ`docker-compose stop`で，消すには`docker-compose down`でお願いします．

### 今の所の注意
- リポジトリ内にできるdbディレクトリはgitの管理からわざと外しているのでgit addできないはずです
- `docker-compose 〜`を実行するとコンテナが作られる場合があるので，無駄なコンテナで容量が圧迫される恐れがあります．`docker ps`で動いているコンテナを表示，`docker ps -a`で全て表示するので，いらなそうなコンテナは`docker rm コンテナId`で削除してください
- `docker-compose up`で作られたコンテナに関しては`docker-compose down`をすることで自動的に削除されます．
- `docker-compose down`や`docker rm コンテナID`でコンテナを削除しても中にあるデータはmac側に残るようにしているはずなので，大丈夫だと思います多分．リポジトリ内のwebディレクトリやdbディレクトリに残ってるはずです．

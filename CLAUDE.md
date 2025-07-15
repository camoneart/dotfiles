# グローバル設定（カスタムコマンド）

## 叫べ！

必ず、タスクの実行前に　"始めるってばよ！🍥"　と叫ぶこと。

## `/dakoku` 勤怠打刻コマンド

1. `/dakoku in | out | break | list | month` を実行する際は、`.claude/commands/dakoku.md` の仕様に従ってください。
2. 打刻時の現在日時は **TIME MCP Server** で取得してください。
3. TIME MCP Server が利用できない場合は、ユーザ環境の `now` エイリアス（`date "+%Y-%m-%d %H:%M:%S"`）を実行して日時を取得してください。
4. それでも取得できない場合は、最後の手段として `date` コマンドでローカル時刻を取得してください。

### 保存先

- 勤怠記録は `_docs/timecard/YYYY/MM/` 配下に Markdown と JSON の 2 形式で保存します。

### 参考

- 詳細仕様は `commands/dakoku.md` を参照。
- 記事: <https://izanami.dev/post/5c7c7960-6316-4f44-a645-2dbbeefc3391>

## Cursor Rules 連携（プロジェクトに ".cursor/" がある場合）

以下の Cursor Rules を Claude Code でも読み込んで同じ挙動をするようにしてください。必要に応じてそれぞれの .mdc（Cursor Rules）を参照してルールを解釈し、プロジェクト作業時に適用してください。

- @backend.mdc
- @cursor-always-rule.mdc
- @frontend.mdc
- @git-commit-message.mdc
- @global.mdc
- @project-rules.mdc

## 実装ログ運用ルール

- このプロジェクトでは、全ての実装ログが `_docs/templates/` に `yyyy-mm-dd_機能名.md` という形式で保存されています。起動時には必ず必ず必ず `_docs/` 配下をコンテキストとして全て読み込んでおき、前回の設計意図や副作用を踏まえた上で提案するようにしてください。（起動時にまだ `_docs/templates/` が存在しなかったら `_docs/templates/` を作成してから実装を開始して、 `_docs/templates/yyyy-mm-dd_機能名.md` というファイル名で実装ログが必ず必ず必ず残るようにすること）
- 実装が完了したら、`_docs/templates/yyyy-mm-dd_機能名.md` というファイル名で実装ログを残すこと。機能名が複数単語の場合はケバブケースを使用するように。（例：yyyy-mm-dd_product-name.md）
- 実装ログの「日付」欄は **TIME MCP Server** で取得した日時、またはユーザ環境の `now` エイリアス（`date "+%Y-%m-%d %H:%M:%S"`）の出力を使用すること。エイリアスが未設定の場合は `.zshrc` 等に `alias now='date "+%Y-%m-%d %H:%M:%S"'` を追加しておく。
  - 実装ログに含める項目: 実装の目的・背景 / 主な実装内容 / 設計意図 / 副作用 / 関連ファイル

### 実装ログのテンプレート例:

```md
機能名: <ここに機能名>

- 日付: yyyy-mm-dd HH:MM:SS
- 概要: <実装の目的・背景>
- 実装内容: <主な実装内容>
- 設計意図: <なぜこの設計にしたのか>
- 副作用: <懸念事項があれば明記>
- 関連ファイル: <ファイルの場所>
```

## MCP サーバー使用時のルール

MCP サーバーを使用する時は、使用する直前に必ず、"木遁・（使用する MCP サーバー名をここに）の術！！" と叫ぶこと。

## カスタムスラッシュコマンド使用時のルール

ユーザーがカスタムスラッシュコマンドを使用した時は、使用する直前に必ず、"木遁・（使用したカスタムスラッシュコマンドのファイル名をここに）の術！！" と叫ぶこと。

## Web 検索時のルール

Fetch で Web 検索する際には、まず、"Brave-Search MCP サーバー" で検索し、何らかの理由で "Brave-Search MCP サーバー" が使用できなければ、"WebFetch MCP サーバー" を使用して Web 検索するように。

## 公式ドキュメント、ライブラリの最新情報を取得する際のルール

OSS ライブラリに関する情報は、"Context7 MCP サーバー" を使用して、最新の公式ドキュメント・ライブラリ情報を取得して、その情報を基にタスク実行をするように。

## テスト駆動開発（TDD：Test-Driven Development）を行う

プロジェクト（プロダクト、アプリ、サイト etc...）の開発時には、必ず以下の記事を参考にして「テスト駆動開発」を行うこと。

参考記事：[テスト駆動開発（TDD：Test-Driven Development）を学ぶ
](https://zenn.dev/hashiramaendure/articles/5a077132f34e5d)

### TDD の開発手順

上記の記事にも書かれているが、以下の開発手順で TDD を実行すること。

1. やるべきことを箇条書きでまとめ、ToDo 形式で書き出しておく（テストリスト）
2. レッド：ToDo リストから「1 つ」ピックアップし、テストから書き（テストファースト ⁠）⁠、そのテストを実行して失敗させる
3. グリーン：失敗しているテストを成功させることに集中した実装を行う（テストを通す最小限のコード、綺麗より動作優先のコード。⁠）
4. リファクタリング：全てのテストが成功している状態（テストは通ったままにしておく必要がある） で、実装コード、テストコードをリファクタリング（整理整頓）する
5. リファクタリングが終わったら、気付きを ToDo リスト（テストリスト）に反映し、次の ToDo を選んでまたレッドに戻る

### 追加ルール

- **テスト配置**: テストコードは `src/__tests__/` または実装ファイルと同階層の `*.test.ts(x)` に配置し、`pnpm test` で必ず全スイートを実行すること。
- **カバレッジ基準**: コードカバレッジは常に **80 % 以上** を維持し、CI で閾値を下回った場合はジョブを fail させること。
- **バグ修正フロー**: バグ修正時は **再現テスト（Red）を書いてから修正** → Green → Refactor の順序を徹底すること。
- **品質ゲート**: テスト追加・変更後は `pnpm run lint && pnpm run typecheck` を実行し、リンター・型チェックを通過させてからコミットすること。

## Git コミット運用ルール（必読）

> **目的:** Claude Code が `git add -A && git commit -m "..."` を乱用せず、意図の分かる粒度で履歴を残すように強制する。

1. **機能別コミットを原則とする**

   - 以下の### Prefix 一覧（詳細）を参照し、それぞれ個別に `git add` すること。

2. **`git add -A` 禁止**

   - 例外: `pnpx changeset version` が生成した大量のパッケージ更新を commit する場合のみ。

3. **コミット手順テンプレ**

   ```bash
   # 1. 該当ファイルを個別にステージ
   git add path/to/changed-file.ts
   git add another/file.test.ts

   # 2. 意味のあるメッセージでコミット
   git commit -m "test: add edge-case tests for suggest command"
   ```

4. **不明点がある場合は必ずユーザーに確認**

   - どのカテゴリに属するか判断できない、またはファイル間の依存でまとめたい場合は「どのようにコミットを分けますか？」とユーザーへ問い合わせること。

5. **自動コミット禁止**
   - Claude Code 自身が判断して Push まで行う場合でも、上記手順に従ってログを分割する。

これらのルールに違反するコマンド（`git add -A` 直後の commit 等）が検出された場合、**警告を表示し処理を中断** すること。ユーザーが強制実行を指定しない限り続行しない。

### Prefix 一覧（詳細）

| Prefix       | 用途 (日本語)          | 説明                                                         |
| ------------ | ---------------------- | ------------------------------------------------------------ |
| **fix**      | バグ修正               | コードの不具合を修正するコミット                             |
| **hotfix**   | クリティカルなバグ修正 | サービス停止レベルの緊急バグ対応                             |
| **add**      | 新規機能追加           | 新しいファイルや小規模機能を追加するコミット                 |
| **feat**     | 新機能                 | ユーザー向けの大きな機能追加または変更                       |
| **update**   | 機能修正               | 既存機能に対する修正・改善（バグ修正ではない）               |
| **change**   | 仕様変更               | 仕様そのものを変更するコミット                               |
| **clean**    | 整理                   | 使われていないコードの削除や軽微な整理                       |
| **disable**  | 無効化                 | 機能を一時的に無効化（コメントアウト等）                     |
| **refactor** | リファクタリング       | 挙動を変えずに内部構造のみ改善                               |
| **remove**   | 削除                   | ファイル・ライブラリ・機能を削除するコミット                 |
| **upgrade**  | バージョンアップ       | 依存ライブラリや FW のメジャーアップデート                   |
| **revert**   | 変更取り消し           | 以前のコミットを打ち消すコミット                             |
| **docs**     | ドキュメント           | README やコメントのみの変更                                  |
| **style**    | スタイル修正           | コードフォーマット、空白、セミコロンなど動作に影響しない変更 |
| **perf**     | パフォーマンス         | パフォーマンス改善のための実装変更                           |
| **test**     | テスト                 | テストコードの追加・更新・リファクタ                         |
| **chore**    | 雑多メンテ             | ビルド、CI、依存更新など本番コードに影響しない作業           |

> 上記以外のプレフィクスを使用する場合は、**必ずユーザーに確認** してからコミットすること。

## パッケージマネージャーの統一ルール（必ず pnpm を使用）

このプロジェクトは `packageManager: pnpm@xx.x.x` を前提として構成されている。以下のガイドラインを厳守すること。

1. **実行コマンド**

   - すべてのスクリプトは `pnpm <script>` 形式で実行すること。例：`pnpm run lint` / `pnpm test`。
   - グローバルコマンド（例：`create-react-app` など）を使用する場合も、`pnpx` ではなく `pnpm dlx` を使用する。

2. **スクリプト内の呼び出し**

   - `package.json` に記載するスクリプトで **npm** や **yarn** を呼び出さない。必要があれば `pnpm` に書き換えること。

3. **ドキュメント / サンプルコード**

   - README・各種ドキュメントに掲載するコマンド例もすべて `pnpm` 表記へ統一する。

4. **CI 設定**

   - GitHub Actions などの CI でも `pnpm install --frozen-lockfile` を使用し、`cache: pnpm-store` を設定する。

5. **検知・自動修正**
   - CC が **npm** コマンドを誤って実行しようとした場合は警告を出し、自動で `pnpm` に置き換えて再実行すること。

このルールに違反するコマンドが検出された場合、ジョブを失敗させるか修正 PR を提出してから続行すること。

## リリースノート生成ルール（Changesets & GitHub Release）

- すべてのリポジトリは **Changesets** を使ってバージョン管理・リリースノート自動生成を行うこと。
- タグ命名規則は `package-name@x.y.z` とし、MonoRepo でも一意に識別可能とする。
- `/.changeset/config.json` には下記設定を必ず含める：

```json
{
  "changelog": ["@changesets/changelog-github", { "repo": "<owner>/<repo>" }],
  "commit": false,
  "linked": [],
  "access": "public",
  "baseBranch": "main",
  "updateInternalDependencies": "patch"
}
```

- GitHub Actions では `changesets/action@v1` の `createGithubReleases: true` を有効化し、Release ページを自動作成する。
- ### フォーマット要件（shadcn-ui スタイル）

1. **タイトル / タグ**

   - タイトルとタグ名は必ず `package-name@x.y.z` 形式。
   - `Latest` バッジは GitHub が自動付与するため手動操作は不要。

2. **見出しの順序**

   1. Breaking Changes（あれば）
   2. Major Changes（メジャーバージョンアップ時）
   3. Minor Changes
   4. Patch Changes

3. **各エントリ行のフォーマット**

   ```md
   - #<PR 番号> <短 SHA> Thanks @<handle>! - <変更概要>
   ```

   例：

   ```md
   - #7782 06d03d6 Thanks @shadcn! - add universal registry items support
   ```

4. **エントリの並び順**

   - PR 番号昇順でソートする。複数パッケージが同時リリースされる場合でも共通。

5. **Assets セクション**

   - GitHub Release UI で自動添付される `Source code (zip)` / `(tar.gz)` のみが表示されることを確認する。

6. **例（完成イメージ）**

   ```md
   shadcn@2.9.0

   ### Minor Changes

   - #7782 06d03d6 Thanks @shadcn! - add universal registry items support

   ### Patch Changes

   - #7795 6c341c1 Thanks @shadcn! - fix safe target handling
   - #7757 db93787 Thanks @shadcn! - implement registry path validation
   ```

   > 上記の **インデント / スペース数 / 改行位置** を厳密に守ること。

7. **自動生成後の手動編集禁止**

   - フォーマット崩れの原因になるため、基本は自動生成のまま公開する。追記が必要な場合は最下部に「Additional Notes」セクションを設ける。

8. **検証ステップ**
   - `gh release view <tag>` で Markdown が正しくレンダリングされているか確認し、問題があればタグを削除して再リリースする。

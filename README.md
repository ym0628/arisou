# パチスロ｜当たり末尾発見ツール「Arisou」


#■サービス概要
* パチスロで高設定を探すのことに苦労している人へ
* 高設定の配分が可視化できるツールを提供し
* 当たり台（高設定）が隠されている場所をいち早く察知できるようにします


■メインのターゲットユーザー
* 18歳高卒〜40代（ほぼ男性）のパチスロ・ヘビーユーザー
    * パチスロ遊技人口は約600万人（2021年）
    * パチスロの勝ち方を知っていて、実際に勝っている層→およそ１割の50〜60万人程度と予想
    * 上記に該当するパチスロユーザーがターゲットとなります


■パチスロを打ったことがことが無い方向けの説明

●パチンコ店におけるパチスロ営業
* パチスロには一般的に、内部設定が１〜６まで存在
* 機械割（出率）は97%〜114%程度に決められている
* パチンコ店に設置されているパチスロ台のほとんどは設定１
* 投入枚数に対して出率97%の台を1日打つと平均15,000円くらい負ける計算
* そのため、何も考えずにパチスロを打っていると基本的に負けていくのが普通
* ただ、お店も出玉アピールのため、少数の台には設定４〜６が投入される
* 設定４５６（平均104%〜114%の間）を打つと20,000〜70,000円くらい勝てる計算
* 勝てる台＝高設定台（456）の場所をいち早く察知して座ることが重要
* ※法律上、換金行為はなされていないが、ここでは便宜上、円での勝ち額を記載しています

●公約取材やお店の高設定投入の傾向を知る
* お店によっては高設定の投入の仕方にある法則性を持たせている場合があります
    * 末尾（パチスロ台番号の末尾に7がつく台はすべて設定4,5,6など）
    * 並び（3台並びで設定4,5,6、6台並びで設定5,6など）
    * 全台系（アイムジャグラー10台設置がすべて設定６など）
* これらの法則性を見つけることで、パチスロでの勝ちに一歩近づきます
* 台のデータは店舗が提供するアプリや、有料のデータ公開サイトを利用することで、数十分おきにリアルタイムの情報が確認可能できる
* データサイトを上手に駆使することでその日の店内の設定状況を読み取ることができる
* 本アプリケーションでは、特定末尾の台番号に高設定の配分を寄せている傾向を掴むために特化した機能を提供します


■ユーザーが抱える課題

* 高設定を探し当てるために法則性を探そうとするのだが、データサイトだけでは、設定状況を即座に読み取ることは難しい
* 周りには同じように法則性を探るライバル・プロ軍団がひしめくため、高設定の場所を察知するにはスピードと的確な判断が要求される
* ライバルとの競争に打ち勝ち、高設定台にいち早く辿り着くためには、当日の店内状況や、データサイトで閲覧できる情報から、その日その店の設定配分の法則性をいち早く察知しなければならない


■解決方法

* 当日の店内状況およびデータサイトで更新される設置台のデータを確認し、高設定っぽい台をまとめて集計する
* 高設定投入傾向の代表格である「特定の台番号（末尾）」を、当ツールを使用することで見つけやすくすることができる


■実装予定の機能

●アタリ末尾 発見ツール「Arisou」
* 店舗のパチスロ設置台数を入力
* 高設定が「ありそう」な台の台番号をツールに入力していく
* （※「ありそう」の基準は人それぞれのため、ユーザーに任せる）
* 出力ボタン
* 結果が出力される
    * 出力時刻：2023/01/20 13:15
    * 末尾1　ありそう数：20台　ありそう率：66%（20/30台）
    * 末尾2　ありそう数：8台　ありそう率：26%（8/30台）
    * 末尾3　ありそう数：7台　ありそう率：23%（7/30台）
    * 末尾4　ありそう数：12台　ありそう率：40%（12/30台）
    * 末尾5　ありそう数：7台　ありそう率：23%（7/30台）
    * 末尾6　ありそう数：7台　ありそう率：23%（7/30台）
    * 末尾7　ありそう数：7台　ありそう率：23%（7/30台）
    * 末尾8　ありそう数：7台　ありそう率：23%（7/30台）
    * 末尾9　ありそう数：7台　ありそう率：23%（7/30台）
    * 末尾0　ありそう数：7台　ありそう率：23%（7/30台）
    * 末尾ゾロ目　ありそう数：7台　ありそう率：23%（7/30台）
* 出力結果を保存
* 戻って編集する
* 算出結果のリセット


●サービス利用までのユーザーの導線
* サイト参加検討中のユーザー
    * サイトに訪れたユーザーがサイトに参加することができる
        * ユーザーがサイトTOPページを閲覧できる
        * ユーザーがTwitterでユーザー登録できる
        * ユーザーがサイトのサービスをすぐに利用開始できる
* サービス利用中のユーザー
    * サービスの利用を開始できる
        * 入力項目
            * パチスロ総設置台数
            * 台番号
            * 差枚数
        * 出力結果の確認
        * 入力画面へ戻り編集
        * 出力結果のテキストをコピー
        * 出力結果の保存（会員登録ユーザー）
        * 出力結果画面のリセット
        * マイページへ移る（会員登録ユーザー）
    * 会員登録ユーザーはマイページを利用できる
        * 保存した出力結果の閲覧
        * 保存した出力結果の編集
        * 保存した出力結果の削除
* 管理ユーザー
    * 登録ユーザーの検索、編集、削除
    * 管理ユーザーの一覧、詳細、作成、編集、削除



■なぜこのサービスを作りたいのか？

自分自身パチスロのヘビーユーザーであった過去があるため、「こんなサービスがあれば絶対使う！」と思えるサービスを考えました。

パチンコ・パチスロは正しい知識・情報を持っていれば、あとは行動するだけで誰でも勝つ（生涯でプラスにするということ）は現実的に可能なので、昨今のパチンコ・パチスロ業界では、「勝ち」の立ち回りを行うのが年々難しくなってきています。

* 年々厳しくなる遊技機の規制（台スペックの低下）
* 店舗経営の悪化〜倒産ラッシュ
* プロ軍団による勝てる台の占拠
* 店舗による客への出禁措置ルールの強化

上記は理由の一部ではありますが、これらによってお店の利益は下降傾向にあり、お客さんへの還元（すなわち高設定を多く使う）ができなくなりつつあります。そのため、以前のように勝てる台の総数・総額が減り、勝てる台を探すのが難しくなっているのです。

厳しい状況下にあるパチスロ業界においても、長く遊ぶためには、負ける台を避け、勝ちに繋がる台を選びが必要です。勝てる台をいち早く確保するために、このサービスを考えるに至りました。


■スケジュール

1. 企画（アイデア企画・技術調査）：3/7〆切 　
2. 設計（README作成・画面遷移図作成・ER図作成）：3/14 〆切
3. 機能実装：3/15 - 4/22〆切
4. MVPリリース：4/29〆切
5. 本リリース：5/7〆切


■使用技術

●バックエンド
- Ruby 2.7.3
- Ruby on Rails 6.0.3

●フロントエンド
- Sass/SCSS (CSS)
- Bootstrap 5.0.0 (CSS)
- Vue.js 2.6.14 (JavaScript)
- axios (JS Package/Ajax)
- Leaflet/OpenStreetMap (Map)

●インフラ、API、開発環境
- AWS
- MySQL 5.7.3
- Spec
- RuboCop
- Twitter API

●使用gem
- Nokogiri (スクレイピング)
- Sorcery (ユーザー認証）
- Pundit (権限管理)
- ActiveDecorator (デコレータ)


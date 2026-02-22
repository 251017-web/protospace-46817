# テーブル設計

※ prototypesテーブルのimageカラムはActiveStorageで実装するため、
テーブル設計には記述しない。

---

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| name               | string  | null: false               |
| profile            | text    | null: false               |
| occupation         | string  | null: false               |
| position           | string  | null: false               |

### Association
- has_many :prototypes
- has_many :comments



## prototypes テーブル

| Column     | Type       | Options                         |
| ---------- | ---------- | ------------------------------- |
| title      | string     | null: false                     |
| catch_copy | string     | null: false                     |
| concept    | text       | null: false                     |
| user       | references | null: false, foreign_key: true  |

### Association
- belongs_to :user
- has_many :comments



## comments テーブル

| Column     | Type       | Options                         |
| ---------- | ---------- | ------------------------------- |
| content    | text       | null: false                     |
| user       | references | null: false, foreign_key: true  |
| prototype  | references | null: false, foreign_key: true  |

### Association
- belongs_to :user
- belongs_to :prototype
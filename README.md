# nchosts

ニフティクラウドの API からさまざまな形式 (hosts, ssh_config, shell alias 等) のサーバー一覧情報を生成します。  
複数のアカウントにまたがり大量のサーバーを運用しているような場合に便利です。

## Usage

まず、アカウント情報が書かれた設定ファイル `accounts.json` を作成します。
(安全に利用するため閲覧権限のみ付与した API キーを利用しましょう。)

	$ cat accounts.json
	[
	  {
            "nifty_id": "ABC00001.readonly",
	    "access_key_id": "LLLLLLLLLLLLLLLLLLLL",
	    "secret_access_key": "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM",
	  },
	  {
            "nifty_id": "ABC00002.readonly",
	    "access_key_id": "NNNNNNNNNNNNNNNNNNNN",
	    "secret_access_key": "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO",
	  }
	]

上記 `accounts.json` を引数に `nchosts collect` コマンドを実行します。

	$ nchosts collect -c accounts.json -o instances.json

`accounts.json` に書かれたアカウント情報を元に、各アカウントの全リージョン分のサーバー一覧情報が取得されます。
取得された情報は `-o` (`--output`) オプションに指定したファイル (`instances.json`) へ書き込まれます。

この `instances.json` を利用してさまざまな形式のサーバー一覧情報を生成することができます。

	$ nchosts generate -i instances.json -f hosts >> /etc/hosts
	$ nchosts generate -i instances.json -f ssh_config >> ~/.ssh/config
	$ nchosts generate -i instances.json -f alias >> ~/.ssh/config

自分で書いた erubis 形式のテンプレートファイルを利用することもできます。
テンプレートの中では `instances` というローカル変数 (配列) でサーバー情報の一覧を参照できます。

	$ nchosts generate -i instances.json -t template.erb > myhosts.txt

## Installation

Add this line to your application's Gemfile:

    gem 'nchosts'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nchosts

## Contributing

1. Fork it ( https://github.com/[my-github-username]/nchosts/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

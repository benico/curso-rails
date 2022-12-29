namespace :dev do
  desc "Configura ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD..") {%x(rails db:drop:_unsafe)}      
      show_spinner("Criando BD..") {%x(rails db:create)}
      show_spinner("Migrando BD..") {%x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastro moedas padrão"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas..") do
      coins = [
                {
                    description: "Bitcoin",
                    acronym: "BTC",
                    url_image: "https://static.vecteezy.com/system/resources/previews/008/505/801/original/bitcoin-logo-color-illustration-png.png",
                    mining_type: MiningType.find_by(acronym: "PoW")
                },
                {
                    description: "Ethereum",
                    acronym: "ETH",
                    url_image: "https://upload.wikimedia.org/wikipedia/commons/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png",
                    mining_type: MiningType.all.sample
                },
                {
                    description: "Dash",
                    acronym: "DASH",
                    url_image: "https://e7.pngegg.com/pngimages/492/359/png-clipart-dash-initial-coin-offering-cryptocurrency-bitcoin-ethereum-blockchain-trademark-logo.png",
                    mining_type: MiningType.all.sample
                },
                {
                  description: "Iota",
                  acronym: "IOT",
                  url_image: "https://cryptologos.cc/logos/iota-miota-logo.png",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "ZCash",
                  acronym: "ZEC",
                  url_image: "https://cryptologos.cc/logos/zcash-zec-logo.png",
                  mining_type: MiningType.all.sample
                }
            ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end
  

  desc "Cadastro tipos de mineração padrão"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração..") do
      mining_types = [
                        {description: "Proof of Work", acronym: "PoW"},
                        {description: "Proof of Stake", acronym: "PoS"},
                        {description: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private
  
  def show_spinner(msg_start,msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner::new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end

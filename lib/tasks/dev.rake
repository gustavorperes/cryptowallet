namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
        #show_spinner("Apagando DB..") { %x(rails db:drop) }
        show_spinner("Criando DB..") { %x(rails db:create) }
        show_spinner("Migrando DB..") { %x(rails db:migrate) }
        %x(rails dev:add_types)
        %x(rails dev:add_coins)
    else
      puts "Voce nao esta no ambiente de desenvolvimento"
    end
  end
  
    desc "Cadastra as Moedas"
    task add_coins: :environment do
        show_spinner("Cadastrando Moedas..") do
            coins = [
            {
                description: "Bitcoin",
                acronym: "BTC",
                url_image: "https://cdn-icons-png.flaticon.com/512/46/46775.png",
                mining_type: MiningType.find_by(acronym: "PoW")
            }, 
            {
                description: "Ethereum",
                acronym: "ETH",
                url_image: "https://w7.pngwing.com/pngs/268/1013/png-transparent-ethereum-eth-hd-logo-thumbnail.png",
                mining_type: MiningType.all.sample
            },
            {
                description: "Dash",
                acronym: "DASH",
                url_image: "https://www.pngall.com/wp-content/uploads/10/Dash-Crypto-Logo-PNG-Cutout.png",
                mining_type: MiningType.all.sample
            },
            {
              description: "Iota",
              acronym: "IOT",
              url_image: "https://thumbnail.imgbin.com/25/10/9/imgbin-iota-cryptocurrency-logo-internet-of-things-tether-bitcoin-zR7bBudyQFLZ1WeCBM0cK3ry0_t.jpg",
              mining_type: MiningType.all.sample
            },
            {
              description: "ZCash",
              acronym: "ZEC",
              url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1437.png",
              mining_type: MiningType.all.sample
            }
            ]
            
            coins.each do |coin|
                Coin.find_or_create_by!(coin)
            end
        end
    end
    
    desc "Cadastra os Tipos de Mineração"
    task add_types: :environment do
        show_spinner("Cadastrando Tipos de Mineração..") do
            mining_types = [
                {
                    description: "Proof of Work",
                    acronym: "PoW"
                },
                {
                    description: "Proof of Strake",
                    acronym: "PoS"
                },
                {
                    description: "Proof of Capacity",
                    acronym: "PoC"
                }
            ]
            
            mining_types.each do |type|
                MiningType.find_or_create_by!(type)
            end
        end
    end
    
    private
        def show_spinner(msg_start, msg_end = "Concluido!")
          spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
          spinner.auto_spin
          yield
          spinner.success("(#{msg_end})")
        end
    
end

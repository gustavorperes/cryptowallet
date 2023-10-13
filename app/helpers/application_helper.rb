module ApplicationHelper
    
    def
        locale
        I18n.locale == :en ? "Estados Unidos" : "Brasil"
    end
    
    def dateFormat(data)
        data.strftime("%d/%m/%Y")
    end
    
    def ambiente
        if Rails.env.development?
            "Desenvolvimento"
        elsif Rails.env.production 
            "Produção"
        else
            "Teste"
        end
    end
end

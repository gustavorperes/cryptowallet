class WelcomeController < ApplicationController
    def index
      cookies[:curso] = "Curso Rails [COOKIE]"
      @nome = params[:nome]
    end
end

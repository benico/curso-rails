class WelcomeController < ApplicationController
  def index
      #cookies[:curso] = "Curso de Ruby on Rails [COOKIE]" #GUARDA DADOS NO NAVEGADOR
      session[:curso] = "Curso de Ruby on Rails [SESION]" #GUARDA DADOS NO SERVIDOR
  end
end

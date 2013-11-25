require 'ostruct'

module TrelloApiMock

  def self.configure
  end

  class Board
    def self.create params
      board = OpenStruct.new
      list = OpenStruct.new
      list.id = '10'
      board.lists = [list]
      board
    end
  end

  class Card
    def self.created_cards
      @@created_cards.flatten
    end

    def self.create params
      card = OpenStruct.new
      def card.update! 
      end
      @@created_cards ||= []
      @@created_cards << params
      card
    end
  end
end

module TrelloAuthMock
  def self.included(app)
    app.get '/grant_trello_permissions' do
      auth = OpenStruct.new
      auth.consumer = OpenStruct.new
      session['trello_auth'] = auth
      redirect to('/trello')
    end
  end
end

Trello = TrelloApiMock
Authorization::Trello = TrelloAuthMock


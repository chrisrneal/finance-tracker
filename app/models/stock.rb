class Stock < ActiveRecord::Base
    
    has_many :user_stocks
    has_many :users, through: :user_stocks
    
    def self.find_by_ticker(ticker_symbol)
        where(ticker: ticker_symbol).first
    end 
    
    def self.new_from_lookup(ticker_symbol)
        lookup_stock = StockQuote::Stock.quote(ticker_symbol)
        return nil unless lookup_stock.name
        
        new_stock = Stock.new(ticker:lookup_stock.symbol, name:lookup_stock.name)
        new_stock.last_price = new_stock.price
        new_stock
    end
    
    def price
        ret_val = StockQuote::Stock.quote(ticker).last_trade_price_only
        return "#{ret_val} (Latest)" if ret_val
        'Unavailable'
    end

end

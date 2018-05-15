class BooksController < ApplicationController	
	before_action :find_book, only: [:show,:edit,:update,:destroy,]
	before_action :authenticate_user!

	def index    
		if params[:search]
		  @books = Book.all.joins(:user).where("lower(title) LIKE ? or lower(text) LIKE ? or users.username LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%") 	   
		else
			@books = Book.all.includes(:user) 
		end
		respond_to do |format|
		  format.html  # index.html.erb
		  format.js
		end
	end
	
	
	def new
		@book = Book.new
	end
  	
	def create
		@book = Book.new(book_params)
		@book.attachment = params[:book][:attachment]
		@book.user_id = current_user.id
		if @book.save
			redirect_to @book
		else
			render 'new'
		end
	end

	def edit		
		puts @book.user_id
		puts current_user.id
		if @book.user_id != current_user.id
			puts "Here"
			redirect_to books_path
		end
	end
  	
	def update
		if @book.update(book_params)
			redirect_to @book
		else
			render 'edit'
		end
	end
 
	def destroy
		@book.destroy
		redirect_to books_path	
	end

	def find_book
		@book= Book.find(params[:id])
	end

	private

	def book_params
		params.require(:book).permit(:title, :text, :attachment)
	end

end

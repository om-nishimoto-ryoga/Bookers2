class BooksController < ApplicationController
	before_action :authenticate_user!

 def index
 	@user = current_user
 	@book = Book.new
 	@books = Book.all
 end

 def show
 	@book = Book.find(params[:id])
 	@user = @book.user
 	@book_form = Book.new
 end

 def create
 	@book = Book.new(book_params)
 	@book.user_id = current_user.id
 	if @book.save
 	   redirect_to book_path(@book.id), notice: "Book was successfully created."
    else
    	flash[:notice] = "error"
       redirect_to books_path
    end
 end

 def edit
 	@book = Book.find(params[:id])
 	if @book.user_id != current_user.id
 	   flash[:notice] = "error."
 	   redirect_to books_path
 	end
 end

 def update
 	@book = Book.find(params[:id])
 	if @book.update(book_params)
 	redirect_to book_path(@book.id), notice: "Book was successfully updated."
 else
 	flash[:notice] = "error."
	render("books/edit")
 end
end

 def destroy
 	@book = Book.find(params[:id])
 	@book.destroy
 	redirect_to books_path
 end

 private

 def book_params
 	params.require(:book).permit(:title, :body)
 end

end

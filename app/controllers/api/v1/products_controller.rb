class Api::V1::ProductsController < ApplicationController
	before_action :find_product, only: [:find, :show, :update, :destroy]

	def hello_world
		render json:{message: 'Hello API'}
	end

	def list
		#render json:Product.all.order(id: :asc)
		products = Product.all
		render json: products, status: :ok
	end

	def index
		products = Product.all
		render json: products, status: :ok
	end

	def create
		product = Product.new(products_params)
		#product.name = params[:name]
		#product.quantity = params[:quantity]

		if product.save
			#render json: product
			render json: product, status: :created and return
		elsif product.has_nil_fields
			error_status = :bad_request
		else
			error_status = :unprocessable_entity
		end

		render json: {message: 'Product not saved', errors: product.errors}, status: error_status
		#else
			#render json: {"error": "product could'n be saved"}
			#render json: {"errors": product.errors}
		#end
	end

	def destroy
		#product = Product.find_by_id(params[:id])
		if @product.nil?
			render json: {message: 'Product not found'}, status: :not_found
		else
			@product.destroy
		end
	end

	def find
		#render json: Product.find_by_id(params[:id])
		#product = Product.find_by_id(params[:id])

		if @product.nil?
			render json: {message: "Product not found"}, status: :not_found
		else
			render json: @product, status: :ok
		end
	end

	def show
		if @product.nil?
			render json: {message: "Product not found"}, status: :not_found
		else
			render json: @product, status: :ok
		end
	end

	def update
		#product = Product.find_by_id(params[:id])
		#@product.name = params[:name]
		#@product.quantity = params[:quantity]

		if @product.update(products_params)
			render json: @product, status: :ok and return
		elsif @product.has_nil_fields
			error_status = :bad_request
		elsif
			error_status = :unprocessable_entity
		end

		render json: {message: 'Product not updated', errors: @product.errors}, status: error_status

		#product.save

		#render json: product
	end

	private
	def find_product
		@product = Product.find_by_id(params[:id])
	end

	def products_params
		params.permit(:name, :quantity)
	end
end

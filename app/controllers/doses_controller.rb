class DosesController < ApplicationController
    def new
      @cocktail = Cocktail.find(params[:cocktail_id])  
      @dose = Dose.new
    end
  
    def create
      @cocktail = Cocktail.find(params[:cocktail_id])
      @dose = Dose.new(dose_params)
      @dose.cocktail = @cocktail
      @doses = @cocktail.doses
      unless params[:dose][:ingredient_id] == ""
        @ingredient = Ingredient.find(params[:dose][:ingredient_id])
        @dose.ingredient = @ingredient
      end

      if @dose.save
        # handle a successful save
        redirect_to cocktail_path(@cocktail), notice: 'Dose was successfully added.'
      else
        # handle when it doesn't save
        render template: 'cocktails/show'
      end
    end

    def destroy
      @dose = Dose.find(params[:id])
      @dose.destroy

      redirect_to cocktail_path(@dose.cocktail)
    end
  
    private
  
    def dose_params
      params.require(:dose).permit(:description, :ingredient)
    end
end

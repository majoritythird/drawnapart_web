class Api::V1::PeopleController < Api::V1::ApiController

  def show
    person = Person.find_by_id(params[:id])
    respond_with person
  end

end

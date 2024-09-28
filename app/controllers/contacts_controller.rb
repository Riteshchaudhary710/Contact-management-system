class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]

  def index
    if params[:query].present?
      @contacts = Contact.where("name LIKE ? OR email LIKE ? OR phone_number LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
                         .paginate(page: params[:page], per_page: 5)
    else
      @contacts = Contact.paginate(page: params[:page], per_page: 5).order("created_at DESC")
    end
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_path, notice: "Contact was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contacts_path, notice: "Contact was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy!

    respond_to do |format|
      format.html { redirect_to contacts_path, status: :see_other, notice: "Contact was successfully destroyed." }
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :phone_number, :email)
  end
end

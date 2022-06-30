# frozen_string_literal: true

ActiveAdmin.register AdminUser, as: 'Admins' do
  menu priority: 11
  permit_params :email, :name, :role, :status, :password, :password_confirmation, :image

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :status do |item|
      status_tag item.status
    end
    column :created_at
    actions
  end

  # filter :email
  # filter :role, as: :select
  # filter :status, as: :select
  # filter :current_sign_in_at
  # filter :sign_in_count
  # filter :created_at

  form do |f|
    f.inputs do
      f.input :image, as: :file
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    panel 'Admin Info' do
      columns do
        column span: 4 do
          attributes_table_for resource do
            row :name
            row :email
            row :status do
              status_tag resource.status
            end
          end
        end
        if resource.image.attached?
          column span: 1 do
            image_tag resource.image.variant(resize: '300x300'), class: 'width-100'
          end
        end
      end
    end
  end
end

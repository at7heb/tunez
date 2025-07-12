defmodule Tunez.Accounts do
  use Ash.Domain,
    otp_app: :tunez,
    extensions: [AshAdmin.Domain, AshGraphql.Domain, AshJsonApi.Domain]

  admin do
    show? true
  end

  graphql do
    mutations do
      create Tunez.Accounts.User, :register_user, :register_with_password
    end

    queries do
      get Tunez.Accounts.User, :sign_in_user, :sign_in_with_password do
        type_name :user_with_token
      end
    end
  end

  json_api do
    routes do
      base_route "/users", Tunez.Accounts.User do
        post :register_with_password, route: "/register"
      end
    end
  end

  resources do
    resource Tunez.Accounts.Token

    resource Tunez.Accounts.User do
      define :set_user_role, action: :set_user_role, args: [:role]

      define :get_user_by_id, action: :read, get_by: [:id]
    end
  end
end

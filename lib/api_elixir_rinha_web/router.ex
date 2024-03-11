defmodule ApiElixirRinhaWeb.Router do
  use ApiElixirRinhaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ApiElixirRinhaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/clientes", ApiElixirRinhaWeb do
    pipe_through :api

    resources "/", ClienteController, only: [:create]
    resources "/transacoes", TransacoesController, only: [:create]
    get "/:id/extrato", ClienteController, :extrato

    end

    scope "/", ApiElixirRinhaWeb do
      pipe_through :browser

      get "/", PageController, :home
    end

  end

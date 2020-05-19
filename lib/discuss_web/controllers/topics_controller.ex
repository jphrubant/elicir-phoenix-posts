defmodule DiscussWeb.TopicsController do
  use DiscussWeb, :controller

  alias Discuss.TEntries
  alias Discuss.TEntries.Topics

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    topic = TEntries.list_topic()
    render(conn, "index.html", topic: topic)
  end

  def new(conn, _params) do
    changeset = TEntries.change_topics(%Topics{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topics" => topics_params}) do
    case TEntries.create_topics(topics_params) do
      {:ok, topics} ->
        conn
        |> put_flash(:info, "Topics created successfully.")
        |> redirect(to: Routes.topics_path(conn, :show, topics))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topics = TEntries.get_topics!(id)
    render(conn, "show.html", topics: topics)
  end

  def edit(conn, %{"id" => id}) do
    topics = TEntries.get_topics!(id)
    changeset = TEntries.change_topics(topics)
    render(conn, "edit.html", topics: topics, changeset: changeset)
  end

  def update(conn, %{"id" => id, "topics" => topics_params}) do
    topics = TEntries.get_topics!(id)

    case TEntries.update_topics(topics, topics_params) do
      {:ok, topics} ->
        conn
        |> put_flash(:info, "Topics updated successfully.")
        |> redirect(to: Routes.topics_path(conn, :show, topics))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", topics: topics, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topics = TEntries.get_topics!(id)
    {:ok, _topics} = TEntries.delete_topics(topics)

    conn
    |> put_flash(:info, "Topics deleted successfully.")
    |> redirect(to: Routes.topics_path(conn, :index))
  end
end

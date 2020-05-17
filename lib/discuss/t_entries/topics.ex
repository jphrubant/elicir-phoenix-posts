defmodule Discuss.TEntries.Topics do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topic" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(topics, attrs) do
    topics
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end

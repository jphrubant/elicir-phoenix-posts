defmodule Discuss.TEntriesTest do
  use Discuss.DataCase

  alias Discuss.TEntries

  describe "topic" do
    alias Discuss.TEntries.Topics

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def topics_fixture(attrs \\ %{}) do
      {:ok, topics} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TEntries.create_topics()

      topics
    end

    test "list_topic/0 returns all topic" do
      topics = topics_fixture()
      assert TEntries.list_topic() == [topics]
    end

    test "get_topics!/1 returns the topics with given id" do
      topics = topics_fixture()
      assert TEntries.get_topics!(topics.id) == topics
    end

    test "create_topics/1 with valid data creates a topics" do
      assert {:ok, %Topics{} = topics} = TEntries.create_topics(@valid_attrs)
      assert topics.title == "some title"
    end

    test "create_topics/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TEntries.create_topics(@invalid_attrs)
    end

    test "update_topics/2 with valid data updates the topics" do
      topics = topics_fixture()
      assert {:ok, %Topics{} = topics} = TEntries.update_topics(topics, @update_attrs)
      assert topics.title == "some updated title"
    end

    test "update_topics/2 with invalid data returns error changeset" do
      topics = topics_fixture()
      assert {:error, %Ecto.Changeset{}} = TEntries.update_topics(topics, @invalid_attrs)
      assert topics == TEntries.get_topics!(topics.id)
    end

    test "delete_topics/1 deletes the topics" do
      topics = topics_fixture()
      assert {:ok, %Topics{}} = TEntries.delete_topics(topics)
      assert_raise Ecto.NoResultsError, fn -> TEntries.get_topics!(topics.id) end
    end

    test "change_topics/1 returns a topics changeset" do
      topics = topics_fixture()
      assert %Ecto.Changeset{} = TEntries.change_topics(topics)
    end
  end
end

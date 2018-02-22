require 'test_helper'

class EventListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_list = event_lists(:one)
  end

  test "should get index" do
    get event_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_event_list_url
    assert_response :success
  end

  test "should create event_list" do
    assert_difference('EventList.count') do
      post event_lists_url, params: { event_list: { event: @event_list.event, user: @event_list.user } }
    end

    assert_redirected_to event_list_url(EventList.last)
  end

  test "should show event_list" do
    get event_list_url(@event_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_list_url(@event_list)
    assert_response :success
  end

  test "should update event_list" do
    patch event_list_url(@event_list), params: { event_list: { event: @event_list.event, user: @event_list.user } }
    assert_redirected_to event_list_url(@event_list)
  end

  test "should destroy event_list" do
    assert_difference('EventList.count', -1) do
      delete event_list_url(@event_list)
    end

    assert_redirected_to event_lists_url
  end
end

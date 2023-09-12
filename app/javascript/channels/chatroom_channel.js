import consumer from "channels/consumer";

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('room-id');
  const room_id = element.getAttribute('data-room-id');
  console.log(room_id);
  console.log('hello')

  consumer.subscriptions.create({ channel: "ChatroomChannel", room_id: room_id }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // $("#message-container").append(data.mod_message);
      // $("#messages").scrollTop($("#messages")[0].scrollHeight);
      // $("#message_body").val("");
      // Called when there's incoming data on the websocket for this channel
    },
  });
});

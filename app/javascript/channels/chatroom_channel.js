import consumer from "channels/consumer";

const element = document.getElementById('room-id');
const room_id = element.getAttribute('data-room-id');

consumer.subscriptions.create({ channel: "ChatroomChannel", room_id: room_id }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    $("#message-container").append(data.mod_message);
    $("#messages").scrollTop($("#messages")[0].scrollHeight);
    document.getElementById("message-body").value = "";
  },
});

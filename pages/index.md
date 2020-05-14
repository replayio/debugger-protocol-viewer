---
layout: shell.hbs
title: Web Replay Protocol
version: tot
---
The <b>Web Replay Protocol</b> is used by tools to upload and inspect <a href="https://webreplay.io">Web Replay</a> recordings.

This protocol is preliminary and will change substantially over time.  Join the #protocol channel in our <a href="https://join.slack.com/t/webreplay/shared_invite/enQtOTgwOTI3MTQ3NTg4LTA3MTQ4ZWMwMzYwMWI4MzFhYjkyMDZhMjU4YmE0MDgxYTI5YTYxMmZiMzJiOTlkMDcwZGEyOTAyNjc2MGFmYTg">Slack</a> community for news and discussions.

<h3>Web Replay</h3>

The Web Replay browser is used to make complete recordings of a tab which capture all JS, DOM, and other behaviors.  These recordings are uploaded to Web Replay's cloud service, and clients can then connect to the cloud service and inspect the recordings.  Both uploading and inspecting are performed via the Web Replay Protocol.

The Web Replay Protocol is separate from the Web Replay browser itself and the format of its recordings.  Other ways to make recordings will be added in the future, and tools built on top of the Web Replay Protocol will be able to interact with any recording, regardless of how it was made.

<h3>Protocol Overview</h3>

The design of the Web Replay Protocol is based on the <a href="https://chromedevtools.github.io/devtools-protocol/">Chrome DevTools Protocol</a> (which is in turn based on <a href="https://www.jsonrpc.org/specification">JSON-RPC</a>).  Connections and messages are handled in very similar ways, and when appropriate, messages and values sent over the Web Replay Protocol are structured in the same way as in the Chrome DevTools Protocol.

To connect to the Web Replay cloud service, open a websocket connection to <code>wss://dispatch.webreplay.io</code>.  The protocol can then be used immediately, with no authentication (this will change soon).

The protocol is used by sending it requests over the websocket.  Requests are stringified JSON objects with the following properties:

<list>

<ul><code>id</code>: String or integer which is unique for this request among all requests made over the connection.</ul>

<ul><code>method</code>: Name of the method used for the request.</ul>

<ul><code>params</code>: Object containing any parameters for the request.  Keys in the object are the method's parameter names.  This may be omitted for requests with no parameters.</ul>

<ul><code>sessionId</code>: String identifying any associated session. This is required for methods in certain domains, and omitted for others.</ul>

<ul><code>pauseId</code>: String identifying any associated pause. This is required for methods in certain domains, and omitted for others.</ul>

</list>

The cloud service will respond to a request with a response object.  Responses are stringified JSON objects with the following properties:

<list>

<ul><code>id</code>: ID for the request being responded to, or <code>null</code> for requests whose ID could not be determined.</ul>

<ul><code>result</code>: Object containing the request's return values.  This is always included for requests that succeeded.  Keys in the object are the method's return value names.</ul>

<ul><code>error</code>: Error description object.  This is always included for requests that failed.  This has an integral <code>code</code> property, string <code>message</code> property, and optional <code>data</code> property which describe the error.</ul>

</list>

When uploading recordings, binary data messages can be sent over the protocol instead of a string request.  See the <code>Internal</code> domain for details on this.

Events can be emitted by the cloud service which are not responses to a message.  Events are stringified JSON objects with the following properties:

<list>

<ul><code>method</code>: Name of the event being emitted.</ul>

<ul><code>params</code>: Object containing any parameters for the event.  Keys in the object are the event's parameter names.  This may be omitted for events with no parameters.</ul>

<ul><code>sessionId</code>: String identifying any associated session. This is used for events in certain domains, and omitted for others.</ul>

</list>


## Computer Networking 

Computer networking is the practice of connecting computers and other devices so they can share data, resources, and services over local or global distances. A global collection of interconnected networks forms the internet.

### What Is a Computer?

A computer is an electronic machine that processes input data according to instructions and produces useful output. It is widely used for education, training, business, communication, and entertainment.

### What Is a Network?

A computer network is a group of interconnected computers and devices that can communicate and share resources (files, printers, internet connection) using networking hardware and protocols.

---

## How the Internet Works 

1. Your device sends data using networking protocols (like HTTP over TCP/IP).
2. The data passes through your local network (router/modem).
3. Your Internet Service Provider (ISP) forwards the data across many intermediate networks and routers.
4. The data eventually reaches the destination server, which sends a response back along a similar path.

---

## Basic Networking Terms

### Server

A server is a computer or program that provides services or resources to other computers (clients) over a network, such as web pages, files, or databases.

### Protocol

A protocol is a set of rules that define how data is formatted, transmitted, and received over a network.

---

## Common Protocols

- **TCP (Transmission Control Protocol)**  
  Ensures reliable, ordered, and error-checked delivery of data between applications. It aims for 100% correct data delivery and will retransmit lost packets.

- **UDP (User Datagram Protocol)**  
  Provides fast, connectionless communication without guaranteed delivery or ordering. Some data may be lost, but latency is lower. Often used for streaming, gaming, and real-time apps.

- **HTTP (Hypertext Transfer Protocol)**  
  Application-layer protocol used by web browsers and web servers in the client–server architecture to transfer web pages and related resources.

---

## Checking Your IP Address

- Tools such as `ifconfig` (Linux/macOS) or `ipconfig` (Windows) show your network configuration.
- Online services like `ifconfig.me` can show your public IP address in a browser or via command line.

Example (Linux terminal):

```bash
curl ifconfig.me
```

### Data Flow 
ISP to Your Device
Typical path when data is transferred:

### ISP (Internet Service Provider)
Connects your home/office network to the wider internet.

### **Modem**
Converts signals from your ISP’s medium (cable, DSL, fiber) into digital signals for your local network.

### **Router**
Assigns local IP addresses to devices in your network (via DHCP).
Forwards traffic between your local network and the internet.

### **Local Device** (PC, phone, etc.)
Sends and receives data using its local IP address and specific port numbers.

### IP Address and Port Number
**IP Address:** Identifies a device on a network (like a house address).

**Port Number:** Identifies a specific application or service on that device (like an apartment number in that house).

Together they are often written as **IP:port (for example, 192.168.1.10:80).**

### Port Number Ranges (16-bit number: 0–65535)
- 0–1023: Well-known / System Ports
  Reserved for common services (HTTP 80, HTTPS 443, SSH 22, etc.); not used for arbitrary personal apps.

- 1024–49151: Registered Ports
  Assigned for specific applications and services by organizations.

- 49152–65535: Dynamic / Private Ports
  Typically used for temporary client-side connections; you can freely use these for custom apps.

#### Types of Networks
- LAN (Local Area Network)
   Covers a small area such as a home, office, or campus building.

- MAN (Metropolitan Area Network)
   Spans a city or large campus, connecting multiple LANs within that region.

- WAN (Wide Area Network)
   Covers large geographic areas, such as countries or continents. The internet is the largest WAN.
   Often uses long-distance communication technologies like optical fiber and standards such as SONET (Synchronous Optical Network).

### Networking Devices
#### Modem
Converts digital signals from your computer/network into analog (or another form) compatible with your ISP’s medium, and vice versa.

Connects your local network to the ISP.

#### Router
Forwards packets between different networks (e.g., between your LAN and the internet).

Chooses the best path for data and often provides features like NAT, DHCP, and firewalling.

## Network Topologies
A topology describes how computers and devices are arranged and connected in a network.

### Bus Topology

All devices share a single central cable (backbone).

Simple and cheap, but a fault in the main cable can bring down the whole network and collisions are common.

### Ring Topology

Each device is connected to exactly two others, forming a ring.

Data travels in one direction (or both in dual-ring).

If a cable breaks or a node fails (in a simple ring), the entire network can fail.

### Star Topology

All devices connect to a central device (hub or switch).

Easy to manage and isolate faults.

If the central device fails, the whole network fails.

### Tree Topology

Hierarchical structure that combines characteristics of star and bus topologies.

Groups of star-configured networks connected to a main linear bus.

Scalable, but backbone failure can affect large parts of the network.

### Mesh Topology

Every node is connected to some or all other nodes.

Provides high redundancy and reliability (multiple paths between nodes).

More cabling and higher cost, but very resilient to failures.

## Structure of Networking

Modern computer networking is often explained using layered models. The most common are the **OSI model** (theoretical 7-layer model) and the **TCP/IP model** (practical model used on the internet).

---

## OSI Model – How the Internet Works

The Open Systems Interconnection (OSI) model has 7 layers. Data moves from the top (application) down to the physical medium at the sender, and the reverse at the receiver.

### 7 Layers of OSI

1. **Application Layer (Layer 7)**  
   - Closest to the end user.  
   - Provides network services to applications such as web browsers, email clients, FTP tools, etc.  
   - Examples: HTTP, HTTPS, FTP, SMTP, POP3, DNS.

2. **Presentation Layer (Layer 6)**  
   - Translates data between application format and network format.  
   - Handles **data representation** (text, images, video), **encryption/decryption**, **compression/decompression**.  
   - Makes sure data is in a usable format for the application.

3. **Session Layer (Layer 5)**  
   - Establishes, manages, and terminates sessions between applications.  
   - Handles **authentication**, **authorization**, and **session management** (start, maintain, end connections).

4. **Transport Layer (Layer 4)**  
   - Provides end-to-end communication between hosts.  
   - Responsible for **segmentation**, **reassembly**, **error control**, **flow control**.  
   - Uses protocols like:
     - **TCP (Transmission Control Protocol)**: reliable, connection-oriented.
     - **UDP (User Datagram Protocol)**: faster, connectionless, no guarantee of delivery.

5. **Network Layer (Layer 3)**  
   - Handles **logical addressing** and **routing** between different networks.  
   - Decides the path that data will take through routers to reach the destination.  
   - Main protocol: **IP (Internet Protocol)**.

6. **Data Link Layer (Layer 2)**  
   - Provides **node-to-node** communication on the same network segment.  
   - Uses **MAC addresses** for physical addressing.  
   - Responsible for **framing**, **error detection** on a single link, and **access control** to the medium.  
   - Divided into:
     - Logical Link Control (LLC)  
     - Media Access Control (MAC)

7. **Physical Layer (Layer 1)**  
   - Deals with the actual transmission of bits (0s and 1s) over the physical medium.  
   - Includes cables, connectors, network interface cards, electrical/optical signals, radio signals, etc.

---

## TCP/IP Model (Internet Protocol Suite)

The TCP/IP model is the practical model used on the internet. It combines some OSI layers.

Typical 5-layer view:

1. **Application Layer**  
   - Combines OSI Application, Presentation, and Session layers.  
   - Includes protocols like HTTP, HTTPS, FTP, SMTP, POP3, DNS, SSH, DHCP, etc.

2. **Transport Layer**  
   - Similar to OSI Transport layer.  
   - Provides end-to-end communication using **TCP** or **UDP**.

3. **Internet / Network Layer**  
   - Similar to OSI Network layer.  
   - Handles routing and logical addressing using **IP**.

4. **Data Link Layer**  
   - Similar to OSI Data Link layer.  
   - Uses MAC addresses and handles framing and local delivery.

5. **Physical Layer**  
   - Same idea as OSI Physical layer.  
   - Deals with actual bits on the wire or wireless medium.

Client–server communication on the internet usually follows this pattern:

- **Client** sends a request (e.g., HTTP request)  
- **Server** processes the request and sends back a response

---

## Networking Devices (Layered View)

### Repeater

- Operates at the **Physical layer (Layer 1)**.  
- Regenerates and amplifies weak signals so they can travel further on the same network.

### Hub

- Also at **Physical layer (Layer 1)**.  
- A **multiport repeater**: copies incoming bits to all other ports.  
- Types:
  - **Active Hub**: has its own power supply and can regenerate signals.  
  - **Passive Hub**: only forwards signals; does not regenerate them.

### Bridge

- Operates at the **Data Link layer (Layer 2)**.  
- Connects two LAN segments and filters traffic by reading **MAC addresses**.  
- Forwards or blocks frames based on destination MAC to reduce unnecessary traffic.

### Switch

- Also at the **Data Link layer (Layer 2)** (many modern switches also have Layer 3 features).  
- A **multiport bridge** with buffering and higher performance.  
- Builds a MAC address table and forwards frames only to the correct port, improving efficiency.

### Gateway

- Operates at **multiple layers**, typically up to the **Application layer**.  
- Connects networks using **different protocols or architectures**.  
- Translates data between different network models or protocol suites (e.g., IPv4 to IPv6, HTTP to another application protocol).

---

## Common Protocol Groups

### TCP/IP-based Application Protocols (over TCP)

- **HTTP / HTTPS**: Web browsing.  
- **FTP**: File transfer.  
- **SMTP**: Sending email.  
- **POP3 / IMAP**: Receiving email.  
- **SSH**: Secure remote login.  
- **DHCP**: Dynamic IP address configuration.

### UDP

- **Connectionless**, stateless communication.  
- Used where **speed is more important than reliability** (streaming, VoIP, gaming, DNS queries).

---

## Processes, Threads, Sockets, and Ports

- **Process**: A running instance of a program (e.g., your video editor running).  
- **Thread**: A lighter-weight unit inside a process, can run multiple tasks in parallel (e.g., one thread records video, another handles UI).  
- **Socket**: Software endpoint that enables communication between processes across the network. It is the interface between a process and the transport layer (TCP/UDP). Often represented as `IP address + port`.  
- **Port**: Identifies which **application/service** on a device is sending or receiving data (e.g., port 80 for HTTP).

**Ephemeral ports**:  
- Temporary ports used mainly on the **client side** for outgoing connections.  
- Dynamically assigned by the OS from a configurable high-number range.

---

## HTTP Methods

Common HTTP request methods:

- **GET**: Fetch data from the server (no body or minimal body).  
- **POST**: Send data to the server to create or process a resource.  
- **PUT**: Send data to **create or completely replace** a resource at a specific URL.  
- **DELETE**: Remove a resource on the server.  

(There are more methods like PATCH, HEAD, OPTIONS, but these are the basics.)

---

## HTTP Status Codes (High Level)

- **1xx – Informational**: Request received, continuing process.  
- **2xx – Success**: Request successfully processed (e.g., 200 OK).  
- **3xx – Redirection**: Further action needed (e.g., another URL).  
- **4xx – Client Error**: Problem in the request (wrong URL, bad data, unauthorized, etc.).  
- **5xx – Server Error**: Server failed to process a valid request.

---

## Cookies

- **Cookie**: A small unique string of data stored in the client’s browser by a website.  
  - Used for sessions, preferences, tracking, etc.  
  - Set via HTTP responses and sent back in subsequent requests to the same site.

- **Third-party cookies**:  
  - Cookies set by domains **other than the one you are directly visiting** (e.g., ad or analytics domains embedded on the page).  
  - Used mainly for cross-site tracking and advertising.

---

## How Email Works (High Level)

At the application level, email relies on protocols built on top of TCP/IP:

- **SMTP (Simple Mail Transfer Protocol)**: Used to **send** email between clients and mail servers, and between mail servers.  
- **POP3 / IMAP**: Used by clients to **retrieve** email from their mail servers.

Simple flow:

1. **Sender** composes an email in a client (e.g., Gmail, Outlook).  
2. The client sends the email to the **sender’s SMTP server**.  
3. The sender’s SMTP server forwards the email to the **receiver’s mail server** (using SMTP).  
4. The receiver uses **POP3 or IMAP** to access and download/view the email from their mail server.

## DNS (Domain Name System)

- DNS is an **application-layer** service that translates human-readable domain names (like `example.com`) into IP addresses.
- This lets users type names instead of remembering numeric IPs.

---

## Work of OSI vs TCP/IP Layers (Short View)

- **Application (OSI 5–7 vs TCP/IP Application)**: User-facing protocols (HTTP, DNS, SMTP).
- **Transport**: End-to-end delivery, ports, TCP/UDP, reliability, congestion control.
- **Network (Internet)**: Logical addressing (IP), routing between networks.
- **Data Link**: MAC addressing, framing, local delivery on a link.
- **Physical**: Bits, signals, cables, NICs.

---

## Transport Layer – Key Responsibilities

- Provides **end-to-end** communication between processes on different hosts.
- Uses **ports** to identify applications (sockets = IP + port).
- **Multiplexing**: Many applications on one host share a single network connection.
- **Demultiplexing**: At the receiver, data is delivered to the correct application based on port numbers.
- Adds **headers** with source port, destination port, and other control info.
- Handles **congestion control** (mainly TCP), **error control**, and sometimes **flow control**.
- Data unit name: **Segment**.

Note:  
- If communication is between processes on **different devices**, Transport + Network + lower layers work together.  
- If between processes on the **same device**, the OS can route internally but still uses transport concepts (ports, sockets).

---

## UDP (User Datagram Protocol)

- Connectionless, **no handshake**, very low overhead.
- No guarantee of delivery, ordering, or retransmission.
- Used where speed and low latency are more important than reliability (DNS queries, gaming, streaming, VoIP).

### UDP Segment Format (simplified)

- **Source Port (16 bits)**  
- **Destination Port (16 bits)**  
- **Length (16 bits)** – length of UDP header + data  
- **Checksum (16 bits)** – basic error detection  
- **Data**

Tools like `tcpdump` or `wireshark` can capture and show UDP packets.

---

## TCP (Transmission Control Protocol)

- Connection-oriented, **reliable** transport protocol.
- Runs at the **Transport layer**.
- Provides:
  - **Connection establishment** and termination
  - **Error control** (retransmissions)
  - **In-order delivery**
  - **Congestion control** (built-in algorithms)
  - **Flow control**
  - **Full-duplex** communication (both sides send simultaneously)

### Three-Way Handshake (Connection Setup)

1. **Client → Server: SYN**  
   - Client sends a segment with SYN flag to start a connection.

2. **Server → Client: SYN + ACK**  
   - Server replies with SYN and ACK to acknowledge and propose its own sequence.

3. **Client → Server: ACK**  
   - Client sends final ACK.  
   - Connection is established; data transfer can start.

---

## Reliability Tools in TCP

- **Checksum**:  
  - A value computed over the header and data to detect corruption.  
  - If mismatch, segment is discarded and may be retransmitted.

- **Timers / Retransmission Timer**:  
  - If an ACK is not received within a timeout, TCP retransmits the segment.

---

## Data Unit Names per Layer

- **Transport Layer**: Segment (TCP segment / UDP datagram)  
- **Network Layer**: Packet (IP packet)  
- **Data Link Layer**: Frame  
- **Physical Layer**: Bits

---

## Routing Concepts

- **Routing table**:  
  - Data structure used by routers to decide the next hop for each destination network.

- **Forwarding**:  
  - Actual action of sending a packet to the next hop based on the routing table.

- **Hop-by-hop**:  
  - Each router makes an independent decision and forwards the packet to the next router.

- **Control plane**:  
  - Part of a router that builds and maintains the routing table (often using routing protocols).  
  - Routers = nodes, links = edges in the network graph.

### Types of Routing

- **Static routing**:  
  - Routes configured manually by an admin.  
  - Simple but not scalable, no automatic adaptation.

- **Dynamic routing**:  
  - Routes updated automatically using routing protocols.  
  - Adapts to topology changes and link failures.

---

## Internet Protocol (IP)

- Main protocol at the **Network layer**; defines how packets are addressed and routed across networks.

### IPv4

- **32-bit** address, usually written as four decimal numbers (0–255), e.g., `192.168.2.30`.  
- Divided logically into **network** part and **host** part (can be expressed using subnet masks/CIDR).

### IPv6

- **128-bit** address, written as eight groups of hexadecimal numbers separated by colons.  
- Provides a much larger address space and built-in features like better support for autoconfiguration and security.  
- Also split into **network prefix** (similar to subnet) and **interface ID (host part)**.

> You can also study classful IPv4 addressing (Classes A, B, C, D, E) and their ranges, though modern networks mostly use CIDR (classless).

### TTL (Time To Live)

- A field in the IP header that limits how long a packet can stay in the network.  
- Decremented by 1 at each router; when it reaches 0, the packet is discarded.  
- Prevents packets from looping forever.

---

## Middleboxes

- Devices in the network that **process IP packets beyond simple routing**.  
- Examples: firewalls, NAT devices, load balancers, proxies.

---

## Firewalls

- Security devices (or software) that sit between **trusted networks** and untrusted networks (like the public internet).  
- Filter IP packets based on rules (IP, ports, protocols, state).

### Types

- **Stateless firewall**:  
  - Makes decisions based only on the current packet (no memory of previous packets).

- **Stateful firewall**:  
  - Tracks active connections in a **state table** (cache of connection info).  
  - Can allow return traffic for an established connection automatically.

---

## Network Address Translation (NAT)

- Technique that maps **private IP addresses** inside a LAN to one or a few **public IP addresses**.  
- Helps slow down the consumption of public IPv4 addresses.  
- Also acts as a basic security layer by hiding internal addresses.

---

## Data Link Layer (DLL) – More Detail

- Responsible for communication between **directly connected** devices.  
- Uses **MAC addresses** as Data Link (hardware) addresses.

### Key Functions

- **Framing**:  
  - Encapsulates network-layer packets into frames with headers and trailers.

- **Error Detection**:  
  - Adds codes like CRC in the trailer to detect errors on the link.

- **Address Resolution Protocol (ARP)**:  
  - Maps an IPv4 address to a MAC address on the same network segment.  
  - When a host knows the IP but not the MAC, it broadcasts an ARP request and learns the MAC from the ARP reply.

- **Media access control**:  
  - Decides how multiple devices share the same medium (e.g., Ethernet CSMA/CD, Wi-Fi CSMA/CA).

## Types of Switching

- **Circuit Switching**: A dedicated path is reserved between sender and receiver for the entire session (e.g., traditional telephone networks).
- **Packet Switching**: Data is broken into packets; each packet can take different routes (used in the internet).
- **Message Switching**: Entire messages are stored and forwarded at intermediate nodes (store-and-forward, high delay).

---

## Error Detection and Flow Control (Data Link & Transport)

- **Error Detection**: Techniques like parity bits, checksums, and CRC detect corrupted frames/segments.
- **Error Control**: Retransmission strategies (ARQ: Stop-and-Wait, Go-Back-N, Selective Repeat) ensure reliable delivery.
- **Flow Control**: Prevents fast senders from overwhelming slow receivers (e.g., sliding window, TCP window size).

---

## VLANs (Virtual LANs)

- Logically divide a physical switch into multiple separate LANs.
- Improve security and reduce broadcast traffic by isolating groups of devices.
- Require VLAN-aware switches and often routers (or Layer 3 switches) to route between VLANs.

---

## Wireless Networking Basics

- **Wi‑Fi (WLAN)** uses radio waves instead of cables to connect devices to a LAN.
- Uses an **Access Point (AP)** to connect wireless clients to a wired network.
- Uses standards like IEEE 802.11 (a/b/g/n/ac/ax) with different speeds and frequencies.

---

## Network Security Concepts (Intro)

- **Encryption**: Protects data confidentiality in transit (e.g., HTTPS uses TLS).
- **VPN (Virtual Private Network)**: Creates an encrypted tunnel over a public network to reach a private network.
- **IDS/IPS**: Intrusion Detection/Prevention Systems monitor traffic for attacks.

---

## Basic Troubleshooting Tools

- **ping**: Tests reachability and round-trip time to another host.
- **traceroute / tracert**: Shows the path packets take through routers.
- **nslookup / dig**: Queries DNS records.
- **netstat / ss**: Shows active connections and listening ports.
- **tcpdump / Wireshark**: Capture and analyze packets on the network.



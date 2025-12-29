# RouterOS Dual WAN, Hotspot, CAKE QoS, Failover & Load Balancer Configuration

## Why This Exists

The paywall situation in networking is real. There are tons of people gatekeeping RouterOS knowledge and scripts behind subscriptions when so much of it could just... be shared. I went through the grind of researching, testing, debugging, and getting it all to work together seamlessly. Now I'm putting this back out there so the next person doesn't have to suffer through scattered forums, incomplete docs, and fragmented solutions.

If this setup saves you time and headaches, consider dropping a coffee my way at [Ko-Fi](https://ko-fi.com/sujirou). Every bit helps keep projects like this alive. 💙

---

## What You're Getting

This is a **production-ready RouterOS configuration** that ties together:

- **Dual WAN Failover** – Automatically switches between PLDT and Starlink if one goes down
- **PPPoE Configuration** – For ISP connections that require PPPoE authentication
- **Hotspot Management** – Built-in user authentication and bandwidth isolation
- **PCC-Based Load Balancing** – Intelligently distributes traffic across both WANs using Per-Connection-Classifier (RouterOS v7)
- **CAKE Bandwidth Management** – Advanced queue discipline that optimizes traffic flow, reduces latency, and prevents bufferbloat (think fq_codel on steroids)
- **Trunk/Management Network** – Separate network for admin access and critical services

All of this works together as one cohesive system, not scattered pieces you have to Frankenstein together.

---

## Prerequisites

Before you dive in, make sure you've got:

- **RouterOS v7** (this config uses PCC and CAKE features specific to v7+)
- **Two WAN interfaces** ready to go (this example uses ether1 and ether2)
- **Basic familiarity** with RouterOS terminal or WebFig interface
- **A backup** of your current config (seriously, always backup first)

---

## Network Setup (Default Configuration)

This config assumes the following network layout. You'll need to adapt it to your actual ISP subnets and devices:

| Interface | Purpose | Subnet | Notes |
|-----------|---------|--------|-------|
| ether1 | WAN - PLDT | 192.168.160.0/24 | Primary WAN |
| ether2 | WAN - Starlink | 192.168.170.0/24 | Failover WAN |
| PPPoE Users | LAN - Hotspot/Users | 10.10.202.0/24 | End users connect here |
| Hotspot | LAN - Hotspot Portal | 10.10.201.0/24 | Guest access with auth |
| Management | LAN - Trunk/Admin | 10.10.100.0/24 | Router admin & critical services |

---

## How to Use This

1. **Read through the script** – Even before importing, understand what each section does. This makes debugging way easier if something doesn't work perfectly in your environment.

2. **Adapt to your network** – Your ISP subnets, device names, and internal networks will be different. The script will be heavily commented so you know exactly what to change.

3. **Test in stages** – Don't just drop the whole thing and hope. Test failover, hotspot auth, and load balancing individually before running everything together.

4. **Monitor and tweak** – CAKE and PCC settings might need fine-tuning based on your actual traffic patterns and WAN speeds.

---

## Customizing for Your Setup

The beauty of sharing this openly is that it becomes a foundation, not a cage. Here's the mindset:

- **Your ISP subnets are different?** Swap out the 192.168.160.0 and 192.168.170.0 ranges with your actual ones.
- **Different number of LANs?** The structure is modular—you can add or remove networks.
- **Bandwidth limits different?** CAKE and queue rules scale to whatever speeds you've got.
- **Only one WAN?** You can still use the hotspot, load balancer, and QoS parts independently.

Don't be afraid to dig in and modify. This config is meant to be adapted, learned from, and improved.

---

## Support & Feedback

If something breaks, doesn't work as expected, or you've got a killer improvement, let me know. If you found this helpful and want to support more open-source networking content, hit up my [Ko-Fi](https://ko-fi.com/devnull).

Happy routing! 🚀

From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Wed, 08 Jun 2011 14:42:28 +0000
Subject: [2.6.39] WARNING: at mm/page_alloc.c
Message-Id: <4DEF8A54.6020705@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have upgraded my blade 2000/smp from 2.6.32 to 2.6.39 kernel 
yesterday and this server stops to answer on its console. I have 
rebooted and found in /var/log/syslog :

Jun  8 16:17:06 rayleigh kernel: ------------[ cut here ]------------
Jun  8 16:17:06 rayleigh kernel: WARNING: at mm/page_alloc.c:2032
__alloc_pages_nodemask+0x148/0x720()
Jun  8 16:17:06 rayleigh kernel: Modules linked in: openpromfs 
xt_multiport tcp_diag inet_diag snd_hrtimer xt_mark iptable_mangle 
ipt_MASQUERADE iptable_nat xt_state xt_tcpudp iptable_filter ip_tables 
x_tables parport_pc lp parport af_packet cpufreq_stats cpufreq_powersave 
cpufreq_conservative cpufreq_userspace
nfsd nfs lockd fscache nfs_acl sunrpc fuse raid456 async_pq async_xor 
xor async_memcpy async_raid6_recov raid6_pq async_tx nf_nat_ftp nf_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack_ftp nf_conntrack loop 
usbhid hid usblp pl2303 st ch sg sr_mod cdrom snd_sun_cs4231 snd_pcm_oss 
snd_mixer_oss snd_pcm option snd_seq_dummy usb_wwan snd_seq_oss 
snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq usbserial snd_timer 
snd_seq_device mptspi snd mptscsih firewire_ohci sungem ohci_hcd 
soundcore mptbase 3c59x sym53c8xx snd_page_alloc firewire_core riowd bbc 
flash ehci_hcd crc_itu_t sungem_phy mii
unix
Jun  8 16:17:06 rayleigh kernel: Call Trace:
Jun  8 16:17:06 rayleigh kernel: [00000000004c1ac8]
__alloc_pages_nodemask+0x148/0x720
Jun  8 16:17:06 rayleigh kernel: [00000000004c0f68] 
__get_free_pages+0x8/0x40
Jun  8 16:17:06 rayleigh kernel: [00000000004f5958]
__kmalloc_node_track_caller+0x18/0x140
Jun  8 16:17:06 rayleigh kernel: [00000000006c3a8c] __alloc_skb+0x4c/0x120
Jun  8 16:17:06 rayleigh kernel: [00000000006c4eb4] 
__netdev_alloc_skb+0x14/0x60
Jun  8 16:17:06 rayleigh kernel: [00000000100456d0] boomerang_rx+0x3f0/0x5a0
[3c59x]
Jun  8 16:17:06 rayleigh kernel: [0000000010047430]
boomerang_interrupt+0x210/0x3a0 [3c59x]
Jun  8 16:17:06 rayleigh kernel: [00000000004a3b80]
handle_irq_event_percpu+0x60/0x1a0
Jun  8 16:17:06 rayleigh kernel: [00000000004a3cf0] 
handle_irq_event+0x30/0x60
Jun  8 16:17:06 rayleigh kernel: [00000000004a65f0]
handle_fasteoi_irq+0x90/0x120
Jun  8 16:17:06 rayleigh kernel: [000000000042a7dc] handler_irq+0xbc/0x100
Jun  8 16:17:06 rayleigh kernel: [00000000004208b4] tl0_irq5+0x14/0x20
Jun  8 16:17:06 rayleigh kernel: [000000000043a43c] 
touch_nmi_watchdog+0x5c/0xc0
Jun  8 16:17:06 rayleigh kernel: [000000000042c534] cpu_idle+0x74/0x160
Jun  8 16:17:06 rayleigh kernel: [00000000008b2804] start_kernel+0x318/0x328
Jun  8 16:17:06 rayleigh kernel: [000000000074e59c] tlb_fixup_done+0x98/0xbc
Jun  8 16:17:06 rayleigh kernel: ---[ end trace cbaa4d66fc5e5778 ]---
Jun  8 16:17:06 rayleigh kernel: eth1: memory shortage

	Just after these lines, system has crashed. 2.6.32 works like a charm, 
thus I'll downgrade kernel.

	Regards,

	JB

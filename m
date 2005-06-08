From: Turbo Fredriksson <turbo@swe.net>
Date: Wed, 08 Jun 2005 07:34:00 +0000
Subject: ipt_recent && spamd (!?) && kernel panic
Message-Id: <87oeahuwt3.fsf@pumba.bayour.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

--=-=-
I've been trying the ipt_recent driver/module (?) and after
just a few minutes, the machine (a Sun Blade 1000 - 2x750MHz,
1Gb mem) receives (?) a kernel panic.

Does anyone have an idea what the problem can be, and/or what
to do about it? The kernel is 2.6.12-rc3, SPARC64.


I'm not exactly sure WHERE the problem is (the panic mentions
spamd - spamassassin daemon), but I can't see what that can
do to cause this:

----- s n i p -----
Jun  5 12:19:33 aurora kernel: Unable to handle kernel paging request at virtual address 00000001400c6000
Jun  5 12:19:33 aurora kernel: tsk->{mm,active_mm}->context = 00000000000001e8
Jun  5 12:19:33 aurora kernel: tsk->{mm,active_mm}->pgd = fffff80037cba000
Jun  5 12:19:34 aurora kernel:               \|/ ____ \|/
Jun  5 12:19:34 aurora kernel:               "@'/ .. \`@"
Jun  5 12:19:34 aurora kernel:               /_| \__/ |_\
Jun  5 12:19:34 aurora kernel:                  \__U_/
Jun  5 12:19:34 aurora kernel: spamd(18649): Oops [#1]
Jun  5 12:19:34 aurora kernel: TSTATE: 0000000011009600 TPC: 000000000050a59c TNPC: 000000000050a5a0 Y: 00000000    Not tainted
Jun  5 12:19:34 aurora kernel: TPC: <__bzero+0x84/0xc0>
Jun  5 12:19:34 aurora kernel: g0: 0000000002056c00 g1: 0000000000000010 g2: 00000000d4bc183e g3: 0000000002062e48
Jun  5 12:19:34 aurora kernel: g4: fffff8003333d320 g5: fffff80000354000 g6: fffff800350d4000 g7: 00000000ffffffff
Jun  5 12:19:34 aurora kernel: o0: 00000001400c5fe0 o1: 0000000000000000 o2: 0000000000000000 o3: 00000001400c5fe0
Jun  5 12:19:34 aurora kernel: o4: 0000000000000040 o5: 0000000000000002 sp: fffff800350d64f1 ret_pc: 0000000002060f2c
Jun  5 12:19:34 aurora kernel: RPC: <match+0x7ac/0x960 [ipt_recent]>
Jun  5 12:19:34 aurora kernel: l0: 00000001400927f8 l1: 00000000000007f8 l2: 00000001400c8000 l3: 0000000140092000
Jun  5 12:19:34 aurora kernel: l4: 000000000000003e l5: 00000000000000f8 l6: 00000000d4d64632 l7: 000000014008e000
Jun  5 12:19:34 aurora kernel: i0: 0000000000000033 i1: 0000000102d21888 i2: 00000001400cc000 i3: 000000014016c888
Jun  5 12:19:34 aurora kernel: i4: 000000000000003e i5: 0000000000000040 i6: fffff800350d65c1 i7: 000000000203a304
Jun  5 12:19:34 aurora kernel: I7: <ipt_do_table+0x2c4/0x5c0 [ip_tables]>
Jun  5 12:19:34 aurora kernel: Caller[000000000203a304]: ipt_do_table+0x2c4/0x5c0 [ip_tables]
Jun  5 12:19:34 aurora kernel: Caller[00000000005a3a8c]: nf_iterate+0x4c/0xe0
Jun  5 12:19:34 aurora kernel: Caller[00000000005a3ed0]: nf_hook_slow+0x90/0x1a0
Jun  5 12:19:34 aurora kernel: Caller[00000000005b02c0]: ip_local_deliver+0x60/0x3a0
Jun  5 12:19:34 aurora kernel: Caller[00000000005b0ab0]: ip_rcv+0x4b0/0x700
Jun  5 12:19:34 aurora kernel: Caller[0000000000597ac0]: netif_receive_skb+0x1e0/0x300
Jun  5 12:19:34 aurora kernel: Caller[0000000000597c64]: process_backlog+0x84/0x160
Jun  5 12:19:34 aurora kernel: Caller[0000000000597df0]: net_rx_action+0xb0/0x1c0
Jun  5 12:19:34 aurora kernel: Caller[000000000045263c]: __do_softirq+0x7c/0x120
Jun  5 12:19:34 aurora kernel: Caller[0000000000452724]: do_softirq+0x44/0x60
Jun  5 12:19:34 aurora kernel: Caller[0000000000452790]: local_bh_enable+0x50/0xc0
Jun  5 12:19:34 aurora kernel: Caller[00000000005971c0]: dev_queue_xmit+0xc0/0x300
Jun  5 12:19:34 aurora kernel: Caller[00000000005b4418]: ip_finish_output+0x118/0x2c0
Jun  5 12:19:34 aurora kernel: Caller[00000000005b4b2c]: ip_queue_xmit+0x2cc/0x5c0
Jun  5 12:19:34 aurora kernel: Caller[00000000005c82d4]: tcp_transmit_skb+0x334/0x760
Jun  5 12:19:34 aurora kernel: Caller[00000000005cb258]: tcp_connect+0x2b8/0x3c0
Jun  5 12:19:34 aurora kernel: Caller[00000000005ce168]: tcp_v4_connect+0x4e8/0xaa0
Jun  5 12:19:34 aurora kernel: Caller[00000000005dfd20]: inet_stream_connect+0x80/0x1e0
Jun  5 12:19:34 aurora kernel: Caller[000000000058caa4]: sys_connect+0x64/0x80
Jun  5 12:19:34 aurora kernel: Caller[00000000004112f4]: linux_sparc_syscall32+0x34/0x40
Jun  5 12:19:34 aurora kernel: Caller[00000000705ca244]: 0x705ca244
Jun  5 12:19:34 aurora kernel: Instruction DUMP: d4722008  d4722010  d4722018 <d4722020> d4722028  d4722030  d4722038  98a32040  124ffff6
Jun  5 12:19:34 aurora kernel: Kernel panic - not syncing: Aiee, killing interrupt handler!
Jun  5 12:19:34 aurora kernel: TSTATE: 0000009911f09600 TPC: 000000000044c6d0 TNPC: 000000000044c6d4 Y: 00000000    Not tainted
Jun  5 12:19:34 aurora kernel: TPC: <do_syslog+0xf0/0x440>
Jun  5 12:19:34 aurora kernel: g0: fffff8002ae7b371 g1: 0000000000000002 g2: 0000000000000000 g3: 0000000000000000
Jun  5 12:19:34 aurora kernel: g4: fffff8001b3b6d60 g5: fffff8000035c000 g6: fffff8002ae78000 g7: 0000000000000001
Jun  5 12:19:34 aurora kernel: o0: 000000000064b9b0 o1: 0000000000007fff o2: 000000000000cb8f o3: 000000000000cb8f
Jun  5 12:19:34 aurora kernel: o4: 00000000006efbe8 o5: 0000000000000001 sp: fffff8002ae7b331 ret_pc: 000000000044c6fc
Jun  5 12:19:34 aurora kernel: RPC: <do_syslog+0x11c/0x440>
Jun  5 12:19:34 aurora kernel: l0: 000000000000076a l1: 00000000006f7800 l2: 000000000064b800 l3: 000000000064b800
Jun  5 12:19:34 aurora kernel: l4: 00000000006f7800 l5: 000000000064b800 l6: 000000000064b800 l7: 0000000000000008
Jun  5 12:19:34 aurora kernel: i0: 0000000000000000 i1: 0000000000026a2a i2: 0000000000000fff i3: 0000000000004000
Jun  5 12:19:34 aurora kernel: i4: 0000000000040000 i5: 0000000030300031 i6: fffff8002ae7b451 i7: 00000000004c9d60
Jun  5 12:19:34 aurora kernel: I7: <kmsg_read+0x40/0x60>
Jun  5 12:20:01 aurora /USR/SBIN/CRON[21537]: (root) CMD (if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then /usr/bin/mrtg /etc/mrtg.cfg >> /var/log/mrtg/mrtg.log 2>&1; fi)
Jun  5 12:27:28 aurora syslogd 1.4.1#10: restart.
----- s n i p -----
[this snippet is also included as an attachment, for those that don't want
 it line wrapped]

'Funny' that CRON could at least send ONE message to syslog before the
machine halts.

What I was trying to do is blocking excessive connections to some
services running on the machine. The services/ports I'm trying to
limit are:

22:SSH, 23:TELNET, 88:KRB5, 107:RTELNET, 389:LDAP, 543:RLOGIN,
636:LDAPS, 749:KRB5ADM, 751:KRB5AUTH, 992:TELNETS, 2105:EKLOGIN,
3306:MYSQL, 5432:PGSQL, 8080:SQUID

Localhost (both 127.0.0.1 and external interface IP) is added to
the *_WHITELIST as is some other hosts...


More details on the URL:
http://blog.andrew.net.au/2005/02/17#ipt_recent_and_ssh_attacks


--=-=-Content-Disposition: inline; filename=kernel-panic.txt
Content-Description: Kernel panic

Jun  5 12:19:33 aurora kernel: Unable to handle kernel paging request at virtual address 00000001400c6000
Jun  5 12:19:33 aurora kernel: tsk->{mm,active_mm}->context = 00000000000001e8
Jun  5 12:19:33 aurora kernel: tsk->{mm,active_mm}->pgd = fffff80037cba000
Jun  5 12:19:34 aurora kernel:               \|/ ____ \|/
Jun  5 12:19:34 aurora kernel:               "@'/ .. \`@"
Jun  5 12:19:34 aurora kernel:               /_| \__/ |_\
Jun  5 12:19:34 aurora kernel:                  \__U_/
Jun  5 12:19:34 aurora kernel: spamd(18649): Oops [#1]
Jun  5 12:19:34 aurora kernel: TSTATE: 0000000011009600 TPC: 000000000050a59c TNPC: 000000000050a5a0 Y: 00000000    Not tainted
Jun  5 12:19:34 aurora kernel: TPC: <__bzero+0x84/0xc0>
Jun  5 12:19:34 aurora kernel: g0: 0000000002056c00 g1: 0000000000000010 g2: 00000000d4bc183e g3: 0000000002062e48
Jun  5 12:19:34 aurora kernel: g4: fffff8003333d320 g5: fffff80000354000 g6: fffff800350d4000 g7: 00000000ffffffff
Jun  5 12:19:34 aurora kernel: o0: 00000001400c5fe0 o1: 0000000000000000 o2: 0000000000000000 o3: 00000001400c5fe0
Jun  5 12:19:34 aurora kernel: o4: 0000000000000040 o5: 0000000000000002 sp: fffff800350d64f1 ret_pc: 0000000002060f2c
Jun  5 12:19:34 aurora kernel: RPC: <match+0x7ac/0x960 [ipt_recent]>
Jun  5 12:19:34 aurora kernel: l0: 00000001400927f8 l1: 00000000000007f8 l2: 00000001400c8000 l3: 0000000140092000
Jun  5 12:19:34 aurora kernel: l4: 000000000000003e l5: 00000000000000f8 l6: 00000000d4d64632 l7: 000000014008e000
Jun  5 12:19:34 aurora kernel: i0: 0000000000000033 i1: 0000000102d21888 i2: 00000001400cc000 i3: 000000014016c888
Jun  5 12:19:34 aurora kernel: i4: 000000000000003e i5: 0000000000000040 i6: fffff800350d65c1 i7: 000000000203a304
Jun  5 12:19:34 aurora kernel: I7: <ipt_do_table+0x2c4/0x5c0 [ip_tables]>
Jun  5 12:19:34 aurora kernel: Caller[000000000203a304]: ipt_do_table+0x2c4/0x5c0 [ip_tables]
Jun  5 12:19:34 aurora kernel: Caller[00000000005a3a8c]: nf_iterate+0x4c/0xe0
Jun  5 12:19:34 aurora kernel: Caller[00000000005a3ed0]: nf_hook_slow+0x90/0x1a0
Jun  5 12:19:34 aurora kernel: Caller[00000000005b02c0]: ip_local_deliver+0x60/0x3a0
Jun  5 12:19:34 aurora kernel: Caller[00000000005b0ab0]: ip_rcv+0x4b0/0x700
Jun  5 12:19:34 aurora kernel: Caller[0000000000597ac0]: netif_receive_skb+0x1e0/0x300
Jun  5 12:19:34 aurora kernel: Caller[0000000000597c64]: process_backlog+0x84/0x160
Jun  5 12:19:34 aurora kernel: Caller[0000000000597df0]: net_rx_action+0xb0/0x1c0
Jun  5 12:19:34 aurora kernel: Caller[000000000045263c]: __do_softirq+0x7c/0x120
Jun  5 12:19:34 aurora kernel: Caller[0000000000452724]: do_softirq+0x44/0x60
Jun  5 12:19:34 aurora kernel: Caller[0000000000452790]: local_bh_enable+0x50/0xc0
Jun  5 12:19:34 aurora kernel: Caller[00000000005971c0]: dev_queue_xmit+0xc0/0x300
Jun  5 12:19:34 aurora kernel: Caller[00000000005b4418]: ip_finish_output+0x118/0x2c0
Jun  5 12:19:34 aurora kernel: Caller[00000000005b4b2c]: ip_queue_xmit+0x2cc/0x5c0
Jun  5 12:19:34 aurora kernel: Caller[00000000005c82d4]: tcp_transmit_skb+0x334/0x760
Jun  5 12:19:34 aurora kernel: Caller[00000000005cb258]: tcp_connect+0x2b8/0x3c0
Jun  5 12:19:34 aurora kernel: Caller[00000000005ce168]: tcp_v4_connect+0x4e8/0xaa0
Jun  5 12:19:34 aurora kernel: Caller[00000000005dfd20]: inet_stream_connect+0x80/0x1e0
Jun  5 12:19:34 aurora kernel: Caller[000000000058caa4]: sys_connect+0x64/0x80
Jun  5 12:19:34 aurora kernel: Caller[00000000004112f4]: linux_sparc_syscall32+0x34/0x40
Jun  5 12:19:34 aurora kernel: Caller[00000000705ca244]: 0x705ca244
Jun  5 12:19:34 aurora kernel: Instruction DUMP: d4722008  d4722010  d4722018 <d4722020> d4722028  d4722030  d4722038  98a32040  124ffff6
Jun  5 12:19:34 aurora kernel: Kernel panic - not syncing: Aiee, killing interrupt handler!
Jun  5 12:19:34 aurora kernel: TSTATE: 0000009911f09600 TPC: 000000000044c6d0 TNPC: 000000000044c6d4 Y: 00000000    Not tainted
Jun  5 12:19:34 aurora kernel: TPC: <do_syslog+0xf0/0x440>
Jun  5 12:19:34 aurora kernel: g0: fffff8002ae7b371 g1: 0000000000000002 g2: 0000000000000000 g3: 0000000000000000
Jun  5 12:19:34 aurora kernel: g4: fffff8001b3b6d60 g5: fffff8000035c000 g6: fffff8002ae78000 g7: 0000000000000001
Jun  5 12:19:34 aurora kernel: o0: 000000000064b9b0 o1: 0000000000007fff o2: 000000000000cb8f o3: 000000000000cb8f
Jun  5 12:19:34 aurora kernel: o4: 00000000006efbe8 o5: 0000000000000001 sp: fffff8002ae7b331 ret_pc: 000000000044c6fc
Jun  5 12:19:34 aurora kernel: RPC: <do_syslog+0x11c/0x440>
Jun  5 12:19:34 aurora kernel: l0: 000000000000076a l1: 00000000006f7800 l2: 000000000064b800 l3: 000000000064b800
Jun  5 12:19:34 aurora kernel: l4: 00000000006f7800 l5: 000000000064b800 l6: 000000000064b800 l7: 0000000000000008
Jun  5 12:19:34 aurora kernel: i0: 0000000000000000 i1: 0000000000026a2a i2: 0000000000000fff i3: 0000000000004000
Jun  5 12:19:34 aurora kernel: i4: 0000000000040000 i5: 0000000030300031 i6: fffff8002ae7b451 i7: 00000000004c9d60
Jun  5 12:19:34 aurora kernel: I7: <kmsg_read+0x40/0x60>
Jun  5 12:20:01 aurora /USR/SBIN/CRON[21537]: (root) CMD (if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then /usr/bin/mrtg /etc/mrtg.cfg >> /var/log/mrtg/mrtg.log 2>&1; fi)
Jun  5 12:27:28 aurora syslogd 1.4.1#10: restart.

--=-=-=--

From: Chris Ricker <kaboom@gatech.edu>
Date: Fri, 20 Feb 2004 15:49:08 +0000
Subject: Re: another Ultra2 SMP crash
Message-Id: <Pine.GSO.4.58.0402201047530.3968@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.58.0402181628060.21617@redfish.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0402181628060.21617@redfish.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 18 Feb 2004, Chris Ricker wrote:

After I upgraded to 2.6.3-smp, I got another crash on a stuck spinlock:

spin_lock(00000000006481c8) CPU#1 stuck at 0046ae40, owner PC(0046ae40):CPU(1)
spin_lock(fffff8003e291370) CPU#0 stuck at 005c5390, owner PC(005848a8):CPU(1)
spin_lock(00000000006481c8) CPU#1 stuck at 0046ae40, owner PC(0046ae40):CPU(1)
spin_lock(fffff8003e291370) CPU#0 stuck at 005c5390, owner PC(005848a8):CPU(1)
spin_lock(00000000006481c8) CPU#1 stuck at 0046ae40, owner PC(0046ae40):CPU(1)
spin_lock(fffff8003e291370) CPU#0 stuck at 005c5390, owner PC(005848a8):CPU(1)

0046ae40 is near:

000000000046ad00 t m_next
000000000046ad40 t m_stop
000000000046ad60 t m_show
000000000046ae20 T search_module_extables
000000000046aec0 T module_text_address
000000000046af40 T struct_module
000000000046af60 T kallsyms_lookup

005c5390 is near:

00000000005c4a60 t tcp_v4_checksum_init
00000000005c4be0 T tcp_v4_do_rcv
00000000005c4d40 T tcp_v4_rcv
00000000005c5820 t __tcp_v4_rehash
00000000005c5860 t tcp_v4_reselect_saddr
00000000005c5ac0 T tcp_v4_rebuild_header
00000000005c5d00 t v4_addr2sockaddr

The 006481c8 spinlock is modlist_lock:

00000000006481a0 D cpucontrol
00000000006481c8 d modlist_lock
00000000006481d8 d module_mutex
0000000000648200 d modules

From: Jim Gifford <maillist@jg555.com>
Date: Mon, 06 Oct 2008 02:40:22 +0000
Subject: Re: Netra X1 - Tulip Issues - Since 2.6.24
Message-Id: <48E97A96.6040403@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <48E652A7.3010202@jg555.com>
In-Reply-To: <48E652A7.3010202@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Joel wrote:
> Jim Gifford a =E9crit :
>> Currently running 2.6.24-gentoo-r8 and 2.6.25-gentoo-r7. Also have=20
>> tried the vanilla kernel as well.
>>
>> It appears the issues seems to be isolated tot he Sparc X1's my x86's=20
>> using the tulip driver are not having the issue.
>>
>> Not sure if it's a reporting issue or just a problem with the driver.=20
>> Every packet seems to be an error. I've ran out of resources trying=20
>> to figure this out on my own, but no luck. Seems to be TX issue only.
>
>     This is a known trouble that seems to be fixed in 2.6.26. If I=20
> remember, this trouble is older than 2.6.24. I have seen the same with=20
> 3Com adapter since 2.6.19 and it affected all archs.
>
>     Regards,
>
>     JKB
> --=20
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Just put on 2.6.26 on there, still happening, not as much. It dies with=20
these errors under 2.6.26. Here are the 2 last ones. It takes a few=20
hours to bomb, but it does.

Oct  5 04:33:09 mail kernel: [13368.070731] NETDEV WATCHDOG: eth0:=20
transmit timed out
Oct  5 04:33:09 mail kernel: [13368.072165] ------------[ cut here=20
]------------
Oct  5 04:33:09 mail kernel: [13368.072177] WARNING: at=20
net/sched/sch_generic.c:222 dev_watchdog+0x10c/0x140()
Oct  5 04:33:09 mail kernel: [13368.072189] Modules linked in:=20
openpromfs tulip
Oct  5 04:33:09 mail kernel: [13368.072204] Call Trace:
Oct  5 04:33:09 mail kernel: [13368.072212]  [00000000005e68cc]=20
dev_watchdog+0x114/0x140
Oct  5 04:33:09 mail kernel: [13368.072227]  [000000000045fc8c]=20
run_timer_softirq+0x174/0x1e0
Oct  5 04:33:09 mail kernel: [13368.072249]  [000000000045b0bc]=20
__do_softirq+0x64/0xe0
Oct  5 04:33:09 mail kernel: [13368.072264]  [000000000045b198]=20
do_softirq+0x60/0x80
Oct  5 04:33:09 mail kernel: [13368.072277]  [000000000045b344]=20
irq_exit+0x8c/0xc0
Oct  5 04:33:09 mail kernel: [13368.072290]  [000000000043307c]=20
timer_interrupt+0x64/0xc0
Oct  5 04:33:09 mail kernel: [13368.072306]  [00000000004209d4]=20
tl0_irq14+0x1c/0x20
Oct  5 04:33:09 mail kernel: [13368.072323]  [0000000000427d00]=20
cpu_idle+0x28/0xc0
Oct  5 04:33:09 mail kernel: [13368.072338]  [000000000070ca1c]=20
start_kernel+0x284/0x2c0
Oct  5 04:33:09 mail kernel: [13368.072365]  [000000000063c964]=20
tlb_fixup_done+0x88/0x9c
Oct  5 04:33:09 mail kernel: [13368.072380]  [0000000000000000] 0x8
Oct  5 04:33:09 mail kernel: [13368.072392] ---[ end trace=20
bad8983fa8581c2e ]---

Oct  5 13:47:51 mail kernel: [11186.068395] NETDEV WATCHDOG: eth0:=20
transmit timed out
Oct  5 13:47:51 mail kernel: [11186.069824] ------------[ cut here=20
]------------
Oct  5 13:47:51 mail kernel: [11186.069836] WARNING: at=20
net/sched/sch_generic.c:222 dev_watchdog+0x10c/0x140()
Oct  5 13:47:51 mail kernel: [11186.069847] Modules linked in:=20
openpromfs tulip
Oct  5 13:47:51 mail kernel: [11186.069863] Call Trace:
Oct  5 13:47:51 mail kernel: [11186.069870]  [00000000005e68cc]=20
dev_watchdog+0x114/0x140
Oct  5 13:47:51 mail kernel: [11186.069885]  [000000000045fc8c]=20
run_timer_softirq+0x174/0x1e0
Oct  5 13:47:51 mail kernel: [11186.069906]  [000000000045b0bc]=20
__do_softirq+0x64/0xe0
Oct  5 13:47:51 mail kernel: [11186.069921]  [000000000045b198]=20
do_softirq+0x60/0x80
Oct  5 13:47:51 mail kernel: [11186.069934]  [000000000045b344]=20
irq_exit+0x8c/0xc0
Oct  5 13:47:51 mail kernel: [11186.069946]  [000000000043307c]=20
timer_interrupt+0x64/0xc0
Oct  5 13:47:51 mail kernel: [11186.069963]  [00000000004209d4]=20
tl0_irq14+0x1c/0x20
Oct  5 13:47:51 mail kernel: [11186.069979]  [0000000000427d0c]=20
cpu_idle+0x34/0xc0
Oct  5 13:47:51 mail kernel: [11186.069994]  [000000000070ca1c]=20
start_kernel+0x284/0x2c0
Oct  5 13:47:51 mail kernel: [11186.070020]  [000000000063c964]=20
tlb_fixup_done+0x88/0x9c
Oct  5 13:47:51 mail kernel: [11186.070035]  [0000000000000000] 0x8
Oct  5 13:47:51 mail kernel: [11186.070047] ---[ end trace=20
57f9d9a3f577b443 ]---
Oct  5 13:47:59 mail kernel: [11194.064398] NETDEV WATCHDOG: eth0:=20
transmit timed out
Oct  5 13:48:07 mail kernel: [11202.060400] NETDEV WATCHDOG: eth0:=20
transmit timed out
Oct  5 13:48:15 mail kernel: [11210.056403] NETDEV WATCHDOG: eth0:=20
transmit timed out
Oct  5 13:48:23 mail kernel: [11218.052407] NETDEV WATCHDOG: eth0:=20
transmit timed out
Oct  5 13:48:31 mail kernel: [11226.048412] NETDEV WATCHDOG: eth0:=20
transmit timed out
Oct  5 13:48:39 mail kernel: [11234.044411] NETDEV WATCHDOG: eth0:=20
transmit timed out


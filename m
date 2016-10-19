From: Meelis Roos <mroos@linux.ee>
Date: Wed, 19 Oct 2016 11:06:44 +0000
Subject: Re: tg3 BUG: spinlock lockup suspected
Message-Id: <alpine.LRH.2.20.1610191357310.18007@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMet4B60wAi0oqEXDdGdw4UV-bCsbprm9xQqkLMznSyxO3Z-Sg@mail.gmail.com> <CAF2ZziZiy+ZeoH1pPiBOWAdXrV1qzqhjBabxMW0jUjtYPfjQ8A@mail.gmail.com>
In-Reply-To: <CAF2ZziZiy+ZeoH1pPiBOWAdXrV1qzqhjBabxMW0jUjtYPfjQ8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Deepak Khungar <deepak.khungar@broadcom.com>
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>, Linux Netdev List <netdev@vger.kernel.org>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

> Can you please share the Linux Distribution information along with sparc =
machine specification.

Sun Fire V210 (dual UltraSPARC IIIi), onboard NICs with tg3=20
driver. Debian unstable snapshot (as last seen in Debian):

deb http://snapshot.debian.org/archive/debian/20150725T121538Z/ unstable ma=
in contrib non-free

except for udev and libudev1 that are 218-8 (older) because the latest=20
udev at that moment was broken.

This implies gcc version 4.9.3 (Debian 4.9.3-2).


> Regards,
> Deepak Khungar
>=20
> On Wed, Oct 19, 2016 at 10:18 AM, Siva Reddy Kallam <siva.kallam@broadcom=
.com> wrote:
>       On Mon, Oct 17, 2016 at 6:35 PM, Meelis Roos <mroos@linux.ee> wrote:
>       >> > Now I reproduced the bug even with 4.7-rc1 so it is older than=
 4.7. Will
>       >> > test further.
>       >>
>       >> It gets stranger and stranger - my old 4.7 image worked fine, fr=
eshly
>       >> compiled 4.7 exhibits the same problem.
>       >>
>       >> Toolchain has not changed, that I know for sure.
>       >>
>       >> What may have changed is kernel .config. My old conf was with wh=
atever I
>       >> had during 4.7. Then I upgraded to 4.8-rc3 and then 4.8 and sele=
cted
>       >> values for "make oldconfig" new entries. Then went back to 4.7-r=
c1 and
>       >> then to 4.7 with this config, answering quiestion about new opti=
ons when
>       >> any appeared. Diff is not available since I do not have the old =
configs
>       >> archived.
>       >
>       > I did some more digging. Found an older configuration that is wor=
king
>       > and recreated a newer one that is bad, for the same 4.7 kernel. T=
his is
>       > reproducible now, from "make clean" state.
>       >
>       > Working config from 4.7-rc4 attached as config-4.7, broken config=
 from
>       > 4.7 attached as config-4.7-bad.
>       >
>       > Will try to bisect the configs as time permits. But looking at the
>       > stack traces, the issue is probably timing related, when ip and d=
hclient
>       > do something with the same lock. seq_read that outputs stats coul=
d be
>       > reading /proc/net/dev that reads counters from each interface.
>       >
>       > ifupdown seems to use the following for dhcp interfaces:
>       >=A0 =A0up
>       >=A0 =A0 =A0[[/bin/ip link set dev %iface% address %hwaddress%]]
>       >=A0 =A0 =A0/sbin/dhclient -v -pf /run/dhclient.%iface%.pid -lf /va=
r/lib/dhcp/dhclient.%iface%.leases -I -df /var/lib/dhcp/dhclient6.%iface%.l=
eases %iface% \
>       > ...
>       >
>       > so ip link is setting link up, this creates some work for the
>       > background, and the dhclient goes adn reads /proc/net/dev, and lo=
ckup is
>       > suspected but not proven?
>       >
>       > I started a loop for test, doing cat /proc/net/dev in a loop and =
at the
>       > same link link up and down from console, but up and down is slow =
process
>       > and the loop did not seem to trigger the warning over night, so i=
t was
>       > not so simple.
>       >
>       I am busy with other priority tasks. One of my colleague Deepak will
>       work this with you.
>       I added him to CC list.
>       Thanks.
>       >
>       >> > > [=A0 =A083.716570] BUG: spinlock lockup suspected on CPU#0, =
dhclient/1014
>       >> > > [=A0 =A083.797819]=A0 lock: 0xfff000123c8e4a08, .magic: dead=
4ead, .owner: ip/1001, .owner_cpu: 1
>       >> > > [=A0 =A083.903130] CPU: 0 PID: 1014 Comm: dhclient Not taint=
ed 4.8.0 #4
>       >> > > [=A0 =A083.982129] Call Trace:
>       >> > > [=A0 =A084.014160]=A0 [00000000004b7220] spin_dump+0x60/0xa0
>       >> > > [=A0 =A084.078203]=A0 [00000000004b73a0] do_raw_spin_lock+0x=
a0/0x120
>       >> > > [=A0 =A084.106344] IPv6: ADDRCONF(NETDEV_UP): eth0: link is =
not ready
>       >> > > [=A0 =A084.107193] ip (1001) used greatest stack depth: 2168=
 bytes left
>       >> > > [=A0 =A084.306955]=A0 [000000000092c0d0] _raw_spin_lock_bh+0=
x30/0x40
>       >> > > [=A0 =A084.380188]=A0 [00000000100822cc] tg3_get_stats64+0xc=
/0x80 [tg3]
>       >> > > [=A0 =A084.456885]=A0 [00000000007fac8c] dev_get_stats+0x2c/=
0xc0
>       >> > > [=A0 =A084.525506]=A0 [000000000081a4e8] dev_seq_printf_stat=
s+0x8/0xe0
>       >> > > [=A0 =A084.600986]=A0 [000000000081a5e4] dev_seq_show+0x24/0=
x40
>       >> > > [=A0 =A084.668467]=A0 [00000000005cb6c4] seq_read+0x2c4/0x440
>       >> > > [=A0 =A084.733656]=A0 [000000000060b97c] proc_reg_read+0x3c/=
0x80
>       >> > > [=A0 =A084.802282]=A0 [00000000005a219c] __vfs_read+0x1c/0x1=
40
>       >> > > [=A0 =A084.868613]=A0 [00000000005a2310] vfs_read+0x50/0x100
>       >> > > [=A0 =A084.932662]=A0 [00000000005a265c] SyS_read+0x3c/0xa0
>       >> > > [=A0 =A084.995573]=A0 [00000000004061d4] linux_sparc_syscall=
32+0x34/0x60
>       >> > > [=A0 =A085.073748] * CPU[=A0 0]: TSTATE[00000044f0001a22] TP=
C[00000000f79a16b0] TNPC[00000000f79a16b4] TASK[dhclient:1014]
>       >> > > [=A0 =A085.208732]=A0 =A0 =A0 =A0 =A0 =A0 =A0 TPC[f79a16b0] =
O7[f79405c8] I7[0] RPC[0]
>       >> > > [=A0 =A085.287633]=A0 =A0CPU[=A0 1]: TSTATE[0000004480001605=
] TPC[00000000004b26f0] TNPC[00000000004d0b0c] TASK[swapper/1:0]
>       >> > > [=A0 =A085.420338]=A0 =A0 =A0 =A0 =A0 =A0 =A0 TPC[trace_hard=
irqs_off+0x10/0x20] O7[rcu_idle_enter+0x64/0xa0] I7[cpu_startup_entry+0x1b0=
/0x240] RPC[rest_init+0x178/0x1a0]
>       >> > > [=A0 =A085.664600] tg3 0000:00:02.0 eth0: Link is up at 100 =
Mbps, full duplex
>       >> > > [=A0 =A085.750515] tg3 0000:00:02.0 eth0: Flow control is of=
f for TX and off for RX
>       >> > > [=A0 =A085.843994] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link=
 becomes ready
>       >
>       > --
>       > Meelis Roos (mroos@linux.ee)
>=20
>=20
>=20
>=20

--=20
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

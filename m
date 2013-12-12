From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Thu, 12 Dec 2013 12:33:20 +0000
Subject: Re: Issue booting Niagara T1 after commit 87fa05aeb3
Message-Id: <52A9AD10.4060008@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <528B57AF.6020106@fabbione.net>
In-Reply-To: <528B57AF.6020106@fabbione.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Same here, I tried with the default config.

On 11/19/13 13:21, Fabio M. Di Nitto wrote:
> Hi all,
>=20
> yes I know.. vintage hardware :) It=B4s running Debian unstable updated to
> approx a week ago (yay for tons of rebuilds to bisect ;)).
>=20
> fabbione@sunfire:~/linux-2.6$ gcc --version
> gcc (Debian 4.6.4-5) 4.6.4
>=20
> kernel config is from debian, applied to the various bisect done on
> Linus tree.
>=20
> sunfire:~# cat /proc/cpuinfo
> cpu             : UltraSparc T1 (Niagara)
> fpu             : UltraSparc T1 integrated FPU
> pmu             : niagara
> prom            : OBP 4.28.9 2008/06/30 21:26
> type            : sun4v
> ncpus probed    : 24
> ..
>=20
> commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Thu Apr 11 21:38:50 2013 +0200
>=20
>     sparc: Use generic idle loop
>=20
>     Add generic cpu_idle support
>=20
> appears to be culprit and I can=B4t boot any kernel after that. Reverting
> the commit makes the machine boot again (tested up to commit 4fbf888acc
> from Linus tree).
>=20
> Sorry I really don=B4t know that part of the code well enough to propose a
> fix, but I can either provide access to the machine or test debugging
> patches.
>=20
> Thanks
> Fabio
>=20
> Few extra info:
>=20
> with this commit applied (head to the commit):
>=20
> [SNIP]
> [   68.089495] scsi0 : Emulex LPe1150 PCIe Fibre Channel Adapter  on PCI
> bus 08 device 00 irq 23
> [   68.089495] scsi0 : Emulex LPe1150 PCIe Fibre Channel Adapter  on PCI
> bus 08 device 00 irq 23
> [   89.429041] INFO: rcu_sched detected stalls on CPUs/tasks:[
> 89.429041] INFO: rcu_sched detected stalls on CPUs/tasks: { { 3 3 10 10
> 15 15} } (detected by 0, tS42 jiffies, g=18446744073709551328,
> c=18446744073709551327, q!64)
> (detected by 0, tS42 jiffies, g=18446744073709551328,
> c=18446744073709551327, q!64)
> [   89.431437] * CPU[  0]: TSTATE[0000000080001603]
> TPC[000000000042b9d4] TNPC[000000000042b9d8] TASK[swapper/0:0]
> [   89.431437] * CPU[  0]: TSTATE[0000000080001603]
> TPC[000000000042b9d4] TNPC[000000000042b9d8] TASK[swapper/0:0]
> [   89.431462] BUG: soft lockup - CPU#3 stuck for 23s! [swapper/3:0]
> [   89.431462] BUG: soft lockup - CPU#3 stuck for 23s! [swapper/3:0]
> [   89.431470] BUG: soft lockup - CPU#1 stuck for 23s! [swapper/1:0]
> [   89.431470] BUG: soft lockup - CPU#1 stuck for 23s! [swapper/1:0]
> [   89.431479] BUG: soft lockup - CPU#2 stuck for 23s! [swapper/2:0]
> [   89.431479] BUG: soft lockup - CPU#2 stuck for 23s! [swapper/2:0]
> [   89.431484] Modules linked in:
> [SNIP]
>=20
> Most kernels in between that commit to 3.12:
>=20
> [SNIP]
> [   68.392210] UDP hash table entries: 4096 (order: 4, 131072 bytes)
> [   68.393319] UDP-Lite hash table entries: 4096 (order: 4, 131072 bytes)
> [   68.395425] NET: Registered protocol family 1
> [   68.396008] pci 0001:05:02.0: Activating ISA DMA hang workarounds
> -- no more output --
>=20
> With Linus tree up to commit 4fbf888accb39 (didn=B4t test yet newer trees=
):
>=20
> [   60.770765] scsi2 : Emulex LPe1150 PCIe Fibre Channel Adapter  on PCI
> bus 08 device 00 irq 23
>  [   81.923914] INFO: rcu_sched detected stalls on CPUs/tasks: {}
> (detected by 4, tR92 jiffies, g=18446744073709551336,
> c=18446744073709551335,5)
> [   81.924215] INFO: Stall ended before state dump start
> [  145.419184] INFO: rcu_sched detected stalls on CPUs/tasks: {}
> (detected by 0, t!166 jiffies, g=18446744073709551336,
> c=18446744073709551335,7)
> [  145.419482] INFO: Stall ended before state dump start
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


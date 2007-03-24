From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 24 Mar 2007 10:55:26 +0000
Subject: Re: sparc32 SMP debugging advice needed
Message-Id: <4605039E.20800@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <460449B6.7010308@earthlink.net>
In-Reply-To: <460449B6.7010308@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

	Hello,

Robert Reif a =E9crit :
> I'm trying to get a git rc4 SMP kernel working on an ss20 and am running
> into a few problems.

	I have built the same kernel with some debug information about=20
deadlocks and spinlocks. This kernel works fine with one SuperSPARC but=20
not with one HyperSPARC (cache aliasing management mistake). With dual=20
SuperSPARC (SM71), kernel randomly hangs with spinlock bug. Sometimes,=20
it can boot, sometimes not, and I don't know how debug this kernel. When=20
it completely boots, I can see some deadlocks (for example, run "make=20
-j2" to build a kernel randomly stops with cc in D state), some randomly=20
oops (syscall_to_hard) when pipe syscall is executed.

> An SMP kernel boots and runs fine using debian etch and a single
> CPU.  However I do get this in kern.log:
>=20
> Mar 23 10:59:53 ss20 kernel: Kernel command line: root=3D/dev/sda2 ro
> Mar 23 10:59:53 ss20 kernel: PID hash table entries: 1024 (order: 10,=20
> 4096 bytes)
> Mar 23 10:59:53 ss20 kernel: start_kernel(): bug: interrupts were=20
> enabled early
> Mar 23 10:59:53 ss20 kernel: Console: colour dummy device 80x25
>=20
> It looks like something similar was fixed a while back on sparc64 but
> I don't know if this is related.  I'm recompiling a kernel with more
> debugging turned on to see what happens.
>=20
> I get a hang when booting the same kernel with 2 CPUs at:
>=20
> Begin: Loading essential drivers... ...
>=20
> Nothing interesting before that.
>=20
> Any advice on how to approach fixing these issues?  I can test patches.

	I can test too. If someones has some idea about this trouble or a=20
method to debug this kernel, he is welcome ;-)

	Regards,

	JKB

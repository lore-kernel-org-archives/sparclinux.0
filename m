From: Bob Breuer <breuerr@mc.net>
Date: Tue, 20 Jun 2006 05:03:14 +0000
Subject: Re: [PATCH 0/4] sparc32: smp fixes
Message-Id: <44978192.8060304@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <448BB4E4.4060408@mc.net>
In-Reply-To: <448BB4E4.4060408@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Ludovic Court=E8s wrote:
> Hi,
>=20
> 5 days, 2 hours, 52 minutes, 18 seconds ago,=20
> Ludovic Court=E8s wrote:
>> Using GCC 3.4.6 (from Debian sid) fixes the problem.
>=20
> Actually it doesn't.  For some reason, I now hit the following ICE with
> 3.4.6 (Debian's `gcc-3.4', version 3.4.6-2) systematically:
>=20
>     CC      fs/proc/proc_misc.o
>     CC      fs/dnotify.o
>   distcc[13671] ERROR: compile
    ^^^^^^
Jumping through extra hoops here?  Or in other words, is there any
chance that distcc may cause problems?

> I finally used 3.3.6 to built the whole kernel and I don't hit any ICE
> there.  Is anybody building SPARC kernels with 3.4 or 4.x?
>=20
>> However, the resulting kernel hangs right after the "Booting Linux..."
>> message.
>=20
> The kernel (once cleanly recompiled with 3.3.6) still hangs at the same
> point, whether there are one or two CPUs in the machine.

I've put my SMP kernel image up at: http://user.mc.net/~breuerr/sparc/
if you want to give it a try.  No initrd needed, and it's a pretty
trimmed down config, but it works for me.  The config and patch to
recreate it are also there.

Bob

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Mon, 29 May 2006 06:03:34 +0000
Subject: Re: 2.6.17-rc5 does not build for sparc
Message-Id: <447a8eb6efe1f@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <4478bffd45960@wp.pl>
In-Reply-To: <4478bffd45960@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dnia 28-05-2006 o godz. 0:43 Bob Breuer napisa=B3:
=20
> That's not all that is broken.  I think I have what could be 4
separate
> patches for smp here: (combined in the attached patch)
>   1. add topology_init - fixes a boot time crash
>   2. setup cpu_possible_map - actually boot the additional cpu's
>   3. fix smp related section mismatch warnings
>   4. add the missing *_can_lock macros
>=20
> If you are running a local framebuffer, you may encounter a
problem with
> vmalloc.  Adding "migration_cost=10000" to the kernel command line
> should cover up the problem.
>=20

Thank you for the patch. It's a pity you haven't post it earlier
as I lost few hours fixing missing topology_init.

Anyway, it is a huge improvement other the current state of
official kernel. Is this patch on its way to the kernel?

> I haven't had the time to give it a thorough testing and see if it
> self-recompiles recently, but I was previously able to successfully
> rebuild the kernel with "make -j6" on a dual SuperSPARC II.
>=20

I was not so lucky. I was able to boot and two cpus were detected
 (Supersparc II) but the machine opened PROM console after
mounting tmpfs filesystem (for the /tmp directory). The harddisk
filesystems were mounted correctly. I will try to look into this
problem.

Krzysztof




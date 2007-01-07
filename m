From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sun, 07 Jan 2007 14:23:15 +0000
Subject: Re: [2.6.19.1] ESP regression ?
Message-Id: <45A10253.4080005@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <459E1EC7.7050300@systella.fr>
In-Reply-To: <459E1EC7.7050300@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Jurij Smakov a =E9crit :
> On Fri, Jan 05, 2007 at 01:35:05PM -0600, Tom 'spot' Callaway wrote:
>> Building the SCSI and esp components into the kernel does not change the
>> results, it still doesn't work on 2.6.18.1+ on sparc32.
>>
>> If anyone has a working sparc32 kernel config that works on a sparc32
>> w/esp, please post it here.
>=20
> Tom,
>=20
> The 2.6.18 kernel (it is actually 2.6.18.5 plus some patches) we=20
> currently have in Debian works fine on my SS20. You can find the=20
> config, kernel, and matching initrd at
>=20
> http://www.wooyd.org/sparc/
>=20
> The only patch which touches anything in arch/sparc is also included=20
> there (bus-id-size.patch), other patches may be viewed at
>=20
> http://svn.debian.org/wsvn/kernel/dists/sid/linux-2.6/debian/patches/
>=20
> One esp problem I'm aware of is broken CD-ROM support, the bug report=20
> with some discussion is available at
>=20
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug93894
>=20
> I've got as far as figuring out that this problem seems to be due to a=20
> miscompilation with gcc 4.1. If the kernel is built with gcc 4.0,=20
> CD-ROM actually works again, so it might be some tool chain=20
> regression. At this point, however, I don't really have time to track=20
> it down.

	For information, the 2.6.19.1 runs better when it is built with=20
gcc-4.1. I have tried to rebuild this kernel with gcc-4.0 and I can see=20
several deadlocks.

	Regards,

	JKB

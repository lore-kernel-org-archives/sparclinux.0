From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 06 Jan 2007 09:09:52 +0000
Subject: Re: [2.6.19.1] ESP regression ?
Message-Id: <459F6760.5040208@systella.fr>
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

	Jurij,

> The 2.6.18 kernel (it is actually 2.6.18.5 plus some patches) we=20
> currently have in Debian works fine on my SS20. You can find the=20
> config, kernel, and matching initrd at
>=20
> http://www.wooyd.org/sparc/

	I have tried the 2.6.18 official tree. ESP works fine, but due to a bug=20
in VM, SMP kernel is not stable. I obtain some Oopses with=20
syscall_too_hard in read_pipe. For example, it is imposible to untar=20
kernel tree from its tar.bz2 file. I have tried both 2.6.19 and=20
2.6.19.1. With these kernels, I cannot obtain any syscall_too_hard error=20
nor Oopses, but :

1/ sunlance is totaly broken (sunhme works fine). I suspect a bug due to=20
a build with gcc-4.1, but I don't have time enough (today, but I shall=20
try tomorrow ;-) ) to build gcc-4.0 and rebuild the current kernel;
2/ I have seen a deadlock (without any Oops, tar xvfj=20
linux-2.6.20-rc3.tar.bz2 remains in D state !).

	The 2.6.20-rc3 hangs after floppy controler initialization (but I have=20
built this kernel with gcc-4.1).

	Regards,

	JKB

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 09 Apr 2020 08:47:48 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <e2d9baa6-6fcb-53c8-b5e4-c624d1046f47@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 4/9/20 10:11 AM, Rolf Eike Beer wrote:
> Am Montag, 30. M=E4rz 2020, 10:41:09 CEST schrieb Rolf Eike Beer:
>> I run a 32 bit Gentoo userspace on my T5120 with a 64 bit kernel (5.5.7 =
at
>> the moment). This is nothing really new, I see this for a while, but it
>> seems to got a bit worse lately.
>>
>> My observations are:
>> -the testsuite of the fish shell often hangs. A subprocess goes zombie, =
but
>> the parent never cleans this up
>=20
> This also happens on sparc64.

Indeed. The testsuite times out for us as well with kernel 5.4.19 and 2.29:

> https://buildd.debian.org/status/fetch.php?pkg=3Dfish&arch=3Dsparc64&ver=
=3D3.1.0-1.1&stamp=1583586710&raw=3D0

Last successful build was 2019-03-26 with kernel 4.19.28 and glibc 2.28:

> https://buildd.debian.org/status/fetch.php?pkg=3Dfish&arch=3Dsparc64&ver=
=3D3.0.2-2&stamp=1553615326&raw=3D0

Will retry with glibc 2.31 and kernel 5.5.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

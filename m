From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 20 Apr 2018 13:30:20 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <031e8ae7-9a40-e991-53cb-619f183a7ba6@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 04/20/2018 03:25 PM, Ren=E9 Rebe wrote:
> [    0.000258] Linux version 4.16.2-dist (root@somewhere.exactco.de) (gcc=
 version 5.3.0 (GCC)) #1 SMP Tue Apr 17 08:21:44 Local time zone must be se=
t--see zic

It *might* also be related to the toolchain.

Your version of gcc is pretty old (Debian builds the kernel with gcc-7.3.0)=
 and
we found many different bugs in gcc and binutils that were fixed over the t=
ime
for SPARC. Not sure which of those fixes were backported to gcc-5.

So, in case you are unable to track down the issue in the kernel, try a new=
er
toolchain and the latest version of binutils (2.30 + branch updates).

Adrian

--=20
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

From: Meelis Roos <meelis.roos@ut.ee>
Date: Wed, 24 Oct 2018 15:47:24 +0000
Subject: Vs: [sparc vdso] compile failure in v4.19-4243-ga978a5b - operation combines symbols in different se
Message-Id: <AM5PR0201MB23718E35D48CFE84CC40EE90E1F60@AM5PR0201MB2371.eurprd02.prod.outlook.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

2.25 (Debian 2.25-10 as of  removal from unstable).

________________________________________
Saatja: David Miller <davem@davemloft.net>
Saadetud: kolmap=E4ev, 24. oktoober 2018 18:40:00
Adressaat: mroos@linux.ee
Koopia: sparclinux@vger.kernel.org
Teema: Re: [sparc vdso] compile failure in v4.19-4243-ga978a5b - operation =
combines symbols in different segments

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 24 Oct 2018 12:26:50 +0300

> This happens on all 4 with 2015-08 32-bit userspace that I tested
> todays git on:
>
>   CC      arch/sparc/vdso/vclock_gettime.o
> {standard input}: Assembler messages:
> {standard input}:99: Error: operation combines symbols in different
> segments

What version of binutils?  "as --version" should be enough.

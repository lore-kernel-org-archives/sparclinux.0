From: =?ISO-8859-15?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
Date: Mon, 14 Sep 2009 13:25:19 +0000
Subject: Re: Sparc release requalification
Message-Id: <4AAE443F.7020400@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
>
> 1) Give me the output of /proc/cpuinfo
>
> 2) Try a UP kernel build, does it work even with all of the NMI
>    bits enabled on this machine?
>
> Thanks.
>
>
>  =20
Here's the cpuinfo from a 2.6.24 UP kernel :
cpu             : TI UltraSparc IIIi (Jalapeno)
fpu             : UltraSparc IIIi integrated FPU
prom            : OBP 4.22.33 2007/06/18 12:45
type            : sun4u
ncpus probed    : 2
ncpus active    : 1
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0ClkTck      : 000000004c4b4000
MMU Type        : Cheetah+

There is no hang with UP kernel.

    Seb


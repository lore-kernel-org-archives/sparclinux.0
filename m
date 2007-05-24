From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 24 May 2007 18:06:01 +0000
Subject: Re: Which compiler for 2.6 sparc32 kernel?
Message-Id: <Pine.LNX.4.61.0705241855310.10298@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-93771350-1180029961=:10298"
List-Id: <sparclinux.vger.kernel.org>
References: <46553ad77742c@wp.pl>
In-Reply-To: <46553ad77742c@wp.pl>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-93771350-1180029961=:10298
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

Maybe that is why I have to set console=3Dprom on the kernel command line t=
o=20
get anything meaningfull. My SS1 crashes when it tries to set up the=20
network/NFS Root so I will be trying to identify where that got broak=20
in the next fiew days.

I am using GCC-4.1.2/Binutils 2.17 with some cross compile and sparc=20
patches to cross compile my test kernels on an x86 system. The last=20
working kernel I tested was a patched 2.6.20.9 test kernel to test=20
Benjamin Herrensch Rework ptep_set_access_flags and fix sun4c PATCH.

Regards
 =09Mark Fortescue.

On Thu, 24 May 2007, Krzysztof Helt wrote:

> Hi,
>
> I tried to build the latest kernel 2.6.22-rc2 and it did not
> compile correctly with my self build compiler (from Slackaware
> 10) and stock compiler from Aurora 2.0 (3.4.x). I tried to boot
> it on the SS20 with two Supersparcs II. It was the UP (not SMP)
> version.
>
> The problem is that it miscompile va_arg(args, long long) in the
> vsnprintf() function (I learned it hard way). The kernel simply
> hangs at boot with "Booting linux" the message.
> If the va_arg(args, long long) is replaced with two va_arg(args,
> long) the problem goes away.
>
> The problem appeared since the kernel 2.6.21. The kernel 2.6.20
> works without any change and it was compiled with the same compiler.
>
> Have any of you compiled and booted the sparc32 kernel since
> 2.6.21? Which compiler have you used?
>
> Kind regards,
> Krzysztof
>
> ----------------------------------------------------
> "Ma=B3a Ikar" Helen Oyeyemi - poetycka i mroczna opowie=B6=E6 o bolesnej
> samotno=B6ci dziecka dorastaj=B1cego mi=EAdzy kulturami.
> http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fksiazki.wp.pl%2Fkatalog%2Fksiazki%2=
Fksiazka.html%3Fkw%3D4379&sid=3D1160
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--1750305931-93771350-1180029961=:10298--

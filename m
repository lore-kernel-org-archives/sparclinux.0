From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
Date: Sat, 25 Apr 2009 23:30:35 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <49F39D1B.9070205@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> I notice in your kernel logs that you're using an Ubuntu gcc version
> 4.3.x.
>
> How in the world is that possible?
>
> Ubuntu sparc support stopped after Ubuntu version 7.10 and that
> shipped with gcc-4.1.x as the default compiler.  That's what I use
> for most of my testing FWIW.  On my debian boxes I use the
> default gcc-4.3.2 based compiler.
>
> If you're using a custom built compiler, we're going to have to do
> some tests to rule that out as the cause of your problems I think.
>  =20
sparc port is unofficial but available on the ports.ubuntu.com for all=20
version up to 9.04.
PPC has been retrogaded in ports recently since apple dropped that arch=20
in favor of x86.
The compiler is not custom. It came from the ubuntu archive.
I don't think the compiler is the culprit in this case because all of=20
the kernels built before 2.6.29 are working OK
(I could be wrong, but it's unlikely).
I have a sid debian sparc available. I'll try to build a kernel with=20
that compiler and try if it changes anything.

    Seb

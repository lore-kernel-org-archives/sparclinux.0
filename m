From: Ulrich Teichert <krypton@ulrich-teichert.org>
Date: Thu, 05 May 2005 13:22:50 +0000
Subject: Re: ss20/ross/smp
Message-Id: <200505051322.j45DMolc013335@arbas.nms.ulrich-teichert.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4279EFEB.2070705@growthmodels.com>
In-Reply-To: <4279EFEB.2070705@growthmodels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

>Then you're better off than me. Mine dies hard during init, 2.4.30
>
>
>I don't know a lot about this.  Guessing that the gentoo
>specific ross optimizations may be helping me.

I thought you were running stock kernel.org?

>What setup or distro are you running.  I threw out my email to 3 lists
>that cover the gamut.

Debian woody, sorry, I should have mentioned this.

>Are you running gentoo?  If so, I
>can give you my USE and other flags from make.conf to see
>what the diff is.  Any other of the sparc distros will have a
>slightly different setup for gcc, libraries, etc.  I wanted
>gentoo to get a sun4m optimized ssl setup.  Otherwise
>gentoo takes an incredibly long time to compile.

Having only one ISDN line for internet access rules out gentoo or
Debian testing/unstable or any other download intensive distro for now.

>Related to that, I did a series of emerges (gentoo speak)
>to insure that gcc/libs/kernel were sort-of in sync as I settled
>in the environment.  You may be fighting some variation of a
>kernel/lib problem.

I don't think so, else 2.4.30 would not run UP on my box:

maril:~# uname -a
Linux maril 2.4.30 #3 Sat Apr 30 20:00:51 CEST 2005 sparc unknown
maril:~# gcc -v
Reading specs from /usr/lib/gcc-lib/sparc-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

>I also have a keyboard attached and that may make a diff.
>Again, don't really know.

My other sparcs are all running headless without any problems (one of them
2.4.x 32bit SMP) - usually serial console is more stable anyway ;-)

[del]
>The one kernel that is sort-of guaranteed sparc32 smp
>for ross is 2.2 series.  May be possible for you to compile
>latest 2.2 kernel SMP and try that out.  Though I believe
>interest is in getting SMP smoothed out and working 2.6.x

I will give 2.2 a spin to gather more info. I bought the system from ebay,
so there may be a hardware glitch I don't know about, but when it's running
2.2.x SMP, I think we can rule that out.

Thanks,
Uli
--=20
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Op=E9ration=
 S)

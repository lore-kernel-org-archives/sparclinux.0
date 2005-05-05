From: Ulrich Teichert <krypton@ulrich-teichert.org>
Date: Thu, 05 May 2005 12:15:51 +0000
Subject: Re: ss20/ross/smp
Message-Id: <200505051215.j45CFpEB011645@arbas.nms.ulrich-teichert.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4279EFEB.2070705@growthmodels.com>
In-Reply-To: <4279EFEB.2070705@growthmodels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

>Some data points in case they are useful.

They are, at least for me ;-)

>On a current gentoo ss20 (512M ram, standard internal scsi)
>with dual hypersparc (ross) 150s, I can compile SMP current
>2.4.30 stable kernel (pulled down from kernel.org, no extra patches)
>and it seems to be running stable SMP provided I don't attempt to
>run X (xorg is what's on the box, via gentoo).  With xorg X running
>the system locks up after awhile (few minutes to an hour or so,
>seems to depend on how much I'm trying to do).

Then you're better off than me. Mine dies hard during init, 2.4.30
from kernel.org, SMP enabled. UP runs OK, though. But we seem to have
similar hardware:

SPARCstation 20 MP (2 X RT626), No Keyboard
ROM Rev. 2.25, 512 MB memory installed, Serial #7661520.
Ethernet address 8:0:20:74:e7:d0, Host ID: 7274e7d0.

The only thing I've noticed is that my prom counts the CPUs as 0 and 2:

CPU_#0       HyperSPARC ROSS RT620/RT626         0x00080000 Bytes ECache=20
CPU_#2       HyperSPARC ROSS RT620/RT626         0x00080000 Bytes ECache=20

CPU_#1       ******* NOT installed *******
CPU_#3       ******* NOT installed *******

Does that hurt?

>I'm compiling current 2.6.x stable (again from kernel.org) now
>just to get a baseline.  It seems to have SMP disabled in the
>config in a way that would have to be manually edited to enable.
>
>I'm not in a position to do in-the-guts debugging by myself
>of SMP sparc32/ross issues.  BUT, am quite willing to download
>kernels, patches, etc. and run tests, report on those tests, etc.
>Just let me know.

I'd like to do some debugging, but I don't know where to start. I have
no idea where my sparc dies. Cache flushing (these routines are totally
different for UP and SMP on Hypersparc, as I found out)? Forking and
context changes? Being a kernel newbie doesn't really help, but I am
willing to learn,

TIA,
Uli
PS: I just recently subscribed to this list and have searched the
archives before. All the references I found are suggesting that my
setup should run SMP under 2.4.x - and I would like to know why it does not.
--=20
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Op=E9ration=
 S)

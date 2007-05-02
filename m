From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Wed, 02 May 2007 10:20:25 +0000
Subject: Re: ICE with GCC 4.1
Message-Id: <Pine.LNX.4.61.0705021219500.18504@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <87odl4qt19.fsf@chbouib.org>
In-Reply-To: <87odl4qt19.fsf@chbouib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


On May 1 2007 20:48, Ludovic Court=C3=A8s wrote:
>
>Hi,
>
>Does anyone get the following ICE when compiling the latest kernel (from
>David Miller's Git tree) on sparc32:

Does it always error out at the same point? You might want to use a memory
tester.

>
>    CC      kernel/sched.o
>  kernel/sched.c: In function 'effective_prio':
>  kernel/sched.c:744: internal compiler error: in choose_multiplier, at ex=
pmed.c:3304
>  Please submit a full bug report,
>  with preprocessed source if appropriate.
>  See <URL:http://gcc.gnu.org/bugs.html> for instructions.
>  For Debian GNU/Linux specific bug reporting instructions,
>  see <URL:file:///usr/share/doc/gcc-4.1/README.Bugs>.
>
>The compiler is gcc-4.1 from Debian unstable:
>
>  gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)
>
>Should I be using another version?
>
>Thanks,
>Ludovic.
>
>-
>To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Jan
--=20

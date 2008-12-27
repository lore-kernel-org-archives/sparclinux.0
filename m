From: David Miller <davem@davemloft.net>
Date: Sat, 27 Dec 2008 08:54:52 +0000
Subject: Re: [PATCH] sparc64: use unsigned long long for u64
Message-Id: <20081227.005452.261413194.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081222230035.GB4074@uranus.ravnborg.org>
	<20081222151338.3b6ef997.akpm@linux-foundation.org>
	<20081223131746.GA7456@uranus.ravnborg.org>
In-Reply-To: <20081223131746.GA7456@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sam@ravnborg.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, mingo@elte.hu, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, kenchen@google.com, paulus@samba.org, tglx@linutronix.de, hpa@zytor.com, linux-next@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 23 Dec 2008 14:17:46 +0100

> It may take a few days before the drivers gets fixed.
> Christmas is approaching fast by now.

Even with this and your driver patch applied, the tree
doesn't build successfully:

cc1: warnings being treated as errors
arch/sparc/kernel/psycho_common.c: In function =E2=80=98psycho_check_stc_er=
ror=E2=80=99:
arch/sparc/kernel/psycho_common.c:104: warning: format =E2=80=98%016lx=E2=
=80=99 expects type =E2=80=98long unsigned int=E2=80=99, but argument 4 has=
 type =E2=80=98long long unsigned int=E2=80=99

Did you remove sparc's -Werror when doing test builds
of these changes? :-)

Either way these need some work before they should be
added to any tree.

Andrew you probably want to toss these from your tree
since at a minimum they will break the sparc64 build.

Sam will fix them up and resubmit, and I'll apply them,
don't worry. :)

=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf

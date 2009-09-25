From: David Miller <davem@davemloft.net>
Date: Fri, 25 Sep 2009 21:07:21 +0000
Subject: Re: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <20090925.140721.138412649.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: akpm@linux-foundation.org
Date: Fri, 18 Sep 2009 12:59:03 -0700

> From: Christoph Hellwig <hch@lst.de>
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I had this in my tree but it breaks the build, so please toss
this from your queue.  Thanks.

In file included from include/asm-generic/hardirq.h:6,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
hardirq_32.h:11,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
hardirq.h:6,
                 from include/linux/hardirq.h:10,
                 from include/linux/interrupt.h:12,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
irq_32.h:9,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
irq.h:6,
                 from include/linux/irqnr.h:10,
                 from include/linux/random.h:12,
                 from include/linux/stackprotector.h:6,
                 from init/main.c:17:
include/linux/irq.h:216: error: =E2=80=98NR_IRQS=E2=80=99 undeclared here (=
not in a function)
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf

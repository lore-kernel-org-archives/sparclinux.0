From: David Miller <davem@davemloft.net>
Date: Sat, 07 Nov 2009 06:20:32 +0000
Subject: Re: [patch 14/16] sparc: Replace old style lock initializer
Message-Id: <20091106.222032.02604670.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091106223547.784916750@linutronix.de>
	<20091106223806.973326715@linutronix.de>
	<20091106.221834.246946954.davem@davemloft.net>
In-Reply-To: <20091106.221834.246946954.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 06 Nov 2009 22:18:34 -0800 (PST)

> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 06 Nov 2009 22:42:14 -0000
>=20
>> SPIN_LOCK_UNLOCKED is deprecated. Use __SPIN_LOCK_UNLOCKED instead.
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>=20
> Applied to sparc-next-2.6, thanks.

This breaks the build:

/home/davem/src/GIT/sparc-next-2.6/arch/sparc/include/asm/rwsem.h:39: error=
: expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98{=E2=80=99 tok=
en
/home/davem/src/GIT/sparc-next-2.6/arch/sparc/include/asm/rwsem.h:39: error=
: expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98}=E2=80=99 tok=
en
make[1]: *** [arch/sparc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf

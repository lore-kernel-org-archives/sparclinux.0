From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 22:36:28 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080512.153628.193699676.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080512.005036.19633770.davem@davemloft.net>
	<18472.38209.615770.265421@alkaid.it.uu.se>
	<20080512.153143.48741227.davem@davemloft.net>
In-Reply-To: <20080512.153143.48741227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 15:31:43 -0700 (PDT)

> From: Mikael Pettersson <mikpe@it.uu.se>
> Date: Mon, 12 May 2008 21:06:41 +0200
>=20
> > David Miller writes:
> >  > Please also add the debugging patch below.
> >=20
> > Right, 2.6.26-rc2 plus your debugging patch and booted with numa=DEbug
> > prints the following:
>=20
> Hmmm... my debugging patch had this:
>=20
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 83287d3..3f55973 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
>  ...
> +#define DEBUG
> +

Nevermind I see why the messages don't show up.  Hold on for a second
and I'll send an updated debugging patch.

Thanks.

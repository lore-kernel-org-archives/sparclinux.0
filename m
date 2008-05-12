From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 21:03:17 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080512.140317.133389925.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18465.63175.561233.228014@alkaid.it.uu.se>
	<20080512.005036.19633770.davem@davemloft.net>
	<18472.38209.615770.265421@alkaid.it.uu.se>
In-Reply-To: <18472.38209.615770.265421@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 12 May 2008 21:06:41 +0200

> David Miller writes:
>  > We have some existing debugging, which I'd like you to enable on the
>  > boot command line.  Simply add "numa=DEbug" and that'll get some more
>  > vebose information.
>  >=20
>  > Please also add the debugging patch below.
>=20
> Right, 2.6.26-rc2 plus your debugging patch and booted with numa=DEbug
> prints the following:

Thanks, I'll look over this!

> One thing that bothers me is the "Memory hole size: 128MB" message.
> It wasn't present in 2.6.25, and the amount reported is the exact
> same amount of RAM I've lost. Or maybe I'm paranoid :-)

It's completely new and harmless.  You have memory at 0->128MB and
at 256MB->384MB.  That gap from 128MB->256MB is the hole is it talking
about.

It's computed very simply, it is the difference between the highest
value physical address of available memory and the total amount of
available memory.

Don't let it scare you, it's 2GB on one of my machines :-)

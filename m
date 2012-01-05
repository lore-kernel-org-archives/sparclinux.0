From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 05 Jan 2012 13:36:18 +0000
Subject: Re: [PATCH][resending] SPARC32: forced setting of mode of SUN4M
Message-Id: <20120105133618.GA10830@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <772801325730475@web77.yandex.ru>
In-Reply-To: <772801325730475@web77.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> >> =A0+#ifdef CONFIG_SMP
> >> =A0+ /* Timer-mode for every per-cpu timer (bit '0' is timer mode) */
> >> =A0+ sbus_writel(0x00000000, &timers_global->timer_config);
> >> =A0+#endif
> >
> > Does this have to be SMP only - I think not.
>=20
> There is no difference of which mode is used in case of UP. If it is time=
r mode, it doesn't tick because limit is 0. If it is counter mode, it doesn=
't tick too. And kernel doesn't touch per-cpu timer registers in other way,=
 it has a deal with interrupts only.
>=20
> Ok?

In that case just always set the mode.
We prefer minimal ifdefs in the code.

	Sam

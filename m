From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 05 Jan 2012 19:32:50 +0000
Subject: Re: SPARC32: forced setting of mode of SUN4M per-cpu timers
Message-Id: <20120105193250.GA11194@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1325727738.1385.3.camel@hp>
In-Reply-To: <1325727738.1385.3.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, Jan 05, 2012 at 05:52:09PM +0400, Kirill Tkhai wrote:
> > In that case just always set the mode.
> > We prefer minimal ifdefs in the code.
> >
> > =A0=A0=A0=A0=A0=A0=A0=A0Sam
>=20
> Ok, #ifdef was removed

Good, you can add my:
Acked-by: Sam Ravnborg <sam@ravnborg.org>


	Sam

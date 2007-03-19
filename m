From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 19 Mar 2007 11:34:25 +0000
Subject: Re: [Bugme-new] [Bug 8232] New: Creator3D Framebuffer (sparc64) on
Message-Id: <20070319033425.b0be2d95.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200703191019.l2JAJVH5018137@fire-2.osdl.org>
In-Reply-To: <200703191019.l2JAJVH5018137@fire-2.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev-devel@lists.sourceforge.net, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Cc: mt1@systella.fr, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>

On Mon, 19 Mar 2007 03:19:31 -0700 bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8232
>=20
>            Summary: Creator3D Framebuffer (sparc64) on Sbus/UPA workstati=
on
>     Kernel Version: ALL 2.6
>             Status: NEW
>           Severity: normal
>              Owner: jsimmons@infradead.org
>          Submitter: mt1@systella.fr
>=20
>=20
> Most recent kernel where this bug did *NOT* occur: 2.4.34.1
> Distribution: Debian/testing
> Hardware Environment: U1E/170 with Creator3D (UPA), U2 with creator3D
> Software Environment: debian without X on U1E, debian with Xorg on U2
> Problem Description: Console is white foreground and blanck background by
> default. Sometimes, the screen is cut like this :
>=20
> N | N | N | N
> --+---+---+---
> N | G | G | G
> --+---+---+---
> N | W | W | W
> --+---+---+---
> N | G | G | G
>=20
>=20
> where N is a 'normal' console, 'G' a 'like grey' console (black and white=
 pixels
> like snow), and 'W' a white console (many white pixels). I have tested so=
me
> differents Creator3D fb and this trouble only occurs on Sbus/UPA workstat=
ion. On
> a U60 (PCI/UPA), I never see it.
>=20
> When I launch Xorg, problem goes away.
>=20
> Sometimes, on the same configuration, when X is running, console is not u=
sable
> because foreground _and_ background are black (and a signal is given by t=
he
> framebuffer, screen remains on).
>=20
> Steps to reproduce: U1 or U2 with 2.6 kernel and Creator3D fb on UPA Slot.
> I have tested with Creator3D Rev1.
>=20
> Regards,
>=20
> JKB
>=20
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.

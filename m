From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Tue, 29 May 2007 15:01:45 +0000
Subject: Re: [2/4] 2.6.22-rc3: known regressions
Message-Id: <20070529080145.60be9018@freepuppy>
List-Id: <sparclinux.vger.kernel.org>
References: <465C188F.9000900@googlemail.com>
	<465C22F4.8080505@googlemail.com>
In-Reply-To: <465C22F4.8080505@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Ruben <nahoo82@terra.es>, linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>, "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>, tom.l.nguyen@intel.com, linux-pcmcia@lists.infradead.org, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Gregor Jasny <gjasny@googlemail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>

On Tue, 29 May 2007 14:56:20 +0200
Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Hi all,
>=20
> Here is a list of some known regressions in 2.6.22-rc3.
>=20
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
>=20
>=20
>=20
> Networking
>=20
> Subject    : Network card not usable - sky2
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8539
> Submitter  : Ruben <nahoo82@terra.es>
> Status     : Unknown
>=20


Not a regression. Read the bug report:
	Most recent kernel where this bug did *NOT* occur:

	It's been happening for a long time (I'd say always).



There is a regression since 2.6.22-rc1 where the b44 driver has
receive performance/interrupt lockup issues.

--=20
Stephen Hemminger <shemminger@linux-foundation.org>

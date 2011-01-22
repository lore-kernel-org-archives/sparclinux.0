From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 22 Jan 2011 09:27:06 +0000
Subject: Re: [PATCH 5/5] sparc64: use up-to-data genirq functions
Message-Id: <alpine.LFD.2.00.1101221025420.2971@localhost6.localdomain6>
List-Id: <sparclinux.vger.kernel.org>
References: <1295648816-29516-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1295648816-29516-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sat, 22 Jan 2011, Sam Ravnborg wrote:
> > So the conversion to a non-deprecated API is introducing cruft?
> > That sounds like the change defeats its own point :)
>=20
> The commit that introduced the force parameter says:
>=20
>     The replacement for set_affinity() has an extra argument "bool
>     force". The reason for this is to notify the low level code, that the
>     move has to be done right away and cannot be delayed until the next
>     interrupt happens. That's necessary to handle the irq fixup on cpu
>     unplug in the generic code.
>=20
> The only callers of chip->irq_set_affinity() is in kernel/irq/manage.c
>=20
> And like David I can only see irq_set_affinity() being called with force=
=FAlse.
> As force tell us to set the affinity and we do so on sparc in all
> cases it looks safe to ignore the parameter.
> I will update the changelog to include this info in next version,
> if Thomas does not have other inputs.

The change was done as a preparatory for further cleanups down the
road. I did not want to add irq_set_affinity() now and then change all
those instances again 6 month later down the road.

Thanks,

	tglx

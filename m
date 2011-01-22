From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 22 Jan 2011 06:51:18 +0000
Subject: Re: [PATCH 5/5] sparc64: use up-to-data genirq functions
Message-Id: <20110122065118.GA29818@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1295648816-29516-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1295648816-29516-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Thomas.
Josip have a point here... Can you shed some light on this?

On Sat, Jan 22, 2011 at 02:21:24AM +0100, Josip Rodin wrote:
> On Fri, Jan 21, 2011 at 04:02:52PM -0800, David Miller wrote:
> > From: Josip Rodin <joy@entuzijast.net>
> > Date: Sat, 22 Jan 2011 00:43:44 +0100
> >=20
> > > On Fri, Jan 21, 2011 at 11:26:56PM +0100, Sam Ravnborg wrote:
> > >> Drop all uses of deprecated genirq features
> > >=20
> > >> -static int sun4u_set_affinity(unsigned int virt_irq,
> > >> -			       const struct cpumask *mask)
> > >> +static int sun4u_set_affinity(struct irq_data *data,
> > >> +			       const struct cpumask *mask, bool force)
> > >> -static int sun4v_set_affinity(unsigned int virt_irq,
> > >> -			       const struct cpumask *mask)
> > >> +static int sun4v_set_affinity(struct irq_data *data,
> > >> +			       const struct cpumask *mask, bool force)
> > >> -static int sun4v_virt_set_affinity(unsigned int virt_irq,
> > >> -				    const struct cpumask *mask)
> > >> +static int sun4v_virt_set_affinity(struct irq_data *data,
> > >> +				    const struct cpumask *mask, bool force)
> > >=20
> > > For the benefit of future readers, maybe add a short comment to the c=
ommit
> > > description to explain why these functions are now apparently ignorin=
g the
> > > 'force' parameter, that is, does it not apply because it's not presen=
tly
> > > implemented, or because it just doesn't make sense.
> >=20
> > I don't see any implementation where the "force" parameter is used, and
> > I see no call of these methods that every sets "force" to anything other
> > than "false".
>=20
> So the conversion to a non-deprecated API is introducing cruft?
> That sounds like the change defeats its own point :)

The commit that introduced the force parameter says:

    The replacement for set_affinity() has an extra argument "bool
    force". The reason for this is to notify the low level code, that the
    move has to be done right away and cannot be delayed until the next
    interrupt happens. That's necessary to handle the irq fixup on cpu
    unplug in the generic code.

The only callers of chip->irq_set_affinity() is in kernel/irq/manage.c

And like David I can only see irq_set_affinity() being called with force=FA=
lse.
As force tell us to set the affinity and we do so on sparc in all
cases it looks safe to ignore the parameter.
I will update the changelog to include this info in next version,
if Thomas does not have other inputs.

	Sam

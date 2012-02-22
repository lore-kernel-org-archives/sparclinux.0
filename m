From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 22 Feb 2012 17:03:30 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120222170330.GA29521@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202130942030.1488@math.ut.ee> <20120213080618.GA11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202131119040.1488@math.ut.ee> <20120213214623.GJ11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202162151030.16208@math.ut.ee> <alpine.SOC.1.00.1202201109260.467@math.ut.ee> <20120220170603.GC7836@mtj.dyndns.org> <alpine.SOC.1.00.1202210030530.11350@math.ut.ee> <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com>
In-Reply-To: <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tejun Heo <tj@kernel.org>
Cc: Meelis Roos <mroos@linux.ee>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Feb 20, 2012 at 05:05:37PM -0800, Tejun Heo wrote:
> Hello,
>=20
> Meelis, can you please apply the following patch before & after the
> offending commit, boot with "memblock=DEbug" added as kernel param and
> post the boot log?  The patch will generate some offset warnings after
> the commit but should work fine.
>=20
> Sam, David, as I'm not familiar with the code base, is it possible to
> tell which address is corrupted (zeroed, it seems)?  ie. can we add
> "if (XXX =3D NULL) printk("%p is corrputed\n"...);" somewhere?

No idea - sorry. I spend most of the time with sparc32 - which I
do not even feel familiar with yet :-(

One thing I noticed while working with memblock for sparc32 (*) is that all=
ocations
are done top-down. So we may end up allocatng memory with a considerably hi=
gher
address than we are used to.
This is obviously just a wild guess...

Meelis - do the affected boxes have any special memory configurations?
Could you try to boot with a sensible mem=3Dxxx value to see if limiting th=
e memory
helps.

(*) I have re-done the original patch-set and I have a quite good feeling a=
bout it.
HIGHMEM support is outstanding - I got a bit confused when I looked at x86.

But my ss5 crashes the first time I try to use the allocated memory -=20
so I assume I have some silly issue somewhere. Nothing points at memblock
in this case.

	Sam

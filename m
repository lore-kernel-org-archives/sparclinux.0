From: David Miller <davem@davemloft.net>
Date: Mon, 22 Sep 2008 22:14:19 +0000
Subject: Re: KVM for Sparc?
Message-Id: <20080922.151419.180750057.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1222114719.3967.43.camel@localhost.localdomain>
	<20080922.132623.23838166.davem@davemloft.net>
	<1222118751.3967.59.camel@localhost.localdomain>
In-Reply-To: <1222118751.3967.59.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hollisb@us.ibm.com
Cc: anthony@codemonkey.ws, blauwirbel@gmail.com, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org

From: Hollis Blanchard <hollisb@us.ibm.com>
Date: Mon, 22 Sep 2008 16:25:51 -0500

> On Mon, 2008-09-22 at 13:26 -0700, David Miller wrote:
> > From: Hollis Blanchard <hollisb@us.ibm.com>
> > Date: Mon, 22 Sep 2008 15:18:39 -0500
> > 
> > > It would be even more interesting to implement host support on the Sparc
> > > processors with hardware virtualization support.
> > 
> > That's just a lot of protocol and userland work, rather than much
> > kernel stuff.
> > 
> > To me it's less interesting, to be honest.
> 
> Not sure what you mean. On IBM POWER servers, the hardware's
> virtualization support is only accessible to an IBM-developed hypervisor
> that is packaged with the system. If you're saying Sparc is in the same
> position, I agree that's not very interesting.

Sun4v systems come with Sun's hypervisor.  Linux simply runs on top
of that, whether as a host or a guest.

The hypervisor source is opensource and we could technically make
changes to it, but it isn't very practical.

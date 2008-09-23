From: Hollis Blanchard <hollisb@us.ibm.com>
Date: Tue, 23 Sep 2008 16:07:31 +0000
Subject: Re: KVM for Sparc?
Message-Id: <1222186051.3545.13.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1222114719.3967.43.camel@localhost.localdomain>
	 <90eb1dc70809221331r5350d058k3767a0afc3acd45@mail.gmail.com>
	 <1222118860.3967.61.camel@localhost.localdomain>
	 <20080922.151500.139839534.davem@davemloft.net>
In-Reply-To: <20080922.151500.139839534.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: javier@guerrag.com, anthony@codemonkey.ws, blauwirbel@gmail.com, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org

On Mon, 2008-09-22 at 15:15 -0700, David Miller wrote:
> From: Hollis Blanchard <hollisb@us.ibm.com>
> Date: Mon, 22 Sep 2008 16:27:40 -0500
> 
> > On Mon, 2008-09-22 at 15:31 -0500, Javier Guerra wrote:
> > > On Mon, Sep 22, 2008 at 3:18 PM, Hollis Blanchard <hollisb@us.ibm.com> wrote:
> > > > It would be even more interesting to implement host support on the Sparc
> > > > processors with hardware virtualization support.
> > > 
> > > Does Sparc processors also have 'virtualization support' as an extra
> > > feature? i thought that 'non virtualizationability' was an
> > > intel-specific limitation.  (come on... creating a privileged mode and
> > > not trapping violations? who else would design like that?)
> > 
> > Trapping on privileged instructions is enough to get you virtualization
> > functionality, but for good performance you really want additional
> > hardware support to avoid those traps in the first place.
> 
> That's not really available on sparc.

As far as I can see, you have a hypervisor privilege mode which allows
your guests to execute privileged instructions like WRPR without
trapping.

Without that hardware support (with only 2 privilege levels), you'd be
forced to run the guest kernel in user mode, trapping on every WRPR (for
example). That's what I mean by hardware helping you to avoid traps.

-- 
Hollis Blanchard
IBM Linux Technology Center


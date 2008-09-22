From: Hollis Blanchard <hollisb@us.ibm.com>
Date: Mon, 22 Sep 2008 21:25:51 +0000
Subject: Re: KVM for Sparc?
Message-Id: <1222118751.3967.59.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580809210552sdf3ee24w8922ac25f93fb75@mail.gmail.com>
	 <48D7F33D.90007@codemonkey.ws>
	 <1222114719.3967.43.camel@localhost.localdomain>
	 <20080922.132623.23838166.davem@davemloft.net>
In-Reply-To: <20080922.132623.23838166.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: anthony@codemonkey.ws, blauwirbel@gmail.com, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org

On Mon, 2008-09-22 at 13:26 -0700, David Miller wrote:
> From: Hollis Blanchard <hollisb@us.ibm.com>
> Date: Mon, 22 Sep 2008 15:18:39 -0500
> 
> > It would be even more interesting to implement host support on the Sparc
> > processors with hardware virtualization support.
> 
> That's just a lot of protocol and userland work, rather than much
> kernel stuff.
> 
> To me it's less interesting, to be honest.

Not sure what you mean. On IBM POWER servers, the hardware's
virtualization support is only accessible to an IBM-developed hypervisor
that is packaged with the system. If you're saying Sparc is in the same
position, I agree that's not very interesting.

On the other hand if those features are available to us, there would be
some pretty interesting kernel work to port KVM to use that
functionality.

-- 
Hollis Blanchard
IBM Linux Technology Center


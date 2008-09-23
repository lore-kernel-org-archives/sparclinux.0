From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Tue, 23 Sep 2008 15:34:12 +0000
Subject: Re: KVM for Sparc?
Message-Id: <f43fc5580809230834k428ab783j7c0778e9eedaa30f@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1222114719.3967.43.camel@localhost.localdomain>
	 <20080922.132623.23838166.davem@davemloft.net>
	 <1222118751.3967.59.camel@localhost.localdomain>
	 <20080922.151419.180750057.davem@davemloft.net>
In-Reply-To: <20080922.151419.180750057.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: hollisb@us.ibm.com, anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org

On 9/23/08, David Miller <davem@davemloft.net> wrote:
> From: Hollis Blanchard <hollisb@us.ibm.com>
>
> Date: Mon, 22 Sep 2008 16:25:51 -0500
>
>
>  > On Mon, 2008-09-22 at 13:26 -0700, David Miller wrote:
>  > > From: Hollis Blanchard <hollisb@us.ibm.com>
>  > > Date: Mon, 22 Sep 2008 15:18:39 -0500
>  > >
>  > > > It would be even more interesting to implement host support on the Sparc
>  > > > processors with hardware virtualization support.
>  > >
>  > > That's just a lot of protocol and userland work, rather than much
>  > > kernel stuff.
>  > >
>  > > To me it's less interesting, to be honest.
>  >
>  > Not sure what you mean. On IBM POWER servers, the hardware's
>  > virtualization support is only accessible to an IBM-developed hypervisor
>  > that is packaged with the system. If you're saying Sparc is in the same
>  > position, I agree that's not very interesting.
>
>
> Sun4v systems come with Sun's hypervisor.  Linux simply runs on top
>  of that, whether as a host or a guest.
>
>  The hypervisor source is opensource and we could technically make
>  changes to it, but it isn't very practical.

Do you mean OpenxVM? I think Sun has not published the hypervisor part yet.

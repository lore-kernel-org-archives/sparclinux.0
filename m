From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Wed, 24 Sep 2008 17:22:45 +0000
Subject: Re: KVM for Sparc?
Message-Id: <f43fc5580809241022l58c5e44cje0574c766f705b49@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1222118751.3967.59.camel@localhost.localdomain>
	 <20080922.151419.180750057.davem@davemloft.net>
	 <f43fc5580809230834k428ab783j7c0778e9eedaa30f@mail.gmail.com>
	 <20080923.134149.136667430.davem@davemloft.net>
In-Reply-To: <20080923.134149.136667430.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: hollisb@us.ibm.com, anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org

On 9/23/08, David Miller <davem@davemloft.net> wrote:
> From: "Blue Swirl" <blauwirbel@gmail.com>
>
> Date: Tue, 23 Sep 2008 18:34:12 +0300
>
>
>  > On 9/23/08, David Miller <davem@davemloft.net> wrote:
>
> > > Sun4v systems come with Sun's hypervisor.  Linux simply runs on top
>  > >  of that, whether as a host or a guest.
>  > >
>  > >  The hypervisor source is opensource and we could technically make
>  > >  changes to it, but it isn't very practical.
>  >
>  > Do you mean OpenxVM? I think Sun has not published the hypervisor part yet.
>
>
> No, I mean OpenSPARC.  The full hypervisor source code for sun4v is in
>  the tarball.
>
>         http://www.opensparc.net/
>
>  The code is there for both Niagara-T1 and Niagara-T2, for example for
>  Niagara-T1 click on "Get The Source" --> "OpenSPARC T1" --> "Downloads"
>
>  Then on that page you want "OpenSPARC T1 Download for Architecture and
>  Performance Modeling Tools".  It includes the full hypervisor and even
>  the openboot PROM source code.

I'm not sure, but I think that hypervisor is not a real hypervisor
like the PROM version but one specially designed for Legion emulator.

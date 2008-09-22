From: Hollis Blanchard <hollisb@us.ibm.com>
Date: Mon, 22 Sep 2008 21:27:40 +0000
Subject: Re: KVM for Sparc?
Message-Id: <1222118860.3967.61.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580809210538r38a29d8dpc74342a2bceea109@mail.gmail.com>
	 <f43fc5580809210552sdf3ee24w8922ac25f93fb75@mail.gmail.com>
	 <48D7F33D.90007@codemonkey.ws>
	 <1222114719.3967.43.camel@localhost.localdomain>
	 <90eb1dc70809221331r5350d058k3767a0afc3acd45@mail.gmail.com>
In-Reply-To: <90eb1dc70809221331r5350d058k3767a0afc3acd45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Javier Guerra <javier@guerrag.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, sparclinux@vger.kernel.org, John Levon <levon@movementarian.org>

On Mon, 2008-09-22 at 15:31 -0500, Javier Guerra wrote:
> On Mon, Sep 22, 2008 at 3:18 PM, Hollis Blanchard <hollisb@us.ibm.com> wrote:
> > It would be even more interesting to implement host support on the Sparc
> > processors with hardware virtualization support.
> 
> Does Sparc processors also have 'virtualization support' as an extra
> feature? i thought that 'non virtualizationability' was an
> intel-specific limitation.  (come on... creating a privileged mode and
> not trapping violations? who else would design like that?)

Trapping on privileged instructions is enough to get you virtualization
functionality, but for good performance you really want additional
hardware support to avoid those traps in the first place.

-- 
Hollis Blanchard
IBM Linux Technology Center


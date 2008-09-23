From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Tue, 23 Sep 2008 15:52:11 +0000
Subject: Re: KVM for Sparc?
Message-Id: <f43fc5580809230852x458e82ecn2aed258e7056e103@mail.gmail.com>
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
Cc: hollisb@us.ibm.com, javier@guerrag.com, anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org

On 9/23/08, David Miller <davem@davemloft.net> wrote:
> From: Hollis Blanchard <hollisb@us.ibm.com>
>
> Date: Mon, 22 Sep 2008 16:27:40 -0500
>
>
>  > On Mon, 2008-09-22 at 15:31 -0500, Javier Guerra wrote:
>  > > On Mon, Sep 22, 2008 at 3:18 PM, Hollis Blanchard <hollisb@us.ibm.com> wrote:
>  > > > It would be even more interesting to implement host support on the Sparc
>  > > > processors with hardware virtualization support.
>  > >
>  > > Does Sparc processors also have 'virtualization support' as an extra
>  > > feature? i thought that 'non virtualizationability' was an
>  > > intel-specific limitation.  (come on... creating a privileged mode and
>  > > not trapping violations? who else would design like that?)
>  >
>  > Trapping on privileged instructions is enough to get you virtualization
>  > functionality, but for good performance you really want additional
>  > hardware support to avoid those traps in the first place.
>
>
> That's not really available on sparc.

Looking at other intercept possibilities in AMD SVM, I'm not sure what
would increase performance anyway except IO support. Because there are
no dedicated IO instructions (except maybe some ASI accesses), the
guest can be given direct HW access just by mapping the pages to guest
address space (and adding IOMMU TLBs).

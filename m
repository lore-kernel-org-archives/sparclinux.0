From: David Miller <davem@davemloft.net>
Date: Tue, 23 Sep 2008 20:44:21 +0000
Subject: Re: KVM for Sparc?
Message-Id: <20080923.134421.90766066.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1222118860.3967.61.camel@localhost.localdomain>
	<20080922.151500.139839534.davem@davemloft.net>
	<1222186051.3545.13.camel@localhost.localdomain>
In-Reply-To: <1222186051.3545.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hollisb@us.ibm.com
Cc: javier@guerrag.com, anthony@codemonkey.ws, blauwirbel@gmail.com, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org

From: Hollis Blanchard <hollisb@us.ibm.com>
Date: Tue, 23 Sep 2008 11:07:31 -0500

> As far as I can see, you have a hypervisor privilege mode which allows
> your guests to execute privileged instructions like WRPR without
> trapping.

Sure.

> Without that hardware support (with only 2 privilege levels), you'd be
> forced to run the guest kernel in user mode, trapping on every WRPR (for
> example). That's what I mean by hardware helping you to avoid traps.

Understood.  Actually, we'll likely need to interpret instructions or
rewrite some of them when executing privileged mode code, because, as
stated, several 32-bit V8 Sparc instructions which were privileged
became non-privileged instructions for 64-bit V9.

From: David Miller <davem@davemloft.net>
Date: Wed, 24 Sep 2008 19:28:01 +0000
Subject: Re: KVM for Sparc?
Message-Id: <20080924.122801.151194241.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580809230828i48be0e20m915814138b6a0e84@mail.gmail.com>
	<20080923.133856.141663278.davem@davemloft.net>
	<f43fc5580809241020j2b1d885ci8552b5c5302a89d5@mail.gmail.com>
In-Reply-To: <f43fc5580809241020j2b1d885ci8552b5c5302a89d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: blauwirbel@gmail.com
Cc: anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org, hollisb@us.ibm.com

From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Wed, 24 Sep 2008 20:20:33 +0300

> I see, also Qemu needs to use one more bit then. Does this mean that
> even V8 code written specially may use these traps to call hypervisor?

No, V8 code should not set the extra bit.  Only V9 code on a processor
which is hypervisor capable should do this.

And the hypervisor calls can only be invoked from privileged mode.

This is all described in the UltraSPARC Architecture 2005 Specification
(Hyperprivileged Edition) at:

	http://www.opensparc.net/opensparc-t1/index.html


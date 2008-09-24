From: David Miller <davem@davemloft.net>
Date: Wed, 24 Sep 2008 19:29:52 +0000
Subject: Re: KVM for Sparc?
Message-Id: <20080924.122952.186900852.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080923.133856.141663278.davem@davemloft.net>
	<f43fc5580809241020j2b1d885ci8552b5c5302a89d5@mail.gmail.com>
	<f43fc5580809241106j7780be0et384ee4b98082765b@mail.gmail.com>
In-Reply-To: <f43fc5580809241106j7780be0et384ee4b98082765b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: blauwirbel@gmail.com
Cc: anthony@codemonkey.ws, kvm@vger.kernel.org, sparclinux@vger.kernel.org, levon@movementarian.org, hollisb@us.ibm.com

From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Wed, 24 Sep 2008 21:06:21 +0300

> Now I found the relevant part in the manuals. The extra sun4v bit is
> not taken into account from user mode, so we can't catch privileged to
> hyperprivileged mode traps easily.

That's right, the top bit is ignored in user mode.

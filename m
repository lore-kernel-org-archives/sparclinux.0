From: David Miller <davem@davemloft.net>
Date: Wed, 20 Feb 2008 03:31:25 +0000
Subject: Re: [PATCH v2][POWERPC] Fix initial lmb add region with a non-zero
Message-Id: <20080219.193125.04536962.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
	<20080219.163003.152862383.davem@davemloft.net>
	<4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
In-Reply-To: <4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: galak@kernel.crashing.org
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 19 Feb 2008 21:02:04 -0600

> np.  Are we trying to get this into 2.6.25 or .26?

I'm ambivalent but I would obviously prefer 2.6.25 because
it would allow me to proceed more easily with my sparc64
NUMA work as well as get your bug fixes in more smoothly.

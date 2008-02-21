From: Paul Mackerras <paulus@samba.org>
Date: Thu, 21 Feb 2008 02:15:58 +0000
Subject: Re: [PATCH v2][POWERPC] Fix initial lmb add region with a non-zero
Message-Id: <18364.57054.427433.405627@cargo.ozlabs.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
	<20080219.163003.152862383.davem@davemloft.net>
	<4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
In-Reply-To: <4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kumar Gala <galak@kernel.crashing.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org

Kumar Gala writes:

> np.  Are we trying to get this into 2.6.25 or .26?

I was going to put it into my powerpc-next branch and put it in
2.6.26.  I don't see any need for it to go in 2.6.25.

Paul.

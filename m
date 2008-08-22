From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 04:21:39 +0000
Subject: [PATCH 0/3]: Sparc OF I2C support v2.
Message-Id: <20080821.212139.41529744.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: scottwood@freescale.com, paulus@samba.org, sparclinux@vger.kernel.org


Ok, I've integrated the feedback I got from various reviewers and for
now I'm going to handle the sparc vs. powerpc aspects with a helper
asm/of_i2c.h header file that implements the address fetching.

I think for the time being this is the best solution.  If the
semantics converge, we can merge the logic back into the generic code.

Signed-off-by: David S. Miller <davem@davemloft.net>

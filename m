From: David Miller <davem@davemloft.net>
Date: Thu, 22 Jul 2010 05:28:42 +0000
Subject: Re: [PATCH 4/5] of: remove asm/of_platform.h
Message-Id: <20100721.222842.155365075.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100721232817.7782.23410.stgit@angua>
	<20100721234010.7782.3073.stgit@angua>
In-Reply-To: <20100721234010.7782.3073.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, gregkh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Jul 2010 17:40:10 -0600

> Only thing left in it is of_instantiate_rtc() which can be moved to
> asm/prom.h on PowerPC and is unused in microblaze.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>

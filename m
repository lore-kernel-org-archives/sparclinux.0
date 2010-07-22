From: David Miller <davem@davemloft.net>
Date: Thu, 22 Jul 2010 05:28:52 +0000
Subject: Re: [PATCH 5/5] of: remove asm/of_device.h
Message-Id: <20100721.222852.08977036.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100721232817.7782.23410.stgit@angua>
	<20100721234015.7782.98378.stgit@angua>
In-Reply-To: <20100721234015.7782.98378.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, gregkh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Jul 2010 17:40:15 -0600

> It is mostly unused now.  Sparc has a few defines left in it, but they
> can be moved to other headers.  Removing this header means that new
> architectures adding CONFIG_OF support don't need to also add this
> header file.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 02 May 2007 01:23:19 +0000
Subject: Re: [PATCH 08/11] Begin to consolidate of_device.c
Message-Id: <5e7183d982a071c0e9dc7c7843caf6e7@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070501172250.80707fb8.sfr@canb.auug.org.au>
	<20070501173143.9d514ea4.sfr@canb.auug.org.au>
In-Reply-To: <20070501173143.9d514ea4.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, "David S. Miller" <davem@davemloft.net>

> This moves all the common parts for the Sparc, Sparc64 and PowerPC
> of_device.c files into drivers/openfw/device.c.

s/openfw/of/

Cheers,


Segher


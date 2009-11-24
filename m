From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 17:37:32 +0000
Subject: Re: [PATCH 11/11] of: unify phandle name in struct device_node
Message-Id: <20091124.093732.203692950.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081957.6216.74456.stgit@angua>
In-Reply-To: <20091124081957.6216.74456.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 01:20:05 -0700

> In struct device_node, the phandle is named 'linux_phandle' for PowerPC
> and MicroBlaze, and 'node' for SPARC.  There is no good reason for the
> difference, it is just an artifact of the code diverging over a couple
> of years.  This patch renames .node to .linux_phandle for SPARC.

I know it's just a name, but there is no reason to put "linux" in the
member name.  It's the real device phandle value from OpenFirmware not
something invented by Linux's OF layer.

PowerPC uses this for something different, it records the information
here using the special "linux,phandle" and "ibm,phandle" properties.

See unflatten_dt_node() in arch/powerpc/kernel/prom.c before your
changes.

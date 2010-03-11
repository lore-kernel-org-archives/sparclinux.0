From: David Miller <davem@davemloft.net>
Date: Thu, 11 Mar 2010 18:23:47 +0000
Subject: Re: [PATCH 00/37] OF: move device node pointer into struct device.
Message-Id: <20100311.102347.169562565.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311.102043.40590962.davem@davemloft.net>
In-Reply-To: <20100311.102043.40590962.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, broonie@opensource.wolfsonmicro.com, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, benh@kernel.crashing.org, devicetree-discuss@lists.ozlabs.org, gregkh@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jeremy.kerr@canonical.com, linuxppc-dev@ozlabs.org, James.Bottomley@suse.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, akpm@linux-foundation.org, alsa-devel@alsa-project.org, jgarzik@pobox.com, dwmw2@infradead.org

From: David Miller <davem@davemloft.net>
Date: Thu, 11 Mar 2010 10:20:43 -0800 (PST)

> Three or four of the patches don't apply because only your tree
> has those "/* temporary */" comments, f.e. in arch/sparc/kernel/pci.c
> 
> I took care of this when applying to my tree.

It also doesn't build, what the heck is this against
Grant?

drivers/of/device.c: In function 'of_match_device':
drivers/of/device.c:24: error: 'const struct device' has no member named 'of_node'
drivers/of/device.c:26: error: 'const struct device' has no member named 'of_node'

Please make a patch set against Linus's vanilla tree so
I and others can test this.

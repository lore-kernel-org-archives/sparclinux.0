From: David Miller <davem@davemloft.net>
Date: Thu, 11 Mar 2010 18:38:36 +0000
Subject: Re: [PATCH 21/37] drivers/ata: use .dev.of_node instead of .node
Message-Id: <20100311.103836.13755632.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180543.4824.70491.stgit@angua>
	<4B9936F2.3020105@ru.mvista.com>
In-Reply-To: <4B9936F2.3020105@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sshtylyov@mvista.com
Cc: alsa-devel@alsa-project.org, gregkh@suse.de, benh@kernel.crashing.org, grant.likely@secretlab.ca, linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org, sparclinux@vger.kernel.org, jeremy.kerr@canonical.com, sfr@canb.auug.org.au, linux-scsi@vger.kernel.org, jgarzik@pobox.com, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, James.Bottomley@suse.de, ben-linux@fluff.org, monstr@monstr.eu, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dwmw2@infradead.org

From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Thu, 11 Mar 2010 21:31:14 +0300

>   Should probably have been 2 patches instead of one, as drivers/ata/
>   and drivers/ide/ are different subsystems...

No, he should consolidate these changes _MORE_ not less.

The patch set is already too large to review at it is!

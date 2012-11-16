From: David Miller <davem@davemloft.net>
Date: Fri, 16 Nov 2012 17:33:58 +0000
Subject: Re: [PATCH v2] drivers/of: Constify device_node->name and ->path_component_name
Message-Id: <20121116.123358.444599559940168490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1353075625-7755-1-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1353075625-7755-1-git-send-email-grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, benh@kernel.crashing.org, julian.calaby@gmail.com

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 16 Nov 2012 14:20:25 +0000

> Neither of these should ever be changed once set. Make them const and
> fix up the users that try to modify it in-place. In one case
> kmalloc+memcpy is replaced with kstrdup() to avoid modifying the string.
> 
> Build tested with defconfigs on ARM, PowerPC, Sparc, MIPS, x86 among
> others.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>

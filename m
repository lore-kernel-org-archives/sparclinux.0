From: David Daney <ddaney.cavm@gmail.com>
Date: Fri, 24 Feb 2012 17:32:47 +0000
Subject: Re: [PATCH 1/2] irq_domain: Centralize definition of irq_dispose_mapping()
Message-Id: <4F47C9BF.10008@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1330102448-19172-1-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1330102448-19172-1-git-send-email-grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, "David S. Miller" <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, sparclinux@vger.kernel.org, linux@openrisc.net

On 02/24/2012 08:54 AM, Grant Likely wrote:
> Several architectures define their own empty irq_dispose_mapping().  Since
> the irq_domain code is centralized now, there is little need to do so.  This
> patch removes them and creates a new empty copy when !CONFIG_IRQ_DOMAIN is
> selected.
>
> The patch also means that IRQ_DOMAIN becomes selectable on all architectures.
>
> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
> Cc: Rob Herring<rob.herring@calxeda.com>
> Cc: "David S. Miller"<davem@davemloft.net>
> Cc: Jonas Bonn<jonas@southpole.se>
> Cc: sparclinux@vger.kernel.org
> Cc: linux@lists.openrisc.net
> ---
>   arch/openrisc/include/asm/prom.h |   10 +---------
>   arch/sparc/include/asm/prom.h    |   10 +---------
>   include/linux/irqdomain.h        |    5 ++++-
>   include/linux/of_irq.h           |    4 +---
>   4 files changed, 7 insertions(+), 22 deletions(-)
>

There is also a definition in arch/mips/include/asm/irq.h.

Probably best to get rid of that one too.

David Daney

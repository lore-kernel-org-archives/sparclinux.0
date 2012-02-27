From: Jonas Bonn <jonas@southpole.se>
Date: Mon, 27 Feb 2012 09:43:28 +0000
Subject: Re: [PATCH 1/2] irq_domain: Centralize definition of irq_dispose_mapping()
Message-Id: <1330335808.16647.92.camel@crucifix>
List-Id: <sparclinux.vger.kernel.org>
References: <1330102448-19172-1-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1330102448-19172-1-git-send-email-grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux@openrisc.net


On Fri, 2012-02-24 at 09:54 -0700, Grant Likely wrote:
> Several architectures define their own empty irq_dispose_mapping().  Since
> the irq_domain code is centralized now, there is little need to do so.  This
> patch removes them and creates a new empty copy when !CONFIG_IRQ_DOMAIN is
> selected.
> 
> The patch also means that IRQ_DOMAIN becomes selectable on all architectures.

Acked-by: Jonas Bonn <jonas@southpole.se> (for OpenRISC)


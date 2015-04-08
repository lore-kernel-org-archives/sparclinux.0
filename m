From: David Miller <davem@davemloft.net>
Date: Wed, 08 Apr 2015 03:15:11 +0000
Subject: Re: [PATCH v2] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <20150407.231511.188645706126185064.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>
Date: Mon, 30 Mar 2015 12:05:21 -0400

> diff --git a/arch/sparc/include/asm/topology_64.h
> b/arch/sparc/include/asm/topology_64.h
> index ed8f071..d1761df 100644
> --- a/arch/sparc/include/asm/topology_64.h
> +++ b/arch/sparc/include/asm/topology_64.h
> @@ -40,11 +40,12 @@ static inline int pcibus_to_node(struct pci_bus
> *pbus)

This patch is mangled by your email client.

Please read Documentation/email-clients.txt to learn how to deal
with this.

Only resubmit this patch when you can successfully email the patch
to yourself, and apply cleanly the patch that you receive in that
email.

Thank you.

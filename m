From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Oct 2015 18:50:56 +0000
Subject: Re: [PATCH] sparc64: Fix numa distance values
Message-Id: <20151029185056.GA398@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1446077026-5598-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1446077026-5598-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nitin Gupta <nitin.m.gupta@oracle.com>
Cc: sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Chris Hyser <chris.hyser@oracle.com>, Khalid Aziz <khalid.aziz@oracle.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>

Small nit.

> diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
> index 01d1704..ed3dfdd 100644
> --- a/arch/sparc/include/asm/topology_64.h
> +++ b/arch/sparc/include/asm/topology_64.h
> @@ -31,6 +31,9 @@ static inline int pcibus_to_node(struct pci_bus *pbus)
>  	 cpu_all_mask : \
>  	 cpumask_of_node(pcibus_to_node(bus)))
>  
> +extern int __node_distance(int, int);
We have dropped using "extern" for function prototypes.

> +#define node_distance(a, b) __node_distance(a, b)

And had this be written as:
#define node_distance node_distance
int node_distance(int, int);

Then there had been no need for the leadign underscores.

But as I said - only nits.

	Sam

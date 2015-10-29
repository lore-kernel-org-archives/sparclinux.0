From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 29 Oct 2015 22:46:01 +0000
Subject: Re: [PATCH] sparc64: Fix numa distance values
Message-Id: <5632A1A9.9040301@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1446077026-5598-1-git-send-email-nitin.m.gupta@oracle.com>
 <20151029185056.GA398@ravnborg.org>
In-Reply-To: <20151029185056.GA398@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Chris Hyser <chris.hyser@oracle.com>, Khalid Aziz <khalid.aziz@oracle.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>

On 10/29/2015 11:50 AM, Sam Ravnborg wrote:
> Small nit.
>
>> diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
>> index 01d1704..ed3dfdd 100644
>> --- a/arch/sparc/include/asm/topology_64.h
>> +++ b/arch/sparc/include/asm/topology_64.h
>> @@ -31,6 +31,9 @@ static inline int pcibus_to_node(struct pci_bus *pbus)
>>   	 cpu_all_mask : \
>>   	 cpumask_of_node(pcibus_to_node(bus)))
>>
>> +extern int __node_distance(int, int);
> We have dropped using "extern" for function prototypes.
>

ok, dropped extern here.

>> +#define node_distance(a, b) __node_distance(a, b)
>
> And had this be written as:
> #define node_distance node_distance

underscores here to separate macro name from function name
seems to be clearer and would also avoid confusing
cross-referencing tools.

> int node_distance(int, int);
>
> Then there had been no need for the leadign underscores.
>
> But as I said - only nits.
>
> 	Sam
>
Thanks for the review.
Nitin



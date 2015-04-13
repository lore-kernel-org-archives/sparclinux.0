From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date: Mon, 13 Apr 2015 13:38:48 +0000
Subject: Re: [PATCH] of: return NUMA_NO_NODE from fallback of_node_to_nid()
Message-Id: <552BC6E8.1040400@yandex-team.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20150408165920.25007.6869.stgit@buzz> <CAL_JsqKQPtNPfTAiqsKnFuU6e-qozzPgujM=8MHseG75R9cbSA@mail.gmail.com>
In-Reply-To: <CAL_JsqKQPtNPfTAiqsKnFuU6e-qozzPgujM=8MHseG75R9cbSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On 13.04.2015 16:22, Rob Herring wrote:
> On Wed, Apr 8, 2015 at 11:59 AM, Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>> Node 0 might be offline as well as any other numa node,
>> in this case kernel cannot handle memory allocation and crashes.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Fixes: 0c3f061c195c ("of: implement of_node_to_nid as a weak function")
>> ---
>>   drivers/of/base.c  |    2 +-
>>   include/linux/of.h |    5 ++++-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 8f165b112e03..51f4bd16e613 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -89,7 +89,7 @@ EXPORT_SYMBOL(of_n_size_cells);
>>   #ifdef CONFIG_NUMA
>>   int __weak of_node_to_nid(struct device_node *np)
>>   {
>> -       return numa_node_id();
>> +       return NUMA_NO_NODE;
>
> This is going to break any NUMA machine that enables OF and expects
> the weak function to work.

Why? NUMA_NO_NODE = -1 -- this's standard "no-affinity" signal.
As I see powerpc/sparc versions of of_node_to_nid returns -1 if they
cannot find out which node should be used.

>
> Rob
>
>>   }
>>   #endif
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index dfde07e77a63..78a04ee85a9c 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -623,7 +623,10 @@ static inline const char *of_prop_next_string(struct property *prop,
>>   #if defined(CONFIG_OF) && defined(CONFIG_NUMA)
>>   extern int of_node_to_nid(struct device_node *np);
>>   #else
>> -static inline int of_node_to_nid(struct device_node *device) { return 0; }
>> +static inline int of_node_to_nid(struct device_node *device)
>> +{
>> +       return NUMA_NO_NODE;
>> +}
>>   #endif
>>
>>   static inline struct device_node *of_find_matching_node(
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Konstantin

From: Rob Herring <robherring2@gmail.com>
Date: Mon, 13 Apr 2015 16:49:31 +0000
Subject: Re: [PATCH] of: return NUMA_NO_NODE from fallback of_node_to_nid()
Message-Id: <CAL_Jsq+vaufZJAchHC1OaV9g18zFfkXyRZ9j5wm0VWosh9i4kQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150408165920.25007.6869.stgit@buzz> <CAL_JsqKQPtNPfTAiqsKnFuU6e-qozzPgujM=8MHseG75R9cbSA@mail.gmail.com>
 <552BC6E8.1040400@yandex-team.ru>
In-Reply-To: <552BC6E8.1040400-XoJtRXgx1JseBXzfvpsJ4g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konstantin Khlebnikov <khlebnikov-XoJtRXgx1JseBXzfvpsJ4g@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On Mon, Apr 13, 2015 at 8:38 AM, Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
> On 13.04.2015 16:22, Rob Herring wrote:
>>
>> On Wed, Apr 8, 2015 at 11:59 AM, Konstantin Khlebnikov
>> <khlebnikov@yandex-team.ru> wrote:
>>>
>>> Node 0 might be offline as well as any other numa node,
>>> in this case kernel cannot handle memory allocation and crashes.
>>>
>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> Fixes: 0c3f061c195c ("of: implement of_node_to_nid as a weak function")
>>> ---
>>>   drivers/of/base.c  |    2 +-
>>>   include/linux/of.h |    5 ++++-
>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index 8f165b112e03..51f4bd16e613 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -89,7 +89,7 @@ EXPORT_SYMBOL(of_n_size_cells);
>>>   #ifdef CONFIG_NUMA
>>>   int __weak of_node_to_nid(struct device_node *np)
>>>   {
>>> -       return numa_node_id();
>>> +       return NUMA_NO_NODE;
>>
>>
>> This is going to break any NUMA machine that enables OF and expects
>> the weak function to work.
>
>
> Why? NUMA_NO_NODE = -1 -- this's standard "no-affinity" signal.
> As I see powerpc/sparc versions of of_node_to_nid returns -1 if they
> cannot find out which node should be used.

Ah, I was thinking those platforms were relying on the default
implementation. I guess any real NUMA support is going to need to
override this function. The arm64 patch series does that as well. We
need to be sure this change is correct for metag which appears to be
the only other OF enabled platform with NUMA support.

In that case, then there is little reason to keep the inline and we
can just always enable the weak function (with your change). It is
slightly less optimal, but the few callers hardly appear to be hot
paths.

Rob

From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Apr 2018 02:29:41 +0000
Subject: Re: [PATCH] drivers/of: Introduce ARCH_HAS_OWN_OF_NUMA
Message-Id: <CAPcyv4gk+5f4msuAYVFnNfZXF_cwfexs8aTj1jbm8R8H8E-MwQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180409074604.17671-1-oohall@gmail.com>
 <CAL_Jsq+ho2QhmNmPZMDJcfSxposJd=jYDvjhXH8cMAtVFP7n4A@mail.gmail.com>
 <CAPcyv4iCkc7ZSB7Sjk-O7iBWvvTzhTmdccucC4uN6GEu5Bjotw@mail.gmail.com>
 <CAL_JsqJY-sh+KBVAja=epesGdd=OKJzooeLTpZZD0Z++ZxqzfA@mail.gmail.com>
In-Reply-To: <CAL_JsqJY-sh+KBVAja=epesGdd=OKJzooeLTpZZD0Z++ZxqzfA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-nvdimm <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On Mon, Apr 9, 2018 at 6:02 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Apr 9, 2018 at 4:05 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Mon, Apr 9, 2018 at 1:52 PM, Rob Herring <robh@kernel.org> wrote:
>>> On Mon, Apr 9, 2018 at 2:46 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
>>>> Some OF platforms (pseries and some SPARC systems) has their own
>>>> implementations of NUMA affinity detection rather than using the generic
>>>> OF_NUMA driver, which mainly exists for arm64. For other platforms one
>>>> of two fallbacks provided by the base OF driver are used depending on
>>>> CONFIG_NUMA.
>>>>
>>>> In the CONFIG_NUMA=n case the fallback is an inline function in of.h.
>>>> In the =y case the fallback is a real function which is defined as a
>>>> weak symbol so that it may be overwritten by the architecture if desired.
>>>>
>>>> The problem with this arrangement is that the real implementations all
>>>> export of_node_to_nid(). Unfortunately it's not possible to export the
>>>> fallback since it would clash with the non-weak version. As a result
>>>> we get build failures when:
>>>>
>>>> a) CONFIG_NUMA=y && CONFIG_OF=y, and
>>>> b) The platform doesn't implement of_node_to_nid(), and
>>>> c) A module uses of_node_to_nid()
>>>>
>>>> Given b) will be true for most platforms this is fairly easy to hit
>>>> and has been observed on ia64 and x86.
>>>
>>> How specifically do we hit this? The only module I see using
>>> of_node_to_nid in mainline is Cell EDAC driver.
>>
>> The of_pmem driver is using it currently pending for a 4.17 pull
>> request. Stephen hit the compile failure in -next.
>
> You mean the stuff reviewed last week in the middle of the merge
> window? Sounds like 4.18 material to me.

It was originally posted for 4.16. The reposting and review came in
late this cycle, but outside of a critical issue I'd rather not delay
it again. The build error issue is resolved by not allowing modular
builds of this driver for now.

>
> Rob

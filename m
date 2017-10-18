From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 18 Oct 2017 17:23:22 +0000
Subject: Re: [PATCH v12 08/11] arm64/kasan: add and use kasan_map_populate()
Message-Id: <a587687a-5d90-c03d-f3d2-1ea9cab1b0c4@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-9-pasha.tatashin@oracle.com>
 <0ae84532-8dcb-10aa-9d69-79d7025b089e@virtuozzo.com>
 <ad8c5715-dc4f-1fa7-c25b-e08df68643d0@oracle.com>
 <20171018170651.GG21820@arm.com>
 <e32c677e-62ac-8977-2f9d-7fe7bda4b547@oracle.com>
 <f1cb8d18-4d0f-1f88-c3c5-0add8c6c077a@virtuozzo.com>
In-Reply-To: <f1cb8d18-4d0f-1f88-c3c5-0add8c6c077a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Andrew and Michal,

There are a few changes I need to do to my series:

1. Replace these two patches:

arm64/kasan: add and use kasan_map_populate()
x86/kasan: add and use kasan_map_populate()

With:

x86/mm/kasan: don't use vmemmap_populate() to initialize
  shadow
arm64/mm/kasan: don't use vmemmap_populate() to initialize
  shadow

2. Fix a kbuild warning about section mismatch in
mm: deferred_init_memmap improvements

How should I proceed to get these replaced in mm-tree? Send three new 
patches, or send a new series?

Thank you,
Pavel

On 10/18/2017 01:18 PM, Andrey Ryabinin wrote:
> On 10/18/2017 08:08 PM, Pavel Tatashin wrote:
>>>
>>> As I said, I'm fine either way, I just didn't want to cause extra work
>>> or rebasing:
>>>
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/535703.html
>>
>> Makes sense. I am also fine either way, I can submit a new patch merging together the two if needed.
>>
> 
> Please, do this. Single patch makes more sense
> 
> 
>> Pavel

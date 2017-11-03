From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Date: Fri, 03 Nov 2017 15:40:47 +0000
Subject: Re: [PATCH v12 08/11] arm64/kasan: add and use kasan_map_populate()
Message-Id: <07ab0b77-0e2a-97b5-73ff-a6598bcb94cd@virtuozzo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-9-pasha.tatashin@oracle.com>
 <0ae84532-8dcb-10aa-9d69-79d7025b089e@virtuozzo.com>
 <ad8c5715-dc4f-1fa7-c25b-e08df68643d0@oracle.com>
 <20171018170651.GG21820@arm.com>
 <e32c677e-62ac-8977-2f9d-7fe7bda4b547@oracle.com>
 <f1cb8d18-4d0f-1f88-c3c5-0add8c6c077a@virtuozzo.com>
 <a587687a-5d90-c03d-f3d2-1ea9cab1b0c4@oracle.com>
In-Reply-To: <a587687a-5d90-c03d-f3d2-1ea9cab1b0c4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org



On 10/18/2017 08:23 PM, Pavel Tatashin wrote:
> Hi Andrew and Michal,
> 
> There are a few changes I need to do to my series:
> 
> 1. Replace these two patches:
> 
> arm64/kasan: add and use kasan_map_populate()
> x86/kasan: add and use kasan_map_populate()
> 
> With:
> 
> x86/mm/kasan: don't use vmemmap_populate() to initialize
>  shadow
> arm64/mm/kasan: don't use vmemmap_populate() to initialize
>  shadow
> 

Pavel, could you please send the patches? These patches doesn't interfere with rest of the series,
so I think it should be enough to send just two patches to replace the old ones.




> 2. Fix a kbuild warning about section mismatch in
> mm: deferred_init_memmap improvements
> 
> How should I proceed to get these replaced in mm-tree? Send three new patches, or send a new series?
> 
> Thank you,
> Pavel
> 

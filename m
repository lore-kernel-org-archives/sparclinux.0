From: James Clarke <jrtc27@jrtc27.com>
Date: Thu, 27 Oct 2016 16:02:32 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <04353338-15CE-4427-A8AE-2CE2A6A04EF6@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

> On 27 Oct 2016, at 16:51, David Miller <davem@davemloft.net> wrote:
> 
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Thu, 27 Oct 2016 09:25:36 +0100
> 
>> I’ve run it on the T5 and it seems to work without lockups:
>> 
>> [5948090.988821] vln_init: *vmap_lazy_nr is 32754
>> [5948090.989943] vln_init: lazy_max_pages() is 32768
>> [5948091.157381] TSB[insmod:261876]: DEBUG flush_tsb_kernel_range start=0000000010006000 end=00000000f0000000 PAGE_SIZE=2000
>> [5948091.157530] TSB[insmod:261876]: DEBUG flush_tsb_kernel_range start=0000000100000000 end=0005ffff8c000000 PAGE_SIZE=2000
>> [5948091.158240] vln_init: vmap_lazy_nr is caeb1c
>> [5948091.158252] vln_init: *vmap_lazy_nr is 0
>> [5948091.159311] vln_init: lazy_max_pages() is 32768
>> ... continues on as normal ...
>> 
>> (again, that’s my debugging module to see how close the system is to a flush)
>> 
>> I can't (yet) vouch for the IIIi, but when it comes back up I’ll give it a go[1].
>> I'll also put it on the T1 at some point today, but it *should* also work since
>> it's using the same sun4v/hypervisor implementation as the T5.
> 
> I'm about to test it on my IIIi and will commit this if it seems to work properly.
> 
> I guess you have no opinion about the cut-off choosen? :-)
> 
> Anyways, we can fine tune it later.

I was just testing it on the IIIi when I got this. Anyway, it seems to work fine.
It hasn’t (yet) had one of the stupidly high allocations, but it did flush a block
of 3658 pages just fine (assuming the flush actually worked). Similarly for the T1.

The cut-off seems pretty arbitrary, and the only way to determine it properly would
be benchmarking (or finding out what the relevant delays are). Given x86 uses 33,
32 or 64 seem perfectly fine, but going into the hundreds doesn’t sound stupid
either... For such small numbers it’s probably hardly going to matter.

Tested-by: James Clarke <jrtc27@jrtc27.com>

James


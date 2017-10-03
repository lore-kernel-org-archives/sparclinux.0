From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 03 Oct 2017 15:04:26 +0000
Subject: Re: [PATCH v9 09/12] mm/kasan: kasan specific map populate function
Message-Id: <1e2dc0da-5eb8-3160-803a-262a3c506baf@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-10-pasha.tatashin@oracle.com>
 <20171003144845.GD4931@leverpostej>
In-Reply-To: <20171003144845.GD4931@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

I considered using a new  *populate() function for shadow without using 
vmemmap_populate(), but that makes things unnecessary complicated: 
vmemmap_populate() has builtin:

1. large page support
2. device memory support
3. node locality support
4. several config based variants on different platforms

All of that  will cause the code simply be duplicated on each platform 
if we want to support that in kasan.

We could limit ourselves to only supporting base pages in memory by 
using something like vmemmap_populate_basepages(), but that is a step 
backward.  Kasan benefits from using large pages now, why remove it?

So, the solution I provide is walking page table right after memory is 
mapped. Since, we are using the actual page table, it is guaranteed that 
we are not going to miss any mapped memory, and also it is in common 
code, which makes things smaller and nicer.

Thank you,
Pasha

On 10/03/2017 10:48 AM, Mark Rutland wrote:
> 
> I've given this a spin on arm64, and can confirm that it works.
> 
> Given that this involes redundant walking of page tables, I still think
> it'd be preferable to have some common *_populate() helper that took a
> gfp argument, but I guess it's not the end of the world.
> 
> I'll leave it to Will and Catalin to say whether they're happy with the
> page table walking and the new p{u,m}d_large() helpers added to arm64.
> 

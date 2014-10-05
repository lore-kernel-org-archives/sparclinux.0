From: Bob Picco <bpicco@meloft.net>
Date: Sun, 05 Oct 2014 18:49:43 +0000
Subject: Re: [PATCH v3 0/9] sparc64: MM/IRQ patch queue.
Message-Id: <20141005184943.GH22365@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20141004.192630.315529201590329439.davem@davemloft.net>
In-Reply-To: <20141004.192630.315529201590329439.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Sat Oct 04 2014, 07:26:30PM EDT]
> 
> Third time is the charm, right? :-)  Let's hope so...
> 
> Changes since v2:
> 
> 1) Get rid of verbose kernel log messages during vmemmap construction.
> 
> 2) Add patch #9 to get rid of superfluous page table blocks in the
>    kernel image which can be allocated dynamically, and at the same
>    time increase MAX_BANKS to hopefully accomodate guests with very
>    fragmented real memory layouts.
> 
> 3) Fix bug in KERN_PGTABLE_WALK that would corrupt the huge page TTEs
>    of vmemmap mappings.
> 
> 4) Do some type checking of the page table pointer objects passed into
>    pgd_populate() and pud_populate() by creating inline function
>    helpers.  The reason we can't make pgd_populate() and
>    pud_populate() inline is that "struct mm_struct" is sometimes not
>    fully defined yet in contexts where this header is included.
> 
>    Anyways, this found a bug (albeit in the end harmless) in the new
>    implementation of vmemmap_populate() in that we were passing a
>    "pgd_t *" instead of a "pud_t *" into the third argument of
>    pgd_populate.
> 
> As usual, let me know how it goes.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
Remote M7-4 up with spec-jbb and hugepages. Local T4-2 up with DEBUG_PAGEALLOC.
Remote T5-8 being severely thrashed with several different loads concurrently.
Local T5-2 was under severe load with THP "always" until my "QuietComfort 3"
headphones declared magnificent/enough :)

Seriously, I believe we are in good condition. There will be issues but
this is always the challenge.

Should you desire a boot log, please feel free to request. I've consumed 
nearly all boot logs with scrutiny.

thanx!

Acked-by: Bob Picco <bob.picco@oracle.com>

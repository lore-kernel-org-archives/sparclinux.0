From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Thu, 15 Oct 2020 14:53:59 +0000
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock and with length
Message-Id: <09d9cb95-3414-ef29-de08-f4f2b22b7f77@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
 <d5332a7b-c300-6d28-18b9-4b7d4110ef86@oracle.com>
 <20201010110949.GA32545@gaia>
 <af207cf8-3049-85eb-349d-5fed6b9be49c@oracle.com>
 <20201012172218.GE6493@gaia>
 <20c85633-b559-c299-3e57-ae136b201526@oracle.com>
 <20201013091638.GA10778@gaia>
 <e4c2c56b-3dbe-73dd-ea72-a5378de7de6a@oracle.com>
 <20201015084936.GC20197@gaia>
In-Reply-To: <20201015084936.GC20197@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jann Horn <jannh@google.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, sparclinux@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

On 10/15/20 3:05 AM, Catalin Marinas wrote:
> On Wed, Oct 14, 2020 at 03:21:16PM -0600, Khalid Aziz wrote:
>> What FreeBSD does seems like a reasonable thing to do. Any way first
>> thing to do is to update sparc to use arch_validate_flags() and update
>> sparc_validate_prot() to not peek into vma without lock.
> 
> If you go for arch_validate_flags(), I think sparc_validate_prot()
> doesn't need the vma at all.

Yes, the plan is to move vma flag check from sparc_validate_prot() to
arch_validate_flags()..

> 
> BTW, on the ADI topic, I think you have a race in do_swap_page() since
> set_pte_at() is called before arch_do_swap_page(). So a thread in the
> same process would see the new mapping but the tags have not been
> updated yet. Unless sparc relies on the new user pte to be set, I think
> you can just swap the two calls.
> 

Thanks for pointing that out. I will take a look at it.

--
Khalid

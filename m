From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 04 Jan 2017 23:27:35 +0000
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data Integrity (ADI)
Message-Id: <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-mm@kva

On 01/04/2017 02:46 PM, Khalid Aziz wrote:
> This patch extends mprotect to enable ADI (TSTATE.mcde), enable/disable
> MCD (Memory Corruption Detection) on selected memory ranges, enable
> TTE.mcd in PTEs, return ADI parameters to userspace and save/restore ADI
> version tags on page swap out/in. 

I'm a bit confused why we need all the mechanics with set_swp_pte_at().
For pkeys, for instance, all of the PTEs under a given VMA share a pkey.
 When swapping something in, we just get the pkey out of the VMA and
populate the PTE.

ADI doesn't seem to have a similar restriction.  The feature is turned
on or off at a VMA granularity, but we do not (or can enforce that all
pages under a given VMA must share a tag.

But this leads to an interesting question: is the tag associated with
the (populated?) pte, or the virtual address?  Can you have tags
associated with non-present addresses?  What's the mechanism that clears
the tags at munmap() or MADV_FREE time?

Is the tag storage a precious resource?  Can it be exhausted?

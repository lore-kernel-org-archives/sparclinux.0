From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Date: Fri, 27 Apr 2018 17:36:19 +0000
Subject: Re: [RFC PATCH 0/9] Enable THP migration for all possible architectures
Message-Id: <20180427193619.435eb53a@thinkpad>
List-Id: <sparclinux.vger.kernel.org>
References: <20180426142804.180152-1-zi.yan@sent.com>
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 26 Apr 2018 10:27:55 -0400
Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <zi.yan@cs.rutgers.edu>
> 
> Hi all,
> 
> THP migration is only enabled on x86_64 with a special
> ARCH_ENABLE_THP_MIGRATION macro. This patchset enables THP migration for
> all architectures that uses transparent hugepage, so that special macro can
> be dropped. Instead, THP migration is enabled/disabled via
> /sys/kernel/mm/transparent_hugepage/enable_thp_migration.
> 
> I grepped for TRANSPARENT_HUGEPAGE in arch folder and got 9 architectures that
> are supporting transparent hugepage. I mechanically add __pmd_to_swp_entry() and
> __swp_entry_to_pmd() based on existing __pte_to_swp_entry() and
> __swp_entry_to_pte() for all these architectures, except tile which is going to
> be dropped.

This will not work on s390, the pmd layout is very different from the pte
layout. Using __swp_entry/type/offset() on a pmd will go horribly wrong.
I currently don't see a chance to make this work for us, so please make/keep
this configurable, and do not configure it for s390.

Regards,
Gerald


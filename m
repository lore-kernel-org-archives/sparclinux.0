From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 14 Aug 2017 11:40:11 +0000
Subject: Re: [v6 01/15] x86/mm: reserve only exiting low pages
Message-Id: <20170814114011.GG19063@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
 <20170811080706.GC30811@dhcp22.suse.cz>
 <47ebf53b-ea8b-1822-a63a-3682ed2f4753@oracle.com>
In-Reply-To: <47ebf53b-ea8b-1822-a63a-3682ed2f4753@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 11-08-17 11:24:55, Pasha Tatashin wrote:
[...]
> >>In this patchset we will stop zeroing struct page memory during allocation.
> >>Therefore, this bug must be fixed in order to avoid random assert failures
> >>caused by CONFIG_DEBUG_VM_PGFLAGS triggers.
> >>
> >>The fix is to reserve memory from the first existing PFN.
> >
> >Hmm, I assume this is a result of some assert triggering, right? Which
> >one? Why don't we need the same treatment for other than x86 arch?
> 
> Correct, the pgflags asserts were triggered when we were setting reserved
> flags to struct page for PFN 0 in which was never initialized through
> __init_single_page(). The reason they were triggered is because we set all
> uninitialized memory to ones in one of the debug patches.

And why don't we need the same treatment for other architectures?
-- 
Michal Hocko
SUSE Labs

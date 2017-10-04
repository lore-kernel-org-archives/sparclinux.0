From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 04 Oct 2017 08:45:26 +0000
Subject: Re: [PATCH v9 12/12] mm: stop zeroing memory during allocation in vmemmap
Message-Id: <20171004084526.57uzy3t4ualwxdyt@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-13-pasha.tatashin@oracle.com>
 <20171003131952.aqq377pjug5me6go@dhcp22.suse.cz>
 <c028f65a-b4a6-e56d-3a50-5d7ad9af50cb@oracle.com>
 <e5872937-b166-fd48-d46d-1921c738d4b1@oracle.com>
In-Reply-To: <e5872937-b166-fd48-d46d-1921c738d4b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue 03-10-17 16:26:51, Pasha Tatashin wrote:
> Hi Michal,
> 
> I decided not to merge these two patches, because in addition to sparc
> optimization move, we have this dependancies:

optimizations can and should go on top of the core patch.

> mm: zero reserved and unavailable struct pages
> 
> must be before
> 
> mm: stop zeroing memory during allocation in vmemmap.
> 
> Otherwise, we can end-up with struct pages that are not zeroed properly.

Right and you can deal with it easily. Just introduce the
mm_zero_struct_page earlier along with its user in "stop zeroing ..."

I think that moving the zeroying in one go is more reasonable than
adding it to __init_single_page with misleading numbers and later
dropping the zeroying from the memmap path.
-- 
Michal Hocko
SUSE Labs

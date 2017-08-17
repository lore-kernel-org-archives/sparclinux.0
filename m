From: Michal Hocko <mhocko@kernel.org>
Date: Thu, 17 Aug 2017 15:43:24 +0000
Subject: Re: [v6 05/15] mm: don't accessed uninitialized struct pages
Message-Id: <20170817154324.GB3146@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-6-git-send-email-pasha.tatashin@oracle.com>
 <20170811093746.GF30811@dhcp22.suse.cz>
 <8444cb2b-b134-e9fc-a458-1ba7b22a8df1@oracle.com>
 <20170814114755.GI19063@dhcp22.suse.cz>
 <e339a33c-d16b-91bd-5df0-18f5ec03d52b@oracle.com>
 <139b7d83-12a3-d584-0461-d01a79df5d2b@oracle.com>
In-Reply-To: <139b7d83-12a3-d584-0461-d01a79df5d2b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu 17-08-17 11:28:23, Pasha Tatashin wrote:
> Hi Michal,
> 
> I've been looking through this code again, and I think your suggestion will
> work. I did not realize this iterator already exist:
> 
> for_each_free_mem_range() basically iterates through (memory && !reserved)
> 
> This is exactly what we need here. So, I will update this patch to use this
> iterator, which will simplify it.

Please have a look at
http://lkml.kernel.org/r/20170815093306.GC29067@dhcp22.suse.cz
I believe we can simply drop the check altogether.
-- 
Michal Hocko
SUSE Labs

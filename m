From: Michal Hocko <mhocko@kernel.org>
Date: Fri, 05 May 2017 13:29:41 +0000
Subject: Re: [PATCH v3 4/4] mm: Adaptive hash table scaling
Message-Id: <20170505132941.GB31461@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1488432825-92126-1-git-send-email-pasha.tatashin@oracle.com>
 <1488432825-92126-5-git-send-email-pasha.tatashin@oracle.com>
 <20170303153247.f16a31c95404c02a8f3e2c5f@linux-foundation.org>
 <20170426201126.GA32407@dhcp22.suse.cz>
 <40f72efa-3928-b3c6-acca-0740f1a15ba4@oracle.com>
In-Reply-To: <40f72efa-3928-b3c6-acca-0740f1a15ba4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Thu 04-05-17 14:23:24, Pasha Tatashin wrote:
> Hi Michal,
> 
> I do not really want to impose any hard limit, because I do not know what it
> should be.
> 
> The owners of the subsystems that use these large hash table should make a
> call, and perhaps pass high_limit, if needed into alloc_large_system_hash().

Some of surely should. E.g. mount_hashtable resp. mountpoint_hashtable
really do not need a large hash AFAIU. On the other hand it is somehow
handy to scale dentry and inode hashes according to the amount of
memory. But the scale factor should be much slower than the current
upstream implementation. As I've said I do not want to judge your
scaling change. All I am saying that making it explicit is just _wrong_
because it a) doesn't cover all cases just the two you have noticed and
b) new users will most probably just copy&paste existing users so
chances are they will introduce the same large hashtables without a good
reason. I would even say that user shouldn't care about how the scaling
is implemented. There is a way to limit it and if there is no limit set
then just do whatever is appropriate.

> 
> Previous growth rate was unacceptable, because in addition to allocating
> large tables (which is acceptable if we take a total system memory size), we
> also needed to zero that, and zeroing while we have only one CPU available
> was significantly reducing the boot time.
> 
> Now, on 32T the hash table is 1G instead of 32G, so the call is 32 times
> faster to finish. While it is not a good idea to waste memory, both 1G and
> 32G is insignificant amount of memory compared to the total amount of such
> 32T systems (0.09% and 0.003% accordingly).

Try to think in terms of hashed objects. How many objects would we need
to hash? Also this might be not a significant portion of the memory but
it is still a memory which can be used for other purposes.
-- 
Michal Hocko
SUSE Labs

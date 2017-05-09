From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 09 May 2017 09:46:07 +0000
Subject: Re: [PATCH v3 4/4] mm: Adaptive hash table scaling
Message-Id: <20170509094607.GG6481@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1488432825-92126-1-git-send-email-pasha.tatashin@oracle.com>
 <1488432825-92126-5-git-send-email-pasha.tatashin@oracle.com>
 <20170303153247.f16a31c95404c02a8f3e2c5f@linux-foundation.org>
 <20170426201126.GA32407@dhcp22.suse.cz>
 <40f72efa-3928-b3c6-acca-0740f1a15ba4@oracle.com>
 <429c8506-c498-0599-4258-7bac947fe29c@oracle.com>
 <20170505133029.GC31461@dhcp22.suse.cz>
 <e7c61dec-9d57-957b-7ff5-8247fa51eafb@oracle.com>
In-Reply-To: <e7c61dec-9d57-957b-7ff5-8247fa51eafb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Fri 05-05-17 11:33:36, Pasha Tatashin wrote:
> 
> 
> On 05/05/2017 09:30 AM, Michal Hocko wrote:
> >On Thu 04-05-17 14:28:51, Pasha Tatashin wrote:
> >>BTW, I am OK with your patch on top of this "Adaptive hash table" patch, but
> >>I do not know what high_limit should be from where HASH_ADAPT will kick in.
> >>128M sound reasonable to you?
> >
> >For simplicity I would just use it unconditionally when no high_limit is
> >set. What would be the problem with that?
> 
> Sure, that sounds good.
> 
>  If you look at current users
> >(and there no new users emerging too often) then most of them just want
> >_some_ scaling. The original one obviously doesn't scale with large
> >machines. Are you OK to fold my change to your patch or you want me to
> >send a separate patch? AFAIK Andrew hasn't posted this patch to Linus
> >yet.
> >
> 
> I would like a separate patch because mine has soaked in mm tree for a while
> now.

OK, Andrew tends to fold follow up fixes in his mm tree. But anyway, as
you prefer to have this in a separate patch. Could you add this on top
Andrew? I believe mnt hash tables need a _reasonable_ upper bound but
that is for a separate patch I believe.
--- 
From ac970fdb3e6f5f03a440fdbe6fe09460d99d3557 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Tue, 9 May 2017 11:34:59 +0200
Subject: [PATCH] mm: drop HASH_ADAPT

"mm: Adaptive hash table scaling" has introduced a new large hash table
automatic scaling because the previous implementation led to too large
hashes on TB systems. This is all nice and good but the patch assumes that
callers of alloc_large_system_hash will opt-in to use this new scaling.
This makes the API unnecessarily complicated and error prone. The only
thing that callers should care about is whether they have an upper
bound for the size or leave it to alloc_large_system_hash to decide (by
providing high_limit = 0).

As a quick code inspection shows there are users with high_limit = 0
which do not use the flag already e.g. {dcache,inode}_init_early or
mnt_init when creating mnt has tables. They certainly have no good
reason to use a different scaling because the [di]cache was the
motivation for introducing a different scaling in the first place (we
just do this attempt and use memblock). It is also hard to imagine why
we would mnt hash tables need larger hash tables.

Just drop the flag and use the scaling whenever there is no high_limit
specified.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 fs/dcache.c             | 2 +-
 fs/inode.c              | 2 +-
 include/linux/bootmem.h | 1 -
 mm/page_alloc.c         | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 808ea99062c2..363502faa328 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3585,7 +3585,7 @@ static void __init dcache_init(void)
 					sizeof(struct hlist_bl_head),
 					dhash_entries,
 					13,
-					HASH_ZERO | HASH_ADAPT,
+					HASH_ZERO,
 					&d_hash_shift,
 					&d_hash_mask,
 					0,
diff --git a/fs/inode.c b/fs/inode.c
index 32c8ee454ef0..1b15a7cc78ce 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1953,7 +1953,7 @@ void __init inode_init(void)
 					sizeof(struct hlist_head),
 					ihash_entries,
 					14,
-					HASH_ZERO | HASH_ADAPT,
+					HASH_ZERO,
 					&i_hash_shift,
 					&i_hash_mask,
 					0,
diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index dbaf312b3317..e223d91b6439 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -359,7 +359,6 @@ extern void *alloc_large_system_hash(const char *tablename,
 #define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
 					 * shift passed via *_hash_shift */
 #define HASH_ZERO	0x00000004	/* Zero allocated hash table */
-#define	HASH_ADAPT	0x00000008	/* Adaptive scale for large memory */
 
 /* Only NUMA needs hash distribution. 64bit NUMA architectures have
  * sufficient vmalloc space.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index beb2827fd5de..3b840b998c05 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7213,7 +7213,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		if (PAGE_SHIFT < 20)
 			numentries = round_up(numentries, (1<<20)/PAGE_SIZE);
 
-		if (flags & HASH_ADAPT) {
+		if (!high_limit) {
 			unsigned long adapt;
 
 			for (adapt = ADAPT_SCALE_NPAGES; adapt < numentries;
-- 
2.11.0


-- 
Michal Hocko
SUSE Labs

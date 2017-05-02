From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 02 May 2017 08:04:51 +0000
Subject: Re: [PATCH v3 4/4] mm: Adaptive hash table scaling
Message-Id: <20170502080450.GE14593@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1488432825-92126-1-git-send-email-pasha.tatashin@oracle.com>
 <1488432825-92126-5-git-send-email-pasha.tatashin@oracle.com>
 <20170303153247.f16a31c95404c02a8f3e2c5f@linux-foundation.org>
 <20170426201126.GA32407@dhcp22.suse.cz>
In-Reply-To: <20170426201126.GA32407@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Ping on this. Andrew, are you going to fold this or should I post a
separate patch?

[...]
> I cannot say I would be really happy about the chosen approach,
> though. Why HASH_ADAPT is not implicit? Which hash table would need
> gigabytes of memory and still benefit from it? Even if there is such an
> example then it should use the explicit high_limit. I do not like this
> opt-in because it is just too easy to miss that and hit the same issue
> again. And in fact only few users of alloc_large_system_hash are using
> the flag. E.g. why {dcache,inode}_init_early do not have the flag? I
> am pretty sure that having a physically contiguous hash table would be
> better over vmalloc from the TLB point of view.
> 
> mount_hashtable resp. mountpoint_hashtable are another example. Other
> users just have a reasonable max value. So can we do the following
> on top of your commit? I think that we should rethink the scaling as
> well but I do not have a good answer for the maximum size so let's just
> start with a more reasonable API first.
> ---
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 808ea99062c2..363502faa328 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3585,7 +3585,7 @@ static void __init dcache_init(void)
>  					sizeof(struct hlist_bl_head),
>  					dhash_entries,
>  					13,
> -					HASH_ZERO | HASH_ADAPT,
> +					HASH_ZERO,
>  					&d_hash_shift,
>  					&d_hash_mask,
>  					0,
> diff --git a/fs/inode.c b/fs/inode.c
> index a9caf53df446..b3c0731ec1fe 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1950,7 +1950,7 @@ void __init inode_init(void)
>  					sizeof(struct hlist_head),
>  					ihash_entries,
>  					14,
> -					HASH_ZERO | HASH_ADAPT,
> +					HASH_ZERO,
>  					&i_hash_shift,
>  					&i_hash_mask,
>  					0,
> diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
> index dbaf312b3317..e223d91b6439 100644
> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -359,7 +359,6 @@ extern void *alloc_large_system_hash(const char *tablename,
>  #define HASH_SMALL	0x00000002	/* sub-page allocation allowed, min
>  					 * shift passed via *_hash_shift */
>  #define HASH_ZERO	0x00000004	/* Zero allocated hash table */
> -#define	HASH_ADAPT	0x00000008	/* Adaptive scale for large memory */
>  
>  /* Only NUMA needs hash distribution. 64bit NUMA architectures have
>   * sufficient vmalloc space.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fa752de84eef..3bf60669d200 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7226,7 +7226,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  		if (PAGE_SHIFT < 20)
>  			numentries = round_up(numentries, (1<<20)/PAGE_SIZE);
>  
> -		if (flags & HASH_ADAPT) {
> +		if (!high_limit) {
>  			unsigned long adapt;
>  
>  			for (adapt = ADAPT_SCALE_NPAGES; adapt < numentries;
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs

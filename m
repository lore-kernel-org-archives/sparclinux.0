From: "Art Haas" <ahaas@airmail.net>
Date: Thu, 29 Apr 2004 18:03:31 +0000
Subject: 2.6.6-rc boot problems seem to come from nr_free_pages() call
Message-Id: <20040429180331.GC27793@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

All the 2.6.6-rc kernels have failed to boot on my SS20, including the
latest -rc3. Things get stuck, and after mailing the list previously the
suggestion to boot with a '-p' option was sent to me. Using this option
I observed things got stuck after the dcache_init() function in
fs/dcache.c. The next function to be called is inode_init() in
fs/inode.c

I've added a bunch of printk() statements to these two files, and it
looks like things blow up because of the value returned by an
nr_free_pages() call in vfs_caches_init(). It is in vfs_caches_init()
that dcache_init() and inodes_init() are called. My printk() adding
patches are attached below if others want to try them.

With these patches in place, the following values are observed during
bootup. vfs_caches_init() is called with 46073 mempages (my machine has
512M memory, 50M swap). Setting the 'reserve' variable calls
nr_free_pages(), and sets this value to 2147361266 - 2G!. The mempages
value is then adjusted to 2177652103. This value is then used when
calling dcache_init() and inodes_init(). In dcache_init(), the
'dhash_entries" variable gets set to 1073826051, then after the
multiplication it is 336808 due to overflow. In inodes_init(), the
'ihash_entries' variable is set to 536913025, then after the
multiplication it goes up to 2147652100. As I do not see the print out
of the 'order' variable, it looks like things get stuck in the for loop
that increments order.

I'll be investigating the nr_free_pages() stuff to see if I can figure
out where things look like they go wrong. Perhaps some variable is not
initialized, or maybe sparc32 needs some magic done for the
zone->free_pages stuff to be correct.

I'd like to hear what others see if they apply these printk() patches
and try the 2.6.6-rc kernels.

Art Haas

=== fs/dcache.c 1.71 vs edited ==--- 1.71/fs/dcache.c	Tue Apr 27 00:07:34 2004
+++ edited/fs/dcache.c	Thu Apr 29 12:24:12 2004
@@ -1554,6 +1554,7 @@
 	unsigned int nr_hash;
 	int i;
 
+	printk("dcache_init: %lu mempages\n", mempages);
 	/* 
 	 * A constructor could be added for stable state like the lists,
 	 * but it is probably not worth it because of the cache nature
@@ -1572,12 +1573,15 @@
 	
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
+	printk("dhash_entries: %lu\n", dhash_entries);
 	if (!dhash_entries)
 		dhash_entries = PAGE_SHIFT < 13 ?
 				mempages >> (13 - PAGE_SHIFT) :
 				mempages << (PAGE_SHIFT - 13);
 
+	printk("dhash_entries: %lu\n", dhash_entries);
 	dhash_entries *= sizeof(struct hlist_head);
+	printk("dhash_entries: %lu\n", dhash_entries);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < dhash_entries; order++)
 		;
 
@@ -1627,11 +1631,14 @@
 {
 	unsigned long reserve;
 
+	printk("vfs_caches_init(): %lu mempages\n", mempages);
 	/* Base hash sizes on available memory, with a reserve equal to
            150% of current kernel size */
 
 	reserve = (mempages - nr_free_pages()) * 3/2;
+	printk("reserve: %lu\n", reserve);
 	mempages -= reserve;
+	printk("mempages: %lu\n", mempages);
 
 	names_cachep = kmem_cache_create("names_cache",
 			PATH_MAX, 0,
@@ -1645,11 +1652,17 @@
 	if(!filp_cachep)
 		panic("Cannot create filp SLAB cache");
 
+	printk("calling dcache_init(%lu)\n", mempages);
 	dcache_init(mempages);
+	printk("calling inode_init(%lu)\n", mempages);
 	inode_init(mempages);
+	printk("calling files_init(%lu)\n", mempages);
 	files_init(mempages);
+	printk("calling mnt_init(%lu)\n", mempages);
 	mnt_init(mempages);
+	printk("calling bdev_cache_init()\n");
 	bdev_cache_init();
+	printk("calling chrdev_init()\n");
 	chrdev_init();
 }
 
=== fs/inode.c 1.120 vs edited ==--- 1.120/fs/inode.c	Mon Apr 12 12:54:37 2004
+++ edited/fs/inode.c	Thu Apr 29 12:25:25 2004
@@ -1339,18 +1339,23 @@
 	unsigned int nr_hash;
 	int i;
 
+	printk("inode_init: %lu mempages\n", mempages);
 	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
+	printk("ihash_entries: %lu\n", ihash_entries);
 	if (!ihash_entries)
 		ihash_entries = PAGE_SHIFT < 14 ?
 				mempages >> (14 - PAGE_SHIFT) :
 				mempages << (PAGE_SHIFT - 14);
 
+	printk("ihash_entries: %lu\n", ihash_entries);
 	ihash_entries *= sizeof(struct hlist_head);
+	printk("ihash_entries: %lu\n", ihash_entries);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < ihash_entries; order++)
 		;
 
+	printk("order: %lu\n", order);
 	do {
 		unsigned long tmp;
 
@@ -1365,6 +1370,7 @@
 
 		inode_hashtable = (struct hlist_head *)
 			__get_free_pages(GFP_ATOMIC, order);
+		printk("inode_hashtable: %p\n", (void *)inode_hashtable);
 	} while (inode_hashtable = NULL && --order >= 0);
 
 	printk("Inode-cache hash table entries: %d (order: %ld, %ld bytes)\n",

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 12 Oct 2014 11:52:03 +0000
Subject: Kernel unaligned access in kmem_cache_free, free_block, kmem_cache_alloc, cache_alloc_refill
Message-Id: <alpine.LRH.2.11.1410121447210.22151@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I updated my T2000 to todays upstream git to test all the new code. It 
seems to work fine so far but logs a lot of kernel unaligned accesses. 
This during the bootup:

[   47.744080] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   47.744142] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   47.744196] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   47.744249] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   47.744302] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   54.683265] log_unaligned: 13 callbacks suppressed
[   54.683374] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   54.683539] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   54.683607] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   54.683770] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   57.683274] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   60.683265] log_unaligned: 1 callbacks suppressed
[   60.683372] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   60.683538] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   69.538349] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   69.538435] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   69.538516] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   69.538595] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   69.538674] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[   74.795355] log_unaligned: 2472 callbacks suppressed
[   74.795547] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   74.795664] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   74.795828] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   74.796042] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   74.796162] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   79.831281] log_unaligned: 265 callbacks suppressed
[   79.831413] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   79.831578] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   79.831646] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   79.831712] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   79.835284] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   84.895278] log_unaligned: 245 callbacks suppressed
[   84.895403] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   84.895568] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   84.895635] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   84.895701] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   84.895767] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   89.907321] log_unaligned: 57 callbacks suppressed
[   89.907446] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   89.907611] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   89.919301] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   89.919471] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   89.935509] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   94.983480] log_unaligned: 55 callbacks suppressed
[   94.983610] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   94.983775] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   95.951440] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[   95.951612] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[   95.963432] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  101.991449] log_unaligned: 45 callbacks suppressed
[  101.991579] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  101.991744] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  102.051652] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  102.051824] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  103.587324] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  107.033540] log_unaligned: 1338 callbacks suppressed
[  107.033734] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  107.046559] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  107.050792] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  107.059632] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  107.076432] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  112.050682] log_unaligned: 2448 callbacks suppressed
[  112.050876] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  112.051492] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  112.051675] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  112.051756] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  112.051835] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  117.058184] log_unaligned: 2935 callbacks suppressed
[  117.058378] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  117.058564] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  117.059489] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  117.059702] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  117.059846] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  122.783348] log_unaligned: 3167 callbacks suppressed
[  122.783541] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  122.783658] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  122.783776] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  122.783941] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  122.784158] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  127.899392] log_unaligned: 914 callbacks suppressed
[  127.899525] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  127.899690] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  127.899811] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  127.900025] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  127.903494] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  133.327370] log_unaligned: 347 callbacks suppressed
[  133.327489] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  133.327654] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  133.327723] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  133.327790] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  133.327857] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  138.671408] log_unaligned: 179 callbacks suppressed
[  138.671534] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  138.671548] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  138.671568] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  138.671582] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  138.671595] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  144.327264] log_unaligned: 462 callbacks suppressed
[  144.327385] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  144.327550] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  144.327618] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  144.327684] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  144.327750] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  149.391368] log_unaligned: 314 callbacks suppressed
[  149.391506] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  149.391523] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  149.391579] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  149.391598] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  149.391677] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  154.735308] log_unaligned: 305 callbacks suppressed
[  154.735431] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  154.735597] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  154.739474] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  154.739663] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  154.739793] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  160.343243] log_unaligned: 202 callbacks suppressed
[  160.343360] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  160.343524] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  160.347454] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  160.347673] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  160.347811] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  165.599424] log_unaligned: 116 callbacks suppressed
[  165.599547] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  165.599720] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  165.599840] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  165.600007] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  165.600221] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  170.943428] log_unaligned: 416 callbacks suppressed
[  170.943561] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  170.943726] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  170.943799] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  170.943866] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  170.943934] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  176.575258] log_unaligned: 858 callbacks suppressed
[  176.575396] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  176.575571] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  176.575644] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  176.575716] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  176.575788] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  182.791241] log_unaligned: 761 callbacks suppressed
[  182.791374] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  182.791539] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  182.791607] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  182.791673] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  182.791744] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  188.575355] log_unaligned: 414 callbacks suppressed
[  188.575479] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  188.575644] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  188.575760] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  188.575973] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  188.576041] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  193.595289] log_unaligned: 151 callbacks suppressed
[  193.595409] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  193.595575] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  193.595644] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  193.595808] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  193.596023] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  198.761366] log_unaligned: 128 callbacks suppressed
[  198.761487] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  198.763541] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  198.763636] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  198.763838] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  198.763917] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  204.495287] log_unaligned: 144 callbacks suppressed
[  204.495407] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  204.495587] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  204.495716] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  204.495942] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  204.496021] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  209.503333] log_unaligned: 221 callbacks suppressed
[  209.503468] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  209.503652] Kernel unaligned access at TPC[566cf0] kmem_cache_alloc+0xf0/0x1e0
[  209.503869] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  209.504051] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  209.504185] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  214.687317] log_unaligned: 209 callbacks suppressed
[  214.687455] Kernel unaligned access at TPC[56528c] kmem_cache_free+0xcc/0x1e0
[  214.687469] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  214.687489] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  214.687503] Kernel unaligned access at TPC[5648a8] free_block+0xa8/0x1c0
[  214.687516] Kernel unaligned access at TPC[5648a0] free_block+0xa0/0x1c0
[  220.274604] log_unaligned: 133 callbacks suppressed
[  220.274732] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  220.274911] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  220.275090] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  220.275269] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360
[  220.275396] Kernel unaligned access at TPC[566400] cache_alloc_refill+0x1a0/0x360

-- 
Meelis Roos (mroos@linux.ee)

From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 07:50:36 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080512.005036.19633770.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18465.63175.561233.228014@alkaid.it.uu.se>
In-Reply-To: <18465.63175.561233.228014@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 7 May 2008 20:36:55 +0200

> Now that 2.6.26-rc1 boots on my Ultra5, I noticed that it
> reports having only 128MB RAM, while earlier kernels reported
> the correct amount: 256MB.
>=20
> A diff of the dmesg output from 2.6.25 and 2.6.26-rc1 shows:

Try as I might I couldn't reproduce this, although I did find another
bug along the way.

But that's OK, we'll add some debugging and fetch the necessary
information from your machine.

The good news is that the early bootup does see all 256MB of your
memory:

Top of RAM: 0x17f46000, Total RAM: 0xff40000
Memory hole size: 128MB
Entering add_active_range(0, 0, 16384) 0 entries of 256 used
Entering add_active_range(0, 32768, 49023) 1 entries of 256 used
Entering add_active_range(0, 49024, 49053) 2 entries of 256 used
Entering add_active_range(0, 49055, 49059) 3 entries of 256 used

That "0xff40000" value is 267649024 decimal, and the size of the page
ranges registered next match up.

And yet we get:

Memory: 127016k available (1920k kernel code, 744k data, 152k init) [fffff8=
0000000000,0000000017f46000]

which is strange.

Between these two events there is only a handfull of bootmem
allocations, which together should not total 128MB on your
machine. :-)

We have some existing debugging, which I'd like you to enable on the
boot command line.  Simply add "numa=DEbug" and that'll get some more
vebose information.

Please also add the debugging patch below.

Thanks!

diff --git a/lib/lmb.c b/lib/lmb.c
index 83287d3..3f55973 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -19,6 +19,8 @@
=20
 struct lmb lmb;
=20
+#define DEBUG
+
 void lmb_dump_all(void)
 {
 #ifdef DEBUG
@@ -29,7 +31,7 @@ void lmb_dump_all(void)
 	pr_debug("    memory.size		  =3D 0x%llx\n",
 	    (unsigned long long)lmb.memory.size);
 	for (i=3D0; i < lmb.memory.cnt ;i++) {
-		pr_debug("    memory.region[0x%x].base       =3D 0x%llx\n",
+		pr_debug("    memory.region[0x%lx].base       =3D 0x%llx\n",
 		    i, (unsigned long long)lmb.memory.region[i].base);
 		pr_debug("		      .size     =3D 0x%llx\n",
 		    (unsigned long long)lmb.memory.region[i].size);
@@ -38,7 +40,7 @@ void lmb_dump_all(void)
 	pr_debug("    reserved.cnt	  =3D 0x%lx\n", lmb.reserved.cnt);
 	pr_debug("    reserved.size	  =3D 0x%lx\n", lmb.reserved.size);
 	for (i=3D0; i < lmb.reserved.cnt ;i++) {
-		pr_debug("    reserved.region[0x%x].base       =3D 0x%llx\n",
+		pr_debug("    reserved.region[0x%lx].base       =3D 0x%llx\n",
 		    i, (unsigned long long)lmb.reserved.region[i].base);
 		pr_debug("		      .size     =3D 0x%llx\n",
 		    (unsigned long long)lmb.reserved.region[i].size);
diff --git a/mm/bootmem.c b/mm/bootmem.c
index e8fb927..78e6216 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -242,6 +242,10 @@ __alloc_bootmem_core(struct bootmem_data *bdata, unsig=
ned long size,
 	unsigned long node_boot_start;
 	void *node_bootmem_map;
=20
+#if 1
+	printk(KERN_ERR "__alloc_bootmem_core: size(%lu) align(%lu) goal[0x%lx] l=
imit[0x%lx]\n",
+	       size, align, goal, limit);
+#endif
 	if (!size) {
 		printk("__alloc_bootmem_core(): zero-sized request\n");
 		BUG();
@@ -369,6 +373,17 @@ found:
 	return ret;
 }
=20
+static void report_range(unsigned long *start, unsigned long pfn)
+{
+	if (*start =3D ~0UL)
+		return;
+
+	printk(KERN_ERR "free_all_bootmem_core: Freed pfn range [0x%lx --> 0x%lx]=
\n",
+	       *start, pfn);
+
+	*start =3D ~0UL;
+}
+
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
 	struct page *page;
@@ -377,6 +392,7 @@ static unsigned long __init free_all_bootmem_core(pg_da=
ta_t *pgdat)
 	unsigned long i, count, total =3D 0;
 	unsigned long idx;
 	unsigned long *map;=20
+	unsigned long debug_start_pfn =3D ~0UL;
 	int gofast =3D 0;
=20
 	BUG_ON(!bdata->node_bootmem_map);
@@ -390,12 +406,17 @@ static unsigned long __init free_all_bootmem_core(pg_=
data_t *pgdat)
 	if (bdata->node_boot_start =3D 0 ||
 	    ffs(bdata->node_boot_start) - PAGE_SHIFT > ffs(BITS_PER_LONG))
 		gofast =3D 1;
+	printk(KERN_ERR "free_all_bootmem_core: pfn[0x%lx] idx[0x%lx] gofast(%d) "
+	       "node_boot_start[0x%lx]\n",
+	       pfn, idx, gofast, bdata->node_boot_start);
 	for (i =3D 0; i < idx; ) {
 		unsigned long v =3D ~map[i / BITS_PER_LONG];
=20
 		if (gofast && v =3D ~0UL) {
 			int order;
=20
+			if (debug_start_pfn =3D ~0UL)
+				debug_start_pfn =3D pfn;
 			page =3D pfn_to_page(pfn);
 			count +=3D BITS_PER_LONG;
 			order =3D ffs(BITS_PER_LONG) - 1;
@@ -403,20 +424,27 @@ static unsigned long __init free_all_bootmem_core(pg_=
data_t *pgdat)
 			i +=3D BITS_PER_LONG;
 			page +=3D BITS_PER_LONG;
 		} else if (v) {
-			unsigned long m;
+			unsigned long m, debug_index;
=20
 			page =3D pfn_to_page(pfn);
-			for (m =3D 1; m && i < idx; m<<=3D1, page++, i++) {
+			debug_index =3D 0;
+			for (m =3D 1; m && i < idx; m<<=3D1, page++, i++, debug_index++) {
 				if (v & m) {
+					if (debug_start_pfn =3D ~0UL)
+						debug_start_pfn =3D pfn + debug_index;
 					count++;
 					__free_pages_bootmem(page, 0);
+				} else {
+					report_range(&debug_start_pfn, pfn + debug_index);
 				}
 			}
 		} else {
+			report_range(&debug_start_pfn, pfn);
 			i +=3D BITS_PER_LONG;
 		}
 		pfn +=3D BITS_PER_LONG;
 	}
+	report_range(&debug_start_pfn, pfn);
 	total +=3D count;
=20
 	/*

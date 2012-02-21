From: Tejun Heo <tj@kernel.org>
Date: Tue, 21 Feb 2012 01:05:37 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202130942030.1488@math.ut.ee>
 <20120213080618.GA11077@ponder.secretlab.ca>
 <alpine.SOC.1.00.1202131119040.1488@math.ut.ee>
 <20120213214623.GJ11077@ponder.secretlab.ca>
 <alpine.SOC.1.00.1202162151030.16208@math.ut.ee>
 <alpine.SOC.1.00.1202201109260.467@math.ut.ee>
 <20120220170603.GC7836@mtj.dyndns.org>
 <alpine.SOC.1.00.1202210030530.11350@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202210030530.11350@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Meelis Roos <mroos@linux.ee>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, sam@ravnborg.org, "David S. Miller" <davem@davemloft.net>

Hello,

Meelis, can you please apply the following patch before & after the
offending commit, boot with "memblock=DEbug" added as kernel param and
post the boot log?  The patch will generate some offset warnings after
the commit but should work fine.

Sam, David, as I'm not familiar with the code base, is it possible to
tell which address is corrupted (zeroed, it seems)?  ie. can we add
"if (XXX =3D NULL) printk("%p is corrputed\n"...);" somewhere?

Thanks.

diff --git a/mm/memblock.c b/mm/memblock.c
index 1adbef0..dccfced 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -179,9 +179,15 @@ int __init_memblock memblock_reserve_reserved_regions(=
void)
=20
 static void __init_memblock memblock_remove_region(struct memblock_type *t=
ype, unsigned long r)
 {
-	type->total_size -=3D type->regions[r].size;
-	memmove(&type->regions[r], &type->regions[r + 1],
-		(type->cnt - (r + 1)) * sizeof(type->regions[r]));
+	struct memblock_region *rgn =3D &type->regions[r];
+
+	memblock_dbg("     memblock %s: rm  [%#016llx-%#016llx] node %d\n",
+		     memblock_type_name(type),
+		     (unsigned long long)rgn->base,
+		     (unsigned long long)rgn->base + rgn->size, rgn->nid);
+
+	type->total_size -=3D rgn->size;
+	memmove(rgn, rgn + 1, (type->cnt - (r + 1)) * sizeof(*rgn));
 	type->cnt--;
=20
 	/* Special case for empty arrays */
@@ -317,6 +323,9 @@ static void __init_memblock memblock_insert_region(stru=
ct memblock_type *type,
 	memblock_set_region_node(rgn, nid);
 	type->cnt++;
 	type->total_size +=3D size;
+	memblock_dbg("   memblock %s: add [%#016llx-%016llx] node %d @%d\n",
+		     memblock_type_name(type), (unsigned long long)base,
+		     (unsigned long long)base + size, nid, idx);
 }
=20
 /**
@@ -342,6 +351,10 @@ static int __init_memblock memblock_add_region(struct =
memblock_type *type,
 	phys_addr_t end =3D base + memblock_cap_size(base, &size);
 	int i, nr_new;
=20
+	memblock_dbg("   memblock %s: ADD [%#016llx-%#016llx] node %d\n",
+		     memblock_type_name(type), (unsigned long long)base,
+		     (unsigned long long)base + size, nid);
+
 	/* special case for empty array */
 	if (type->regions[0].size =3D 0) {
 		WARN_ON(type->cnt !=3D 1 || type->total_size);
@@ -349,6 +362,8 @@ static int __init_memblock memblock_add_region(struct m=
emblock_type *type,
 		type->regions[0].size =3D size;
 		memblock_set_region_node(&type->regions[0], nid);
 		type->total_size =3D size;
+		memblock_dbg("     memblock %s: add first entry\n",
+			     memblock_type_name(type));
 		return 0;
 	}
 repeat:
@@ -494,6 +509,10 @@ static int __init_memblock __memblock_remove(struct me=
mblock_type *type,
 	int start_rgn, end_rgn;
 	int i, ret;
=20
+	memblock_dbg("     memblock %s: RM  [%#016llx-%016llx]\n",
+		     memblock_type_name(type), (unsigned long long)base,
+		     (unsigned long long)base + size);
+
 	ret =3D memblock_isolate_range(type, base, size, &start_rgn, &end_rgn);
 	if (ret)
 		return ret;

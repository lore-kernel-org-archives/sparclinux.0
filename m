From: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 04 Feb 2017 16:32:22 +0000
Subject: [PATCH] sparc: topology_64.h: Fix condition for including cpudata.h
Message-Id: <20170204163222.GT3442@decadent.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Q43QQdzFtqSKgsg+"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--Q43QQdzFtqSKgsg+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We currently define macros referring to cpu_data if CONFIG_SMP is
defined, but only include the declaration if CONFIG_NUMA is defined.

Fixes: 541cc39433a8 ("sparc: fix a building error reported by kbuild")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -4,7 +4,6 @@
 #ifdef CONFIG_NUMA
=20
 #include <asm/mmzone.h>
-#include <asm/cpudata.h>
=20
 static inline int cpu_to_node(int cpu)
 {
@@ -42,6 +41,9 @@ int __node_distance(int, int);
 #endif /* !(CONFIG_NUMA) */
=20
 #ifdef CONFIG_SMP
+
+#include <asm/cpudata.h>
+
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).proc_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).core_id)
 #define topology_core_cpumask(cpu)		(&cpu_core_sib_map[cpu])

--Q43QQdzFtqSKgsg+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWJYCFue/yOyVhhEJAQqwtQ//dGqVYE63oBNg5HjlyBOEsQfmdr/viwTf
yjRJ6kpfi7LgEs7Q+T2nWfRRgTZYvNXYjxxDEeYhLyLJifKrB9CdqVTdcaSejygf
43XYWHct4R2LLxs5+MFZ/T3bRxS7rMoyb9Bw7rSx8ISgGKMd8MfQ2YdPDJXcPvLs
YUKSNm/+ysqC5mI17/zR8zIunyOeOj9GiRRsFGeCMOBuglfyztSugNftCfZEy1Li
e9c64dRY9wK3Qma3Ds8FuYl9Zk5AIw1w2X8Ok1EsBd6UaUtjEjTKGOViREKWgWfF
KzEf5Sn8vNqQj7ZdYfq/2otnw/HEuHvjeDRTFhkCNCDt78QImeZV9J1qygKGHDrE
VyBcx8Afs7D+YsIAoVjEtA49AkDriuQRfqTW38OubwZpTOkluWlyRd0tdw7H06YD
zppQoXqrwD0cSx0c3gjVGk/sBWHkFA0lOgn9M2bceldu9CIaf/eaiiNZfN3Yom6g
vK051EY7az2fhDtCt2EVHMNoog4QtuodgBi0PfZhzhlcoRkALGZISMlIkWiplOvN
+DREqpWmPpaoIDl27B8uvYCnixh+CEgXW5a/QJlEdtRqni5knqZcmp5+slITQoz7
GSJbCf5AO81L+f+DnH97pUSXdmZ71jQSSjqOzSLj2aYjdBXUFZxVetlGD4QhvSOc
OLUQkc729Pg=
=p/gh
-----END PGP SIGNATURE-----

--Q43QQdzFtqSKgsg+--

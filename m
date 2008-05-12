From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 22:31:43 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080512.153143.48741227.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18465.63175.561233.228014@alkaid.it.uu.se>
	<20080512.005036.19633770.davem@davemloft.net>
	<18472.38209.615770.265421@alkaid.it.uu.se>
In-Reply-To: <18472.38209.615770.265421@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 12 May 2008 21:06:41 +0200

> David Miller writes:
>  > Please also add the debugging patch below.
>=20
> Right, 2.6.26-rc2 plus your debugging patch and booted with numa=DEbug
> prints the following:

Hmmm... my debugging patch had this:

diff --git a/lib/lmb.c b/lib/lmb.c
index 83287d3..3f55973 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
 ...
+#define DEBUG
+

which should have resulted in lmb_dump_all() printing some userful
debugging messages.  I validated that it did so on my machine with the
patch applied, but they appear nowhere in your logs :(

paginig_init() in arch/sparc64/mm/init.c calls lmb_analyze() them lmb_dump_=
all().

Those messages go out with KERN_DEBUG log level, maybe messages at
that level were trimmed by your log capture for some reason?

In any event I think I know the area that's cause some kind of problem.
It looks like lmb_alloc() has a case where it will reserve the wrong
amount of memory, or something like that.

You can remove the debugging patch I sent you, and try this one instead.
Please make sure KERN_DEBUG messages make it into the log :-)

diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index a9828d7..a628a99 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -1353,6 +1353,8 @@ static void __init bootmem_init_one_node(int nid)
=20
 	numadbg("bootmem_init_one_node(%d)\n", nid);
=20
+	lmb_dump_all();
+
 	p =3D NODE_DATA(nid);
=20
 	if (p->node_spanned_pages) {
diff --git a/lib/lmb.c b/lib/lmb.c
index 83287d3..d8c84f3 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -17,6 +17,8 @@
=20
 #define LMB_ALLOC_ANYWHERE	0
=20
+#define DEBUG
+
 struct lmb lmb;
=20
 void lmb_dump_all(void)
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

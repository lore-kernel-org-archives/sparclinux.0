From: Tejun Heo <tj@kernel.org>
Date: Wed, 22 Feb 2012 17:48:25 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120222174825.GA32694@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202130942030.1488@math.ut.ee>
 <20120213080618.GA11077@ponder.secretlab.ca>
 <alpine.SOC.1.00.1202131119040.1488@math.ut.ee>
 <20120213214623.GJ11077@ponder.secretlab.ca>
 <alpine.SOC.1.00.1202162151030.16208@math.ut.ee>
 <alpine.SOC.1.00.1202201109260.467@math.ut.ee>
 <20120220170603.GC7836@mtj.dyndns.org>
 <alpine.SOC.1.00.1202210030530.11350@math.ut.ee>
 <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com>
 <alpine.SOC.1.00.1202220213180.4171@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202220213180.4171@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Meelis Roos <mroos@linux.ee>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, sam@ravnborg.org, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 22, 2012 at 02:36:13AM +0200, Meelis Roos wrote:
> > Meelis, can you please apply the following patch before & after the
> > offending commit, boot with "memblock=DEbug" added as kernel param and
> > post the boot log?  The patch will generate some offset warnings after
> > the commit but should work fine.
>=20
> Before the commit (v3.2-rc3-75-g0ee332c): memblock1.gz (attached)
> After the commit (v3.2-rc3-76-g7bd0b0f): memblock2.gz (attached)

Can you please try the following patch?  If it still fails to boot,
please attach the failing log.  Thank you.

diff --git a/mm/memblock.c b/mm/memblock.c
index 77b5f22..99f2855 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -99,9 +99,6 @@ phys_addr_t __init_memblock memblock_find_in_range_node(p=
hys_addr_t start,
 	phys_addr_t this_start, this_end, cand;
 	u64 i;
=20
-	/* align @size to avoid excessive fragmentation on reserved array */
-	size =3D round_up(size, align);
-
 	/* pump up @end */
 	if (end =3D MEMBLOCK_ALLOC_ACCESSIBLE)
 		end =3D memblock.current_limit;
@@ -731,6 +728,9 @@ static phys_addr_t __init memblock_alloc_base_nid(phys_=
addr_t size,
 {
 	phys_addr_t found;
=20
+	/* align @size to avoid excessive fragmentation on reserved array */
+	size =3D round_up(size, align);
+
 	found =3D memblock_find_in_range_node(0, max_addr, size, align, nid);
 	if (found && !memblock_reserve(found, size))
 		return found;

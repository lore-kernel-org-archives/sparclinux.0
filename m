From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2006 04:05:14 +0000
Subject: Re: Checksum problem on sparc64
Message-Id: <20060604.210514.108742959.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060323223510.GA7683@sceen.net>
In-Reply-To: <20060323223510.GA7683@sceen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 4 Jun 2006 16:34:38 +0200

[ BTW: linux-sparc doesn't exist, the list name is sparclinux.
       Samuel, what in your mail client caused it to change
       from sparclinux@vger to linux-sparc@vger in your replies? ]

> Samuel Thibault, le Sun 04 Jun 2006 16:32:15 +0200, a =E9crit :
> > The last add doesn't take care of the potential carry into the 33th
> > bit.
>=20
> (which _do_ happen when the csum has its 16 MSB set, as Richard pointed
> out).

Thanks for all of the excellent detective work guys.

This patch below should fix things up.

Let me know if it works for you.

diff --git a/arch/sparc64/lib/checksum.S b/arch/sparc64/lib/checksum.S
index ba9cd3c..1d230f6 100644
--- a/arch/sparc64/lib/checksum.S
+++ b/arch/sparc64/lib/checksum.S
@@ -165,8 +165,9 @@ csum_partial_end_cruft:
 	sll		%g1, 8, %g1
 	or		%o5, %g1, %o4
=20
-1:	add		%o2, %o4, %o2
+1:	addcc		%o2, %o4, %o2
+	addc		%g0, %o2, %o2
=20
 csum_partial_finish:
 	retl
-	 mov		%o2, %o0
+	 srl		%o2, 0, %o0

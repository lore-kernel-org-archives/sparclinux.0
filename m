From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Mon, 22 Aug 2005 17:10:28 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <430A0704.3000501@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigFFBE4113B3ABBA2158D69EA9"
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFFBE4113B3ABBA2158D69EA9
Content-Type: multipart/mixed;
 boundary="------------080400020905000108040604"

This is a multi-part message in MIME format.
--------------080400020905000108040604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

> You _could_ experiment with making the code there use
> vmalloc()/vfree() instead, and if you get it working cleanly I'd be
> happy to add such a patch to fix this.

Tested with 5000+ rules.
Does it look clean enough?

-- 
Gustavo Zacarias
Gentoo/SPARC monkey

--------------080400020905000108040604
Content-Type: text/x-patch;
 name="2.4-sparc64-netfilter-ioctl32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4-sparc64-netfilter-ioctl32.patch"

diff -Nura linux-2.4.31/arch/sparc64/kernel/sys_sparc32.c linux-2.4.31.netfilter/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.4.31/arch/sparc64/kernel/sys_sparc32.c	2005-04-03 22:42:19.000000000 -0300
+++ linux-2.4.31.netfilter/arch/sparc64/kernel/sys_sparc32.c	2005-08-22 12:34:14.000000000 -0300
@@ -50,6 +50,7 @@
 #include <linux/in.h>
 #include <linux/icmpv6.h>
 #include <linux/sysctl.h>
+#include <linux/vmalloc.h>
 #include <linux/dnotify.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 
@@ -2919,12 +2920,12 @@
 	if (optlen != kreplsize)
 		return -ENOPROTOOPT;
 
-	krepl = (struct ipt_replace *)kmalloc(kreplsize, GFP_KERNEL);
+	krepl = (struct ipt_replace *)vmalloc(kreplsize);
 	if (krepl == NULL)
 		return -ENOMEM;
 
 	if (copy_from_user(krepl, optval, kreplsize)) {
-		kfree(krepl);
+		vfree(krepl);
 		return -EFAULT;
 	}
 
@@ -2935,7 +2936,7 @@
 	krepl->counters = (struct ipt_counters *)kmalloc(
 					kcountersize, GFP_KERNEL);
 	if (krepl->counters == NULL) {
-		kfree(krepl);
+		vfree(krepl);
 		return -ENOMEM;
 	}
 
@@ -2949,8 +2950,8 @@
 		copy_to_user(counters32, krepl->counters, kcountersize))
 			ret = -EFAULT;
 
-	kfree(krepl->counters);
-	kfree(krepl);
+	vfree(krepl->counters);
+	vfree(krepl);
 
 	return ret;
 }

--------------080400020905000108040604--

--------------enigFFBE4113B3ABBA2158D69EA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDCgcHV3G/IBCn/JARAtAGAJ9qHaCNKBzZapA7On6jIzMat25zYQCeN+v3
DJsxDehTWojeSx4Og4gfuuo=
=QqBf
-----END PGP SIGNATURE-----

--------------enigFFBE4113B3ABBA2158D69EA9--

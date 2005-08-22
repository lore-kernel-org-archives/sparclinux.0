From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Mon, 22 Aug 2005 17:17:45 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <430A08B9.20405@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig9E34BAF60A589F36AAD54FBA"
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E34BAF60A589F36AAD54FBA
Content-Type: multipart/mixed;
 boundary="------------050908070806090004090907"

This is a multi-part message in MIME format.
--------------050908070806090004090907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

> Looks good to me, I'll pass this along to the netfilter maintainers.

Actually i'm still doing a kmalloc for replsize->counter, that may work,
but since we're cleaning up it should be a vmalloc too (specially since
i'm doing a vfree).
Second time is the charm :)

-- 
Gustavo Zacarias
Gentoo/SPARC monkey

--------------050908070806090004090907
Content-Type: text/x-patch;
 name="2.4-netfilter-ioctl32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4-netfilter-ioctl32.patch"

diff -Nura linux-2.4.31/arch/sparc64/kernel/sys_sparc32.c linux-2.4.31.netfilter/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.4.31/arch/sparc64/kernel/sys_sparc32.c	2005-04-03 22:42:19.000000000 -0300
+++ linux-2.4.31.netfilter/arch/sparc64/kernel/sys_sparc32.c	2005-08-22 14:14:40.000000000 -0300
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
 
@@ -2932,10 +2933,9 @@
 		((struct ipt_replace32 *)krepl)->counters);
 
 	kcountersize = krepl->num_counters * sizeof(struct ipt_counters);
-	krepl->counters = (struct ipt_counters *)kmalloc(
-					kcountersize, GFP_KERNEL);
+	krepl->counters = (struct ipt_counters *)vmalloc(kcountersize);
 	if (krepl->counters == NULL) {
-		kfree(krepl);
+		vfree(krepl);
 		return -ENOMEM;
 	}
 
@@ -2949,8 +2949,8 @@
 		copy_to_user(counters32, krepl->counters, kcountersize))
 			ret = -EFAULT;
 
-	kfree(krepl->counters);
-	kfree(krepl);
+	vfree(krepl->counters);
+	vfree(krepl);
 
 	return ret;
 }

--------------050908070806090004090907--

--------------enig9E34BAF60A589F36AAD54FBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDCgi8V3G/IBCn/JARArHpAJ91fj0ixjGAzSf5JA5dZhRZg0ASTgCfVY/2
rAAasTuklfTu8ev3EgfRohc=
=h2Lb
-----END PGP SIGNATURE-----

--------------enig9E34BAF60A589F36AAD54FBA--

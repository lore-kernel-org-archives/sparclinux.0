From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 11 Feb 2013 07:34:09 +0000
Subject: linux-next: build failure after merge of the final tree (acpi tree related)
Message-Id: <20130211183409.7519b73ca320baeac5ec886f@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__11_Feb_2013_18_34_09_+1100_fSZSOVNmThUvLVOt"
List-Id: <sparclinux.vger.kernel.org>
References: <BANLkTim5dYNmTMJo-Wa3LYCTi4vxPGMNeQ@mail.gmail.com>
In-Reply-To: <BANLkTim5dYNmTMJo-Wa3LYCTi4vxPGMNeQ@mail.gmail.com>
To: Len Brown <len.brown@intel.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

--Signature=_Mon__11_Feb_2013_18_34_09_+1100_fSZSOVNmThUvLVOt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (sparc64 defconfig)
failed like this:

arch/sparc/include/asm/processor.h: Assembler messages:
arch/sparc/include/asm/processor.h:10: Error: Unknown opcode: `extern'

Caused by commit 3a242f58a5f4 ("sparc idle: rename pm_idle to
sparc_idle") from the acpi tree.

I have applied this patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 11 Feb 2013 18:30:19 +1100
Subject: [PATCH] sparc idle: protect variable declarations against the asse=
mbler

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/asm/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/processor.h b/arch/sparc/include/asm/pr=
ocessor.h
index 34baa35..622cfa5 100644
--- a/arch/sparc/include/asm/processor.h
+++ b/arch/sparc/include/asm/processor.h
@@ -7,6 +7,8 @@
 #endif
=20
 #define nop() 		__asm__ __volatile__ ("nop")
+#ifndef __ASSEMBLY__
 extern void (*sparc_idle)(void);
+#endif
=20
 #endif
--=20
1.8.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__11_Feb_2013_18_34_09_+1100_fSZSOVNmThUvLVOt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRGJ7xAAoJEECxmPOUX5FEnLwP/04K30fHki/U5509xh0MtwVU
MMSdyrFsDrU3q+KIEQCbwjZb++jTL7B9p+siGvneG929VXzzsws9eRpoAXg6YJox
WNnYLAeuTEkIyfw+GmRbBY1ROOXJBEMNVs9Tnl5qhHxEt7IVmMDGjtV20JHgRfIY
CuVVfouVA1wf1WlwHwQudULtuna2lraq7DGjh1CXOkgYWmtZoifmfwQqHo63GSKF
IsWU+G8pqOhCxyyEIURHi/6yD/2rXMpHEOSxuXMFyjHFVXO5hBF94NVGEchRUTY5
puOWhKf6XfdwZpxvaSi3YUPpuXW+hBvyEFd0ovXhv63bMnAnUsBHWY69vp1yXol6
wb8z79Xxj4137f84gyaDgE/Xd+0NtyxFrX7k94hzf93WX5jl9PvwMrXtUhrt6Je5
Xtg3ZcYIQcwkFxVpvEaTpjCm6dbST7HzJug6N238QJn1emZwjepoefUzX0bamppX
qC+/e4zqirlR45i4E9rItTJWCAU4At8G5MfdhrK9FHC6DXtUkFHjCSyqWZ8H+CrC
co1ZjtF8YQ0ljIJx9yFDgol8JnaH29rH4JAERoNQjxmmP4bOG410W2VGA5HD0+9a
Z+MyIf8wERhF/72W0QZqqPORUxNnR4H0Lp1yboQOW1qMMEAqIKgF3JI+K8/ibBMn
QNY7htU6kVfiJuPdxge2
=J7fR
-----END PGP SIGNATURE-----

--Signature=_Mon__11_Feb_2013_18_34_09_+1100_fSZSOVNmThUvLVOt--

From: Jason Wever <weeve@gentoo.org>
Date: Tue, 06 Apr 2004 04:48:10 +0000
Subject: unresolved symbols in snd_page_alloc in 2.6.5
Message-Id: <20040405224810.6f444d3d@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__5_Apr_2004_22_48_10_-0600_D6pV4IwoKRPsaGBX"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature=_Mon__5_Apr_2004_22_48_10_-0600_D6pV4IwoKRPsaGBX
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__5_Apr_2004_22_48_10_-0600_1b99F=.THRobZ8FX"


--Multipart=_Mon__5_Apr_2004_22_48_10_-0600_1b99F=.THRobZ8FX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

In building 2.6.5 on an Ultra 2, I stumbled across a problem in the
snd_page_alloc module, and more specifically sound/core/memalloc.c.

When the kernel compiled, snd_page_alloc was returning two unresolved
symbols, pci_alloc_consistent and  pci_free_consistent.

I looked around the code a bit, trying to make some sense of it, and the
result is the attached patch.  It does compile and load without any
arguments, but whether it is the right way to fix this I'm not sure.
cs4231 doesn't seem to output any sound, but then again it didn't with
2.6.4 either, so that may be another issue (since it happens both with PCI
and SBUS based Ultras).  

This also applies to sparc32, and seems to work about the same there as
well.  amd7930 is in need of more work though.

-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Multipart=_Mon__5_Apr_2004_22_48_10_-0600_1b99F=.THRobZ8FX
Content-Type: text/x-patch;
 name="memalloc-sbus.patch"
Content-Disposition: attachment;
 filename="memalloc-sbus.patch"
Content-Transfer-Encoding: 7bit

--- sound/core/memalloc.c.orig	2004-04-04 21:54:24.000000000 -0600
+++ sound/core/memalloc.c	2004-04-05 22:34:26.834614000 -0600
@@ -94,8 +94,13 @@
 {
 	if (dev)
 		return dma_alloc_coherent(dev, size, dma_handle, flags);
+#ifdef CONFIG_SBUS
+	else /* crude sbus hack */ 
+		return sbus_alloc_consistent(NULL, size, dma_handle);
+#else
 	else /* FIXME: dma_alloc_coherent does't always accept dev=NULL */
 		return pci_alloc_consistent(NULL, size, dma_handle);
+#endif
 }
 
 static void snd_dma_free_coherent1(struct device *dev, size_t size, void *dma_addr,
@@ -103,8 +108,13 @@
 {
 	if (dev)
 		return dma_free_coherent(dev, size, dma_addr, dma_handle);
+#ifdef CONFIG_SBUS
+	else /* crude sbus hack */
+		return sbus_free_consistent(NULL, size,	dma_addr, dma_handle);
+#else
 	else
 		return pci_free_consistent(NULL, size, dma_addr, dma_handle);
+#endif
 }
 
 #undef dma_alloc_coherent

--Multipart=_Mon__5_Apr_2004_22_48_10_-0600_1b99F=.THRobZ8FX--

--Signature=_Mon__5_Apr_2004_22_48_10_-0600_D6pV4IwoKRPsaGBX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcjaNdKvgdVioq28RAvT/AJ4sMAQGO91ESwk71bnct0UaR995bACbBa4u
2ponIBAmKuUns+is9jc51mw=
=o7P6
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Apr_2004_22_48_10_-0600_D6pV4IwoKRPsaGBX--

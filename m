From: David Miller <davem@davemloft.net>
Date: Thu, 16 Aug 2012 03:17:38 +0000
Subject: Re: SILO fails to read silo.conf from EXT4 FS
Message-Id: <20120815.201738.1239404312150755618.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5015201A.8060309@gentoo.org>
In-Reply-To: <5015201A.8060309@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Ra=FAl Porcel <armin76@gentoo.org>
Date: Sun, 29 Jul 2012 13:35:54 +0200

> With the rewrite of the e2fs part of SILO, its unable to read
> /etc/silo.conf from an EXT4 FS. It can read from EXT2 and EXT3,
> though.

There are some minor errors in the extent leaf traversal, can you try
this patch below?

If this fails I'll give you a patch which adds some tracing so we can
diagnose this further.

Thanks!

diff --git a/second/fs/ext2.c b/second/fs/ext2.c
index 7eb665f..018aced 100644
--- a/second/fs/ext2.c
+++ b/second/fs/ext2.c
@@ -147,7 +147,7 @@ static struct ext4_extent_header *search_leaf(struct si=
lo_ext2_state *s,
 			return ehp;
=20
 		for (i =3D 0; i < ext2_to_cpu_16(ehp->eh_entries); i++, idxp++)
-			if (ext2_to_cpu_32(idxp->ei_block) > file_block)
+			if (file_block < ext2_to_cpu_32(idxp->ei_block))
 				break;
=20
 		if (i =3D 0)
@@ -226,14 +226,15 @@ static unsigned long long resolve_extent(struct silo_=
ext2_state *s,
 	ep =3D (struct ext4_extent *) (ehp + 1);
=20
 	for (i =3D 0; i < ext2_to_cpu_16(ehp->eh_entries); i++, ep++)
-		if (ext2_to_cpu_32(ep->ee_block) > file_block)
+		if (file_block < ext2_to_cpu_32(ep->ee_block))
 			break;
=20
 	if (i =3D 0)
 		return BLOCK_MAP_ERROR;
=20
+	ep -=3D 1;
 	file_block -=3D ext2_to_cpu_32(ep->ee_block);
-	if (ext2_to_cpu_16(ep->ee_len) < file_block)
+	if (file_block >=3D ext2_to_cpu_16(ep->ee_len))
 		return BLOCK_MAP_ERROR;
=20
 	hi =3D ((unsigned long long)ext2_to_cpu_16(ep->ee_start_hi)) << 32;

From: "Art Haas" <ahaas@airmail.net>
Date: Thu, 25 Mar 2004 17:03:12 +0000
Subject: [PATCH] Patch for arch/sparc/kernel/sys_sunos.c
Message-Id: <20040325170312.GA11895@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

Here's a small patch that fixes a GCC-3.5 compilation error with the
file. The new GCC doesn't accept the cast-on-lvalues. A essentially
identical patch was applied to fs/readdir.c to fix this problem - see
the 1.22->1.23 changes.

Art Haas

=== arch/sparc/kernel/sys_sunos.c 1.29 vs edited ==--- 1.29/arch/sparc/kernel/sys_sunos.c	Fri Mar  5 16:45:19 2004
+++ edited/arch/sparc/kernel/sys_sunos.c	Thu Mar 25 10:54:10 2004
@@ -343,7 +343,7 @@
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = (void *)dirent + reclen;
 	buf->curr = dirent;
 	buf->count -= reclen;
 	return 0;
@@ -422,7 +422,7 @@
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = (void *)dirent + reclen;
 	buf->curr = dirent;
 	buf->count -= reclen;
 	return 0;
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

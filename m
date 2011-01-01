From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 23:16:09 +0000
Subject: [PATCH v2 10/9] sparc: update copyright in piggyback.c
Message-Id: <20110101231608.GA17937@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Update copyright info in piggyback.c to include
info from piggyback_64.c.
Include my own copyright too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Josip Rodin <joy@entuzijast.net>
Cc: Jakub Jelinek <jakub@redhat.com>
---
diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
index 82926f4..2f9bf07 100644
--- a/arch/sparc/boot/piggyback.c
+++ b/arch/sparc/boot/piggyback.c
@@ -2,8 +2,9 @@
    Simple utility to make a single-image install kernel with initial ramdisk
    for Sparc tftpbooting without need to set up nfs.
 
-   Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+   Copyright (C) 1996,1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
    Pete Zaitcev <zaitcev@yahoo.com> endian fixes for cross-compiles, 2000.
+   Copyright (C) 2011 Sam Ravnborg <sam@ravnborg.org>
 
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by

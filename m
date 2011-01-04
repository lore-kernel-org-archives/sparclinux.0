From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 04 Jan 2011 21:39:19 +0000
Subject: [PATCH 10/10] sparc: update copyright in piggyback.c
Message-Id: <1294177159-15817-10-git-send-email-sam@ravnborg.org>
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
 arch/sparc/boot/piggyback.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
index d56e9de..c0a798f 100644
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
-- 
1.6.0.6


From: Robert Reif <reif@earthlink.net>
Date: Wed, 21 Mar 2007 11:26:56 +0000
Subject: [PATCH] add unsigned to unused bit field in a.out.h
Message-Id: <1174476415.22880.14.camel@dell>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add unsigned to unused bit field in a.out.h to make sparse happy.

diff --git a/include/asm-sparc/a.out.h b/include/asm-sparc/a.out.h
index e4e83eb..9090060 100644
--- a/include/asm-sparc/a.out.h
+++ b/include/asm-sparc/a.out.h
@@ -80,7 +80,7 @@ struct relocation_info /* used when header.a_machtype
= M_SPARC */
         unsigned long   r_address;  /* relocation addr */
         unsigned int    r_index:24; /* segment index or symbol index */
         unsigned int    r_extern:1; /* if F, r_index=SEG#; if T, SYM
idx */
-        int             r_pad:2;    /* <unused> */
+        unsigned int    r_pad:2;    /* <unused> */
         enum reloc_type r_type:5;   /* type of relocation to perform */
         long            r_addend;   /* addend for relocation value */
 };




From: Robert Reif <reif@earthlink.net>
Date: Wed, 28 Mar 2007 20:28:27 +0000
Subject: Re: [PATCH] add unsigned to unused bit field in a.out.h
Message-Id: <460ACFEB.2040602@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080606090203090805000805"
List-Id: <sparclinux.vger.kernel.org>
References: <1174476415.22880.14.camel@dell>
In-Reply-To: <1174476415.22880.14.camel@dell>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080606090203090805000805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Add unsigned to unused bit field in a.out.h to make sparse happy.

Signed-off-by: Robert Reif <reif@earthlink.net>




--------------080606090203090805000805
Content-Type: text/plain;
 name="a.out.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a.out.diff.txt"

diff --git a/include/asm-sparc/a.out.h b/include/asm-sparc/a.out.h
index e4e83eb..9090060 100644
--- a/include/asm-sparc/a.out.h
+++ b/include/asm-sparc/a.out.h
@@ -80,7 +80,7 @@ struct relocation_info /* used when header.a_machtype == M_SPARC */
         unsigned long   r_address;  /* relocation addr */
         unsigned int    r_index:24; /* segment index or symbol index */
         unsigned int    r_extern:1; /* if F, r_index==SEG#; if T, SYM idx */
-        int             r_pad:2;    /* <unused> */
+        unsigned int    r_pad:2;    /* <unused> */
         enum reloc_type r_type:5;   /* type of relocation to perform */
         long            r_addend;   /* addend for relocation value */
 };

--------------080606090203090805000805--


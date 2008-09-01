From: Robert Reif <reif@earthlink.net>
Date: Mon, 01 Sep 2008 15:58:04 +0000
Subject: Re: tty compile warnings
Message-Id: <48BC110C.1@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010801060105000600090702"
List-Id: <sparclinux.vger.kernel.org>
References: <48BBEDB2.3080207@earthlink.net>
In-Reply-To: <48BBEDB2.3080207@earthlink.net>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------010801060105000600090702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> You could try removing _x_cc[2] and changing [NCCS] to [NCCS+2] which
> might work depending upon the alignment you get.
>   
The following patch compiles without error but I'm a bit confused
about the sizes.  VMIN is 16 and VTIME is 17 so user NCCS should
be 16 and kernel NCCS 18 unless there are padding or some legacy
issues here. 17 + 2 + one for c_line = 20 bytes which makes sense for
padding but NCCS is used to copy the control characters which means
an unused control character is copied.

--------------010801060105000600090702
Content-Type: text/plain;
 name="tty.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tty.diff.txt"

diff --git a/arch/sparc/include/asm/termbits.h b/arch/sparc/include/asm/termbits.h
index d6ca3e2..c154288 100644
--- a/arch/sparc/include/asm/termbits.h
+++ b/arch/sparc/include/asm/termbits.h
@@ -29,10 +29,11 @@ struct termios {
 	tcflag_t c_cflag;		/* control mode flags */
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
+#ifndef __KERNEL__
 	cc_t c_cc[NCCS];		/* control characters */
-#ifdef __KERNEL__
+#else
+	cc_t c_cc[NCCS+2];	/* kernel needs 2 more to hold vmin/vtime */
 #define SIZEOF_USER_TERMIOS sizeof (struct termios) - (2*sizeof (cc_t))
-	cc_t _x_cc[2];                  /* We need them to hold vmin/vtime */
 #endif
 };
 
@@ -42,8 +43,7 @@ struct termios2 {
 	tcflag_t c_cflag;		/* control mode flags */
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	cc_t _x_cc[2];                  /* padding to match ktermios */
+	cc_t c_cc[NCCS+2];		/* control characters */
 	speed_t c_ispeed;		/* input speed */
 	speed_t c_ospeed;		/* output speed */
 };
@@ -54,8 +54,7 @@ struct ktermios {
 	tcflag_t c_cflag;		/* control mode flags */
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	cc_t _x_cc[2];                  /* We need them to hold vmin/vtime */
+	cc_t c_cc[NCCS+2];		/* control characters */
 	speed_t c_ispeed;		/* input speed */
 	speed_t c_ospeed;		/* output speed */
 };

--------------010801060105000600090702--

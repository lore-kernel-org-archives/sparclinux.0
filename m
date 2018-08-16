From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 16 Aug 2018 19:37:28 +0000
Subject: Re: why is NCCS equal to 17 on sparc?
Message-Id: <20180816193728.GA12701@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180816192004.GZ6515@ZenIV.linux.org.uk>
In-Reply-To: <20180816192004.GZ6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 16, 2018 at 08:20:04PM +0100, Al Viro wrote:
> 	AFAICS, on sparc we have termios->c_cc[] matching Solaris
> one.  Same entries, same order - from INTR in ->c_cc[0] to LNEXT
> in ->c_cc[15].  What the hell is (userland) ->c_cc[16] for?  The
> kernel uses ->c_cc[16] for MIN, ->c_cc[17] - for TIME and noting,
> AFAICS, uses ->c_cc[18].
> 	On the userland side, of course, MIN and TIME are
> non-canon occupants of what would've been EOF and EOL slots
> in canon mode...
> 
> 	Looks like the kernel-side array (NCCS+2) should've been
> 18-element and userland one (NCCS) - 16-element...
> 
> 	What am I missing here?

... and it has been that way since sparc has first grown termios
support (1.3.44) - it has
+#define NCCS 17
+struct termios {
+       tcflag_t c_iflag;               /* input mode flags */
+       tcflag_t c_oflag;               /* output mode flags */
+       tcflag_t c_cflag;               /* control mode flags */
+       tcflag_t c_lflag;               /* local mode flags */
+       cc_t c_line;                    /* line discipline */
+       cc_t c_cc[NCCS];                /* control characters */
+};
+
+/* c_cc characters */
+#define VINTR    0
+#define VQUIT    1
+#define VERASE   2
+#define VKILL    3
+#define VEOF     4
+#define VEOL     5
+#define VEOL2    6
+#define VSWTC    7
+#define VSTART   8
+#define VSTOP    9
+#define VSUSP    10
+#define VDSUSP   11  /* SunOS POSIX nicety I do believe... */
+#define VREPRINT 12
+#define VDISCARD 13
+#define VWERASE  14
+#define VLNEXT   15
+#define VMIN     VEOF
+#define VTIME    VEOL
in asm-sparc/termios.h.  Historical accident, unnoticed until too late
because we get padding after c_cc[] anyway (16 or 17, everything works
as if it was 19)?  Or is it something more subtle?

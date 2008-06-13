From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:57:19 +0000
Subject: [PATCH] sparc: Merge asm-sparc{,64}/termios.h
Message-Id: <1213387042-9711-18-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1213387042-9711-17-git-send-email-sam@ravnborg.org>
In-Reply-To: <1213387042-9711-17-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Bring the commit e55c57e0b51c68d78845549505057169c6c3cba6
("[SPARC64]: Report any user access faults in termios accessors")
over to sparc when unifying the two files.
The diff was manually inspected to contain no
other relevant changes.

This unification therefore changes functionality of sparc.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/termios.h   |   79 +++++++++--------
 include/asm-sparc64/termios.h |  187 +------------------------------------=
----
 2 files changed, 42 insertions(+), 224 deletions(-)

diff --git a/include/asm-sparc/termios.h b/include/asm-sparc/termios.h
index f7b4409..e8ba953 100644
--- a/include/asm-sparc/termios.h
+++ b/include/asm-sparc/termios.h
@@ -53,7 +53,6 @@ struct winsize {
 #define _VMIN	4
 #define _VTIME	5
=20
-
 /*	intr=3D^C		quit=3D^\		erase=DEl	kill=3D^U
 	eof=3D^D		eol=3D\0		eol2=3D\0		sxtc=3D\0
 	start=3D^Q	stop=3D^S		susp=3D^Z		dsusp=3D^Y
@@ -68,16 +67,17 @@ struct winsize {
 #define user_termio_to_kernel_termios(termios, termio) \
 ({ \
 	unsigned short tmp; \
-	get_user(tmp, &(termio)->c_iflag); \
+	int err; \
+	err =3D get_user(tmp, &(termio)->c_iflag); \
 	(termios)->c_iflag =3D (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-	get_user(tmp, &(termio)->c_oflag); \
+	err |=3D get_user(tmp, &(termio)->c_oflag); \
 	(termios)->c_oflag =3D (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-	get_user(tmp, &(termio)->c_cflag); \
+	err |=3D get_user(tmp, &(termio)->c_cflag); \
 	(termios)->c_cflag =3D (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-	get_user(tmp, &(termio)->c_lflag); \
+	err |=3D get_user(tmp, &(termio)->c_lflag); \
 	(termios)->c_lflag =3D (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-	0; \
+	err |=3D copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
+	err; \
 })
=20
 /*
@@ -87,17 +87,18 @@ struct winsize {
  */
 #define kernel_termios_to_user_termio(termio, termios) \
 ({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line,  &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
+	int err; \
+	err  =3D put_user((termios)->c_iflag, &(termio)->c_iflag); \
+	err |=3D put_user((termios)->c_oflag, &(termio)->c_oflag); \
+	err |=3D put_user((termios)->c_cflag, &(termio)->c_cflag); \
+	err |=3D put_user((termios)->c_lflag, &(termio)->c_lflag); \
+	err |=3D put_user((termios)->c_line,  &(termio)->c_line); \
+	err |=3D copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 	if (!((termios)->c_lflag & ICANON)) { \
-		put_user((termios)->c_cc[VMIN], &(termio)->c_cc[_VMIN]); \
-		put_user((termios)->c_cc[VTIME], &(termio)->c_cc[_VTIME]); \
+		err |=3D put_user((termios)->c_cc[VMIN], &(termio)->c_cc[_VMIN]); \
+		err |=3D put_user((termios)->c_cc[VTIME], &(termio)->c_cc[_VTIME]); \
 	} \
-	0; \
+	err; \
 })
=20
 #define user_termios_to_kernel_termios(k, u) \
@@ -144,38 +145,40 @@ struct winsize {
=20
 #define user_termios_to_kernel_termios_1(k, u) \
 ({ \
-	get_user((k)->c_iflag, &(u)->c_iflag); \
-	get_user((k)->c_oflag, &(u)->c_oflag); \
-	get_user((k)->c_cflag, &(u)->c_cflag); \
-	get_user((k)->c_lflag, &(u)->c_lflag); \
-	get_user((k)->c_line,  &(u)->c_line); \
-	copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
+	int err; \
+	err  =3D get_user((k)->c_iflag, &(u)->c_iflag); \
+	err |=3D get_user((k)->c_oflag, &(u)->c_oflag); \
+	err |=3D get_user((k)->c_cflag, &(u)->c_cflag); \
+	err |=3D get_user((k)->c_lflag, &(u)->c_lflag); \
+	err |=3D get_user((k)->c_line,  &(u)->c_line); \
+	err |=3D copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
 	if ((k)->c_lflag & ICANON) { \
-		get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
+		err |=3D get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
+		err |=3D get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
 	} else { \
-		get_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		get_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
+		err |=3D get_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
+		err |=3D get_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
 	} \
-	0; \
+	err; \
 })
=20
 #define kernel_termios_to_user_termios_1(u, k) \
 ({ \
-	put_user((k)->c_iflag, &(u)->c_iflag); \
-	put_user((k)->c_oflag, &(u)->c_oflag); \
-	put_user((k)->c_cflag, &(u)->c_cflag); \
-	put_user((k)->c_lflag, &(u)->c_lflag); \
-	put_user((k)->c_line, &(u)->c_line); \
-	copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
+	int err; \
+	err  =3D put_user((k)->c_iflag, &(u)->c_iflag); \
+	err |=3D put_user((k)->c_oflag, &(u)->c_oflag); \
+	err |=3D put_user((k)->c_cflag, &(u)->c_cflag); \
+	err |=3D put_user((k)->c_lflag, &(u)->c_lflag); \
+	err |=3D put_user((k)->c_line, &(u)->c_line); \
+	err |=3D copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
 	if (!((k)->c_lflag & ICANON)) { \
-		put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
+		err |=3D put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
+		err |=3D put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
 	} else { \
-		put_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		put_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
+		err |=3D put_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
+		err |=3D put_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
 	} \
-	0; \
+	err; \
 })
=20
 #endif	/* __KERNEL__ */
diff --git a/include/asm-sparc64/termios.h b/include/asm-sparc64/termios.h
index 1f5dab2..940495e 100644
--- a/include/asm-sparc64/termios.h
+++ b/include/asm-sparc64/termios.h
@@ -1,186 +1 @@
-#ifndef _SPARC64_TERMIOS_H
-#define _SPARC64_TERMIOS_H
-
-#include <asm/ioctls.h>
-#include <asm/termbits.h>
-
-#if defined(__KERNEL__) || defined(__DEFINE_BSD_TERMIOS)
-struct sgttyb {
-	char	sg_ispeed;
-	char	sg_ospeed;
-	char	sg_erase;
-	char	sg_kill;
-	short	sg_flags;
-};
-
-struct tchars {
-	char	t_intrc;
-	char	t_quitc;
-	char	t_startc;
-	char	t_stopc;
-	char	t_eofc;
-	char	t_brkc;
-};
-
-struct ltchars {
-	char	t_suspc;
-	char	t_dsuspc;
-	char	t_rprntc;
-	char	t_flushc;
-	char	t_werasc;
-	char	t_lnextc;
-};
-#endif /* __KERNEL__ */
-
-struct winsize {
-	unsigned short ws_row;
-	unsigned short ws_col;
-	unsigned short ws_xpixel;
-	unsigned short ws_ypixel;
-};
-
-#ifdef __KERNEL__
-#include <linux/module.h>
-
-/*
- * c_cc characters in the termio structure.  Oh, how I love being
- * backwardly compatible.  Notice that character 4 and 5 are
- * interpreted differently depending on whether ICANON is set in
- * c_lflag.  If it's set, they are used as _VEOF and _VEOL, otherwise
- * as _VMIN and V_TIME.  This is for compatibility with OSF/1 (which
- * is compatible with sysV)...
- */
-#define _VMIN	4
-#define _VTIME	5
-
-/*	intr=3D^C		quit=3D^\		erase=DEl	kill=3D^U
-	eof=3D^D		eol=3D\0		eol2=3D\0		sxtc=3D\0
-	start=3D^Q	stop=3D^S		susp=3D^Z		dsusp=3D^Y
-	reprint=3D^R	discard=3D^U	werase=3D^W	lnext=3D^V
-	vmin=3D\1         vtime=3D\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\02=
5\027\026\001"
-
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	unsigned short tmp; \
-	int err; \
-	err =3D get_user(tmp, &(termio)->c_iflag); \
-	(termios)->c_iflag =3D (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-	err |=3D get_user(tmp, &(termio)->c_oflag); \
-	(termios)->c_oflag =3D (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-	err |=3D get_user(tmp, &(termio)->c_cflag); \
-	(termios)->c_cflag =3D (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-	err |=3D get_user(tmp, &(termio)->c_lflag); \
-	(termios)->c_lflag =3D (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-	err |=3D copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-	err; \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- *
- * Note the "fun" _VMIN overloading.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	int err; \
-	err  =3D put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	err |=3D put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	err |=3D put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	err |=3D put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	err |=3D put_user((termios)->c_line,  &(termio)->c_line); \
-	err |=3D copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-	if (!((termios)->c_lflag & ICANON)) { \
-		err |=3D put_user((termios)->c_cc[VMIN], &(termio)->c_cc[_VMIN]); \
-		err |=3D put_user((termios)->c_cc[VTIME], &(termio)->c_cc[_VTIME]); \
-	} \
-	err; \
-})
-
-#define user_termios_to_kernel_termios(k, u) \
-({ \
-	int err; \
-	err  =3D get_user((k)->c_iflag, &(u)->c_iflag); \
-	err |=3D get_user((k)->c_oflag, &(u)->c_oflag); \
-	err |=3D get_user((k)->c_cflag, &(u)->c_cflag); \
-	err |=3D get_user((k)->c_lflag, &(u)->c_lflag); \
-	err |=3D get_user((k)->c_line,  &(u)->c_line); \
-	err |=3D copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
-	if((k)->c_lflag & ICANON) { \
-		err |=3D get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |=3D get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} else { \
-		err |=3D get_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |=3D get_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} \
-	err |=3D get_user((k)->c_ispeed,  &(u)->c_ispeed); \
-	err |=3D get_user((k)->c_ospeed,  &(u)->c_ospeed); \
-	err; \
-})
-
-#define kernel_termios_to_user_termios(u, k) \
-({ \
-	int err; \
-	err  =3D put_user((k)->c_iflag, &(u)->c_iflag); \
-	err |=3D put_user((k)->c_oflag, &(u)->c_oflag); \
-	err |=3D put_user((k)->c_cflag, &(u)->c_cflag); \
-	err |=3D put_user((k)->c_lflag, &(u)->c_lflag); \
-	err |=3D put_user((k)->c_line, &(u)->c_line); \
-	err |=3D copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
-	if(!((k)->c_lflag & ICANON)) { \
-		err |=3D put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |=3D put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} else { \
-		err |=3D put_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |=3D put_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} \
-	err |=3D put_user((k)->c_ispeed, &(u)->c_ispeed); \
-	err |=3D put_user((k)->c_ospeed, &(u)->c_ospeed); \
-	err; \
-})
-
-#define user_termios_to_kernel_termios_1(k, u) \
-({ \
-	int err; \
-	err  =3D get_user((k)->c_iflag, &(u)->c_iflag); \
-	err |=3D get_user((k)->c_oflag, &(u)->c_oflag); \
-	err |=3D get_user((k)->c_cflag, &(u)->c_cflag); \
-	err |=3D get_user((k)->c_lflag, &(u)->c_lflag); \
-	err |=3D get_user((k)->c_line,  &(u)->c_line); \
-	err |=3D copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
-	if((k)->c_lflag & ICANON) { \
-		err |=3D get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |=3D get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} else { \
-		err |=3D get_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |=3D get_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} \
-	err; \
-})
-
-#define kernel_termios_to_user_termios_1(u, k) \
-({ \
-	int err; \
-	err  =3D put_user((k)->c_iflag, &(u)->c_iflag); \
-	err |=3D put_user((k)->c_oflag, &(u)->c_oflag); \
-	err |=3D put_user((k)->c_cflag, &(u)->c_cflag); \
-	err |=3D put_user((k)->c_lflag, &(u)->c_lflag); \
-	err |=3D put_user((k)->c_line, &(u)->c_line); \
-	err |=3D copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
-	if(!((k)->c_lflag & ICANON)) { \
-		err |=3D put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |=3D put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} else { \
-		err |=3D put_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |=3D put_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} \
-	err; \
-})
-
-#endif	/* __KERNEL__ */
-
-#endif /* _SPARC64_TERMIOS_H */
+#include <asm-sparc/termios.h>
--=20
1.5.4.1.143.ge7e51


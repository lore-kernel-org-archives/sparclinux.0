From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 03 Dec 2012 13:10:23 +0000
Subject: Re: SPARC kernel build (piggyback) fails with binutils 2.23.1
Message-Id: <20121203131023.GC9150@blackmetal.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20121202165004.GA3091@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20121202165004.GA3091@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Mon, Dec 03, 2012 at 09:22:30AM +1100, Julian Calaby wrote:
> On Mon, Dec 3, 2012 at 3:50 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Kernel (3.7-rc7) build is failing with binutils 2.23.1, because _end is
> > no longer absolute for some reason and piggyback can't find it:
> >
> >         $ tail -3 System.map
> >         000000000086bcb8 b net_header
> >         000000000086bcc0 B __bss_stop
> >         000000000086bcc0 B _end
> >
> >         [...]
> >
> >           kernel: arch/sparc/boot/image is ready
> >           HOSTCC  arch/sparc/boot/piggyback
> >           ELFTOAOUT arch/sparc/boot/tftpboot.img
> >         PT 0 Entry: Loadable to 0x400000[0x46bcc0] from 0x0[0x40ed60] align 0x100000
> >         PT 1 Entry: Note
> >         PT 2 Entry: unknown
> >           PIGGY   arch/sparc/boot/tftpboot.img
> >         Could not determine start and end from System.map
> >         make[6]: *** [arch/sparc/boot/tftpboot.img] Error 1
> >
> > Is this a bug in binutils, or is the check in piggyback too strict?
> 
> Given that the addresses below are the same as the addresses above,
> I'm suspecting that the test is too strict.
> 
> I assume that you have a sparc64 system you can reliably boot with
> TFTP, could you try changing the code in the "end_line" function (line
> 91) to look for 'B' symbols and check that it still boots correctly?

Yes, I tried the hack below, and it produces a bootable TFTP image.

diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
index c0a798f..9eb1264 100644
--- a/arch/sparc/boot/piggyback.c
+++ b/arch/sparc/boot/piggyback.c
@@ -90,9 +90,9 @@ static int start_line(const char *line)
 
 static int end_line(const char *line)
 {
-	if (strcmp(line + 8, " A _end\n") = 0)
+	if (strcmp(line + 10, " _end\n") = 0)
 		return 1;
-	else if (strcmp (line + 16, " A _end\n") = 0)
+	else if (strcmp (line + 18, " _end\n") = 0)
 		return 1;
 	return 0;
 }

A.

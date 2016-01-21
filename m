From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 21 Jan 2016 00:11:21 +0000
Subject: Re: Minor tweak to silo regarding GPT labeled drives
Message-Id: <20160121001120.GA2784@yogzotot>
List-Id: <sparclinux.vger.kernel.org>
References: <569D2C3E.5060608@oracle.com>
In-Reply-To: <569D2C3E.5060608@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 20, 2016 at 07:29:55PM +0100, Sam Ravnborg wrote:
> On Wed, Jan 20, 2016 at 05:40:14PM +0000, Bryce wrote:
> > On 20/01/16 17:29, Sam Ravnborg wrote:
> > > On Mon, Jan 18, 2016 at 06:17:34PM +0000, Bryce wrote:
> > >> I've been prompted by a couple of folk to pass along this minor patch for silo
> > >> Newer sparc firmware, mostly in the T4 and above range, along with sun(vtoc) now
> > >> support gpt labelled drives on the system boot drive (and theoretically some can
> > >> also support msdos? not tried it)
> > >>
> > >> The problem with sillo is that it actively looks to see if a sun label magic is
> > >> written but GPT has no such 'magic' and silo would moan.
> > >>
> > >> Phil
> > >> =--> > >>
> > >>
> > >> >From 5d5994b88513f2e45701460d275a2d29ab89c40b Mon Sep 17 00:00:00 2001
> > >> From: Dazed and confused <clueless@somewhere.com>
> > > Can the original author be found and attributed?
> > >
> > > I recall davem would like silo patches to be signed off, like kernel patches.
> > >
> > > 	Sam
> > The original author is myself, that is the raw patch from the internal svn repo.
> Great.
> 
> Then I suggest to await feedback from Anatoly and then please re-submit 
> like a proper patch with a proper changelog including signed-off-by,
> and Tested-by.
> And with a real name in the From part- so git picks up the real name.


My quick report.

Used silo git from https://kernel.googlesource.com/pub/scm/linux/kernel/git/davem/silo

I wasn't able to compile git silo on debian sparc64 (full 64-bit,
kernel+userland), and used debian 7.9 (32-bit userland) instead.

I have 2 test machines: bare-metal v215 (no gpt disks, 2 disks with sun
partition table) with debian 7.9 installed and T5-2 with solaris 11 control
domain and few LDOMs (Oracle Linux on Sparc, debian sid 64-bit, solaris)

So, I used v215 to compile silo git, installed and tried to boot - silo
timeout doesn't work, other than that Linux boots - seems like git silo has
broken timeout.

Next, compiled with gpt-patch, and applied another patch from oracle linux on
sparc silo.src.rpm package
(http://yum.oracle.com/repo/linux_sparc64/latest//silo-1.4.14-4.0.18.el6.src.rpm),
called silo-1.4.14-timer-timeout.patch

Compiled, installed - timeout settings in silo.conf works, linux boots.

Copied compiled silo directory to another debian 64-bit LDOM (where I have
debian sid sparc 64-bit installed to gpt disk partition), made "make install"
and run "silo -f", it complained, that there's no such file, cause don't have
32-bit C library, so I've installed 32-bit libc6-sparc, run "silo -f" again
succesfully.

So far works, linux boots, silo timeout works, no fatal error with "Wrong
disklabel magic".

PS: oracle linux on sparc silo.src.rpm has a few more patches, one of them is
to make silo to compile as 64-bit.

Tested-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Bryce <philip.copeland@oracle.com>

--

 include/silo.h  |    1 +
 second/fs/iom.c |    4 ++--
 second/timer.c  |    4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/silo.h b/include/silo.h
index 94d6e31..135b79e 100644
--- a/include/silo.h
+++ b/include/silo.h
@@ -46,6 +46,7 @@ typedef struct {
 } sun_partition;
 
 #define SUN_LABEL_MAGIC          0xDABE
+#define GPT_LABEL_MAGIC          0x0000
 
 struct silo_inode {
     unsigned int inolen;
diff --git a/second/fs/iom.c b/second/fs/iom.c
index 28dd4b2..c25e41c 100644
--- a/second/fs/iom.c
+++ b/second/fs/iom.c
@@ -37,8 +37,8 @@ static int read_sun_partition (int partno)
         silo_fatal("Cannot read partition");
         return 0;
     }
-    if (sdl.magic != SUN_LABEL_MAGIC)
-        silo_fatal("Wrong disklabel magic");
+    if ((sdl.magic != SUN_LABEL_MAGIC) && (sdl.magic != GPT_LABEL_MAGIC))
+        printf("Wrong disklabel magic [0x%X]\n", (unsigned int) sdl.magic);
     for (csum = 0, ush = ((unsigned short *) ((&sdl) + 1)) - 1; ush >= (unsigned short *) &sdl;)
         csum ^= *ush--;
     if (csum)
diff --git a/second/timer.c b/second/timer.c
index 7f03996..b559f93 100644
--- a/second/timer.c
+++ b/second/timer.c
@@ -145,7 +145,7 @@ static inline int sun4u_init_timer ()
            prom_getstring(node, "device_type", node_str, sizeof(node_str));
             if (!strcmp(node_str, "cpu")) {
                 foundcpu = 1;
-                clock_frequency = prom_getintdefault(node, "clock-frequency", 0) / 100;
+                clock_frequency = (unsigned int) prom_getintdefault(node, "clock-frequency", 0) / 100;
             }
         }
         if (notimer) {
@@ -155,7 +155,7 @@ static inline int sun4u_init_timer ()
         }
     }
     if (!foundcpu || !clock_frequency)
-        clock_frequency = prom_getint(prom_root_node, "clock-frequency") / 100;
+        clock_frequency = (unsigned int) prom_getint(prom_root_node, "clock-frequency") / 100;
     if (notimer && !sun4v_cpu) {
         sun4u_notimer = 1;
         __asm__ __volatile__ ("\t"

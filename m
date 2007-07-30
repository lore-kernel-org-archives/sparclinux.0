From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 30 Jul 2007 11:05:09 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <646765f40707300405h54f1b5a1y93acf63319e813a4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 7/30/07, David Miller <davem@davemloft.net> wrote:
> From: "Julian Calaby" <julian.calaby@gmail.com>
> Date: Mon, 30 Jul 2007 10:09:33 +1000
>
> > Stupid question, but: Why is it possible to select it to compile as a
> > module when it cannot?
>
> There isn't an easy way to describe this in the Kconfig language
> at this time.

Forgive my utter ignorance, but surely setting it to be a bool would
be sufficient until the underlying problem can be fixed.

Possibly something like the following patch: (make menuconfig tested only)

(note that this is not a serious patch, yet, and probably has it's
tabs and line endings messed up due to being pasted into gMail)

==

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index a4a3119..3289ca0 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -11,7 +11,7 @@ if BLK_DEV

 config BLK_DEV_FD
        tristate "Normal floppy disk support"
-       depends on ARCH_MAY_HAVE_PC_FDC
+       depends on ARCH_MAY_HAVE_PC_FDC && !SPARC
        ---help---
          If you want to use the floppy disk drive(s) of your PC under Linux,
          say Y. Information about this driver, especially important for IBM
@@ -23,6 +23,16 @@ config BLK_DEV_FD
          To compile this driver as a module, choose M here: the
          module will be called floppy.

+config BLK_DEV_FD_SPARC
+       bool "Normal floppy disk support"
+       depends on ARCH_MAY_HAVE_PC_FDC && SPARC
+       ---help---
+         If you want to use the floppy disk drive(s) of your Sparc board under
+         Linux, say Y. Information about this driver is contained in
+         <file:Documentation/floppy.txt>. That file also contains the location
+         of the Floppy driver FAQ as well as location of the fdutils package
+         used to configure additional parameters of the driver at run time.
+
 config AMIGA_FLOPPY
        tristate "Amiga floppy support"
        depends on AMIGA
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 014e721..8a9cf99 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -7,6 +7,7 @@

 obj-$(CONFIG_MAC_FLOPPY)       += swim3.o
 obj-$(CONFIG_BLK_DEV_FD)       += floppy.o
+obj-$(CONFIG_BLK_DEV_FD_SPARC) += floppy.o
 obj-$(CONFIG_AMIGA_FLOPPY)     += amiflop.o
 obj-$(CONFIG_PS3_DISK)         += ps3disk.o
 obj-$(CONFIG_ATARI_FLOPPY)     += ataflop.o

==

I understand though if this is an utterly stupid idea, and that this
is completely and totally against all forms of policy that I've not
read yet.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com

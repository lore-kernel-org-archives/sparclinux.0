From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jun 2006 02:07:52 +0000
Subject: [SILO PATCH]: Fix CDROM booting on sparc64
Message-Id: <20060618.190752.125899833.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is a fix (finally!) for the infamous CDROM boot failures a lot of
folks reported.  A good log of the situation exists in Debian bug
#261824

It's seen mostly on SunBlade1000, V280R, and V240 systems.  But other
kinds of boxes can see it too.

SILO crashes trying to open the CDROM device, it dies deep in the OBP
code for openning the device.  You can see this clearly with "ftrace"
at the "ok" prompt which gives a forth backtrace any time an error
occurs during OBP execution.

I tinkered around a little bit and it's easy to trigger the "Fast Data
Access MMU Miss" error by hand at the OBP prompt by simply going (this
example is on my SB1000):

ok " /pci@8,700000/scsi@6/disk@6,0:f" open-dev
ok " /pci@8,700000/scsi@6/disk@6,0:f" open-dev
Fast Data Access MMU Miss

(that /pci@... path can be determined by asking for the cdrom device
 alias, using "devalias cdrom" or similar)

Ie. try to open the cdrom device twice causes the crash.  This
actually works on most systems!  And that's why the failure doesn't
occur everywhere.

But why in the world would that be happening during a CDROM boot?

When OBP loads up the first stage boot block of SILO, it opens the
CDROM, reads the boot block, and then closes the CDROM device before
executing the bootblock.  This makes sense and that's why we get to
the first stage loader just fine and the first stage loader can open
the CDROM.  Changing the above test case shows that this is how you're
supposed to do things:

ok showstack
ok " /pci@8,700000/scsi@6/disk@6,0:f" open-dev
fff141014 ok fff141014 close-dev
ok " /pci@8,700000/scsi@6/disk@6,0:f" open-dev
fff141014 ok

('showstack' prints the contents of the forth stack, this way we can
 see the file-descriptor return value from open-dev which we need to
 pass into close-dev, another way is to say '.' which prints out the
 top of stack and also pops it off, we could have also just said
 'close-dev' all by itself since the file descriptor was on the forth
 stack already)

So, close it before you open it again, and everything is fine.

I went and studied the first stage boot code of SILO and it looked OK.
It's written in assembly and it closes the device node just fine.  But
then I remembered we use a different piece of code for the first stage
boot block on CDROM devices, it's written in C, and indeed it forgets
to close the device.  So when the second stage bootloader tries to
open the CDROM we go splat.

The SILO fix is obvious, and is included below.

BTW, a good source of information on all of the OBP forth mumbo-jumbo
can be found in the OpenBoot Command Reference Manual(s):

	http://docs.sun.com/app/docs/doc/801-7042
	http://docs.sun.com/app/docs/doc/805-4434
	http://docs.sun.com/app/docs/doc/805-4436
	http://docs.sun.com/app/docs/doc/806-1379-10

Enjoy :)

--- first-isofs/isofs.c.~1~	2006-06-18 19:05:53.000000000 -0700
+++ first-isofs/isofs.c	2006-06-18 19:06:08.000000000 -0700
@@ -101,6 +101,23 @@
 	return 0;
 }
 
+static void cd_fini(void)
+{
+	switch (prom_vers) {
+	case PROM_V0:
+		romvec->pv_v0devops.v0_devclose(fd);
+		break;
+
+	case PROM_V2:
+	case PROM_V3:
+		romvec->pv_v2devops.v2_dev_close(fd);
+		break;
+
+	case PROM_P1275:
+		p1275_cmd("close", 1, fd);
+		break;
+	};
+}
 
 static int cd_read_block(unsigned long long offset, int size, void *data)
 {
@@ -445,6 +462,8 @@
 	sinfo->conf_part = 1;
 	strcpy(sinfo->conf_file, silo_conf);
 
+	cd_fini();
+
 	prom_putchar(sinfo->id);
 
 	return dest;

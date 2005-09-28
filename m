From: Metalhead <metalhead@metalhead.ws>
Date: Wed, 28 Sep 2005 14:28:41 +0000
Subject: Re: [sparc32] Kernel module to control front LED
Message-Id: <20050928162729.791340cc@huginn.midgard.yggdrasill>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Wed__28_Sep_2005_16_27_29_+0100_znWuawvJzV0g=h/J"
List-Id: <sparclinux.vger.kernel.org>
References: <20050826192113.02c642a4@huginn.midgard.yggdrasill>
In-Reply-To: <20050826192113.02c642a4@huginn.midgard.yggdrasill>
To: sparclinux@vger.kernel.org

--Signature_Wed__28_Sep_2005_16_27_29_+0100_znWuawvJzV0g=h/J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

 I've changed the patch to use simple_strtoul() and included a signed-off-by
line, thanks for the tip. Although this change was small, please be aware t=
hat I
didn't test this version, as I unfortunately don't have access to a sparcst=
ation
right now.

Thanks.

Lars

diff -uprN linux-2.4.30-vanilla/Documentation/Configure.help linux-2.4.30-m=
od/Documentation/Configure.help
--- linux-2.4.30-vanilla/Documentation/Configure.help	2005-04-04 01:42:19.0=
00000000 +0000
+++ linux-2.4.30-mod/Documentation/Configure.help	2005-08-25 20:32:22.00000=
0000 +0000
@@ -23069,6 +23083,17 @@ CONFIG_SUN_OPENPROMFS
   <file:Documentation/modules.txt>.
   The module will be called openpromfs.o.  If unsure, say M.
=20
+Control front LED on sun4m machines via /proc/led (EXPERIMENTAL)
+CONFIG_SUN_LED
+  This allows you to control the front LED on sun4m machines via /proc/led=
. The
+  state of the LED can also be queried.
+
+  On, off and toggle do what their names suggest, an integer number makes =
the
+  LED blink at this interval seconds, load makes it blink according to the
+  system load (not available when compiled as a module).
+
+  If unsure, say N.
+
 Kernel support for Linux/Sparc 32bit binary compatibility
 CONFIG_SPARC32_COMPAT
   This allows you to run 32-bit binaries on your Ultra.
diff -uprN linux-2.4.30-vanilla/arch/sparc/config.in linux-2.4.30-mod/arch/=
sparc/config.in
--- linux-2.4.30-vanilla/arch/sparc/config.in	2004-11-17 11:54:21.000000000=
 +0000
+++ linux-2.4.30-mod/arch/sparc/config.in	2005-08-25 20:32:38.000000000 +00=
00
@@ -64,6 +64,10 @@ else
    define_bool CONFIG_PCI n
 fi
=20
+if [ "$CONFIG_PROC_FS" =3D "y" ]; then
+   tristate 'Control front LED on sun4m machines via /proc/led (EXPERIMENT=
AL)' CONFIG_SUN_LED
+fi
+
 tristate 'Openprom tree appears in /proc/openprom' CONFIG_SUN_OPENPROMFS
 bool 'Networking support' CONFIG_NET
 bool 'System V IPC' CONFIG_SYSVIPC
diff -uprN linux-2.4.30-vanilla/arch/sparc/kernel/Makefile linux-2.4.30-mod=
/arch/sparc/kernel/Makefile
--- linux-2.4.30-vanilla/arch/sparc/kernel/Makefile	2003-11-28 18:26:19.000=
000000 +0000
+++ linux-2.4.30-mod/arch/sparc/kernel/Makefile	2005-08-25 20:32:59.0000000=
00 +0000
@@ -33,6 +33,7 @@ obj-$(CONFIG_SMP) +=3D trampoline.o smp.o=20
 obj-$(CONFIG_SUN_AUXIO) +=3D auxio.o
 obj-$(CONFIG_PCI) +=3D ebus.o
 obj-$(CONFIG_SUN_PM) +=3D apc.o pmc.o
+obj-$(CONFIG_SUN_LED) +=3D led.o
=20
 ifdef CONFIG_SUNOS_EMUL
 obj-y +=3D sys_sunos.o sunos_ioctl.o
diff -uprN linux-2.4.30-vanilla/arch/sparc/kernel/led.c linux-2.4.30-mod/ar=
ch/sparc/kernel/led.c
--- linux-2.4.30-vanilla/arch/sparc/kernel/led.c	1970-01-01 00:00:00.000000=
000 +0000
+++ linux-2.4.30-mod/arch/sparc/kernel/led.c	2005-08-25 20:32:03.000000000 =
+0000
@@ -0,0 +1,170 @@
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <asm/auxio.h>
+#include <asm/uaccess.h>
+
+#define MODULE_VERSION "0.1"
+#define MODULE_NAME "led"
+
+MODULE_AUTHOR("Lars Kotthoff <metalhead@metalhead.ws>");
+MODULE_DESCRIPTION("Provides control of the front LED on SPARC systems.");
+MODULE_LICENSE("GPL");
+
+EXPORT_NO_SYMBOLS;
+
+#define LED_MAX_LENGTH 8 /* maximum chars written to proc file */
+
+struct proc_dir_entry *led;
+struct timer_list led_blink_timer;
+
+inline void print_debug(const char *msg)
+{
+	printk(KERN_DEBUG "[%s] %s\n", MODULE_NAME, msg);
+}
+
+inline void led_toggle(void)
+{
+	/* set_auxio takes 2 arguments, first the bits to enable, second the
+	 * bits to disable (huh?) */
+	set_auxio(get_auxio() ^ AUXIO_LED, get_auxio() & AUXIO_LED);
+}
+
+void led_blink(unsigned long timeout)
+{
+	led_toggle();
+
+	/* reschedule */
+#ifndef CONFIG_SUN_LED_MODULE
+	if(!timeout) { /* blink according to load */
+		led_blink_timer.expires =3D jiffies +
+			((1 + (avenrun[0] >> FSHIFT)) * HZ);
+		/* avenrun isn't exported by the kernel, hence the ifndefs */
+		led_blink_timer.data =3D 0;
+	} else { /* blink at user specified interval */
+#endif
+		led_blink_timer.expires =3D jiffies + (timeout * HZ);
+		led_blink_timer.data =3D timeout;
+#ifndef CONFIG_SUN_LED_MODULE
+	}
+#endif
+	add_timer(&led_blink_timer);
+}
+
+int led_read_proc(char *buf, char **start, off_t offset, int count,
+		int *eof, void *data)
+{
+	int len =3D 0;
+
+	MOD_INC_USE_COUNT;
+
+	if(get_auxio() & AUXIO_LED) {
+		len =3D sprintf(buf, "on\n");
+	} else {
+		len =3D sprintf(buf, "off\n");
+	}
+
+	MOD_DEC_USE_COUNT;
+
+	return len;
+}
+
+int led_write_proc(struct file *file, const char *buffer,
+		unsigned long count, void *data)
+{
+	char *buf =3D NULL;
+	unsigned long l =3D 0;
+
+	if(count > LED_MAX_LENGTH) {
+		count =3D LED_MAX_LENGTH;
+	}
+
+	buf =3D kmalloc(sizeof(char) * (count + 1), GFP_KERNEL);
+	if(!buf) {
+		return -ENOMEM;
+	}
+
+	MOD_INC_USE_COUNT;
+
+	if(copy_from_user(buf, buffer, count)) {
+		MOD_DEC_USE_COUNT;
+		kfree(buf);
+		return -EFAULT;
+	}
+	buf[count] =3D '\0';
+
+	/* work around \n when echo'ing into proc */
+	if(buf[count - 1] =3D=3D '\n') {
+		buf[count - 1] =3D '\0';
+	}
+
+	/* before we change anything we want to stop any running timers,
+	 * otherwise calls such as on will have no persistent effect */
+	if(timer_pending(&led_blink_timer)) {
+		del_timer_sync(&led_blink_timer);
+	}
+
+	if(!strcmp(buf, "on")) {
+		print_debug("Turning LED on...");
+		auxio_set_led(AUXIO_LED_ON);
+	} else if(!strcmp(buf, "toggle")) {
+		print_debug("Toggling LED...");
+		led_toggle();
+	} else if((*buf > '0') && (*buf <=3D '9')) { /* 0 would cause division by
+						      zero */
+		print_debug("Starting to blink...");
+		led_blink(simple_strtoul(buf, NULL, 10));
+#ifndef CONFIG_SUN_LED_MODULE
+	} else if(!strcmp(buf, "load")) {
+		print_debug("Starting to display load...");
+		led_blink(0);
+#endif
+	} else {
+		print_debug("Turning LED off...");
+		auxio_set_led(AUXIO_LED_OFF);
+	}
+
+	MOD_DEC_USE_COUNT;
+	kfree(buf);
+
+	return count;
+}
+
+static int __init init_led(void)
+{
+	led =3D create_proc_entry(MODULE_NAME,
+			0, /* default mode */
+			NULL /* parent dir */);
+	if(!led) {
+		return -ENOMEM;
+	}
+
+	led->read_proc =3D led_read_proc; /* reader function */
+	led->write_proc =3D led_write_proc; /* writer function */
+	led->owner =3D THIS_MODULE;
+
+	/* initialize timer for blinking */
+	init_timer(&led_blink_timer);
+	led_blink_timer.function =3D led_blink; /* blinking function */
+
+	printk(KERN_INFO
+		"%s version %s, Lars Kotthoff <metalhead@metalhead.ws>\n",
+		MODULE_NAME, MODULE_VERSION);
+
+	return 0;
+}
+
+static void __exit cleanup_led(void)
+{
+	remove_proc_entry(MODULE_NAME, NULL);
+	if(timer_pending(&led_blink_timer)) { /* kill timer if necessary */
+		del_timer_sync(&led_blink_timer);
+	}
+}
+
+module_init(init_led);
+module_exit(cleanup_led);
Signed-off-by: Lars Kotthoff

--=20
Horses trust their riders, even when not so deserved.

--Signature_Wed__28_Sep_2005_16_27_29_+0100_znWuawvJzV0g=h/J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQFDOrZoBxI10Jc2zuIRApIkAJ49MO4B9tRlJTSTiSd3KRUyt9riSwCdF/Sc
cvHI3o26oqr57jNjjpJ0QOM=
=MSVA
-----END PGP SIGNATURE-----

--Signature_Wed__28_Sep_2005_16_27_29_+0100_znWuawvJzV0g=h/J--

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 19 May 2007 17:01:23 +0000
Subject: [PATCH] removes mismatch section warnigs in sparc time.c file
Message-Id: <4650813D.8020105@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070209030500070100070808"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070209030500070100070808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes mismatch section warnings in the sparc/kernel/time.c 
file.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
The patch diff-ed agains 2.6.22-rc2


--------------070209030500070100070808
Content-Type: text/plain;
 name="time-init-warnings.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="time-init-warnings.diff"

diff -urp linux-2.6.21/arch/sparc/kernel/time.c linux-2.6.21.new/arch/sparc/kernel/time.c
--- linux-2.6.21/arch/sparc/kernel/time.c	2007-05-20 18:44:32.341445642 +0200
+++ linux-2.6.21.new/arch/sparc/kernel/time.c	2007-05-20 19:04:42.722421323 +0200
@@ -148,7 +148,7 @@ irqreturn_t timer_interrupt(int irq, voi
 }
 
 /* Kick start a stopped clock (procedure from the Sun NVRAM/hostid FAQ). */
-static void __init kick_start_clock(void)
+static void __devinit kick_start_clock(void)
 {
 	struct mostek48t02 *regs = (struct mostek48t02 *)mstk48t02_regs;
 	unsigned char sec;
@@ -223,7 +223,7 @@ static __inline__ int has_low_battery(vo
 	return (data1 == data2);	/* Was the write blocked? */
 }
 
-static void __init mostek_set_system_time(void)
+static void __devinit mostek_set_system_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	struct mostek48t02 *mregs;

--------------070209030500070100070808--

From: David Miller <davem@davemloft.net>
Date: Wed, 25 Jul 2007 23:50:40 +0000
Subject: Re: [PATCH] Add 82077 FDC to sun4c
Message-Id: <20070725.165040.18280809.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251659420.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251659420.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 25 Jul 2007 17:18:09 +0100 (BST)

> The attached patch adds in code to support an 82077 FDC on sun4c
> systems.  There is a problem with spurious interrupts but it does
> apear to work (very slowly).  Testing on my SS2 (82072A FDC) shows
> that the floppy driver is not 100% with sun4c any way (any spurious
> interrupt kills it, requiring a reboot to recover). The disk drive
> may have a somthing to do with the failure as it has not been
> used/cleaned for some time.

So basically it's a 82077 with the AUXIO based DOR register
writes and DIR register reads.

I also looked at the openbsd sparc floppy driver and their
basic scheme is to begin unconditionally assuming 82077,
and they make this test:

	type = 82077;
	val = 82077_DOR;
	if (val = 0x80) {
		82077_DOR = 0x02;
		val = 82077_DOR:
		if (val = 0x80)
			type = 82072;
	}

So that test plus making the DOR/DIR register access a sun4c vs.
sun4m thing gives us the much simpler patch below, can you test this
out on your SS2?

Thanks!

diff --git a/include/asm-sparc/floppy.h b/include/asm-sparc/floppy.h
index 9073c84..c556edf 100644
--- a/include/asm-sparc/floppy.h
+++ b/include/asm-sparc/floppy.h
@@ -101,6 +101,28 @@ static struct sun_floppy_ops sun_fdops;
 #define CROSS_64KB(a,s) (0)
 
 /* Routines unique to each controller type on a Sun. */
+static void sun_set_dor(unsigned char value)
+{
+	if (sparc_cpu_model = sun4c) {
+		unsigned int bits = 0;
+		if (value & 0x10)
+			bits |= AUXIO_FLPY_DSEL;
+		if ((value & 0x80) = 0)
+			bits |= AUXIO_FLPY_EJCT;
+		set_auxio(bits, (~bits) & (AUXIO_FLPY_DSEL|AUXIO_FLPY_EJCT));
+	} else {
+		sun_fdc->dor_82077 = value;
+	}
+}
+
+static unsigned char sun_read_dir(void)
+{
+	if (sparc_cpu_model = sun4c)
+		return (get_auxio() & AUXIO_FLPY_DCHG) ? 0x80 : 0;
+	else
+		return sun_fdc->dir_82077;
+}
+
 static unsigned char sun_82072_fd_inb(int port)
 {
 	udelay(5);
@@ -113,7 +135,7 @@ static unsigned char sun_82072_fd_inb(int port)
 	case 5: /* FD_DATA */
 		return sun_fdc->data_82072;
 	case 7: /* FD_DIR */
-		return (get_auxio() & AUXIO_FLPY_DCHG)? 0x80: 0;
+		return sun_read_dir();
 	};
 	panic("sun_82072_fd_inb: How did I get here?");
 }
@@ -126,20 +148,7 @@ static void sun_82072_fd_outb(unsigned char value, int port)
 		printk("floppy: Asked to write to unknown port %d\n", port);
 		panic("floppy: Port bolixed.");
 	case 2: /* FD_DOR */
-		/* Oh geese, 82072 on the Sun has no DOR register,
-		 * the functionality is implemented via the AUXIO
-		 * I/O register.  So we must emulate the behavior.
-		 *
-		 * ASSUMPTIONS:  There will only ever be one floppy
-		 *               drive attached to a Sun controller
-		 *               and it will be at drive zero.
-		 */
-		{
-			unsigned bits = 0;
-			if (value & 0x10) bits |= AUXIO_FLPY_DSEL;
-			if ((value & 0x80) = 0) bits |= AUXIO_FLPY_EJCT;
-			set_auxio(bits, (~bits) & (AUXIO_FLPY_DSEL|AUXIO_FLPY_EJCT));
-		}
+		sun_set_dor(value);
 		break;
 	case 5: /* FD_DATA */
 		sun_fdc->data_82072 = value;
@@ -166,10 +175,9 @@ static unsigned char sun_82077_fd_inb(int port)
 	case 5: /* FD_DATA */
 		return sun_fdc->data_82077;
 	case 7: /* FD_DIR */
-		/* XXX: Is DCL on 0x80 in sun4m? */
-		return sun_fdc->dir_82077;
+		return sun_read_dir();
 	};
-	panic("sun_82072_fd_inb: How did I get here?");
+	panic("sun_82077_fd_inb: How did I get here?");
 }
 
 static void sun_82077_fd_outb(unsigned char value, int port)
@@ -180,8 +188,7 @@ static void sun_82077_fd_outb(unsigned char value, int port)
 		printk("floppy: Asked to write to unknown port %d\n", port);
 		panic("floppy: Port bolixed.");
 	case 2: /* FD_DOR */
-		/* Happily, the 82077 has a real DOR register. */
-		sun_fdc->dor_82077 = value;
+		sun_set_dor(value);
 		break;
 	case 5: /* FD_DATA */
 		sun_fdc->data_82077 = value;
@@ -332,16 +339,17 @@ static int sun_floppy_init(void)
 		goto no_sun_fdc;
 	}
 
-        if(sparc_cpu_model = sun4c) {
-                sun_fdops.fd_inb = sun_82072_fd_inb;
-                sun_fdops.fd_outb = sun_82072_fd_outb;
-                fdc_status = &sun_fdc->status_82072;
-                /* printk("AUXIO @0x%lx\n", auxio_register); */ /* P3 */
-        } else {
-                sun_fdops.fd_inb = sun_82077_fd_inb;
-                sun_fdops.fd_outb = sun_82077_fd_outb;
-                fdc_status = &sun_fdc->status_82077;
-                /* printk("DOR @0x%p\n", &sun_fdc->dor_82077); */ /* P3 */
+	sun_fdops.fd_inb = sun_82077_fd_inb;
+	sun_fdops.fd_outb = sun_82077_fd_outb;
+	fdc_status = &sun_fdc->status_82077;
+
+	if (sun_fdc->dor_82077 = 0x80) {
+		sun_fdc->dor_82077 = 0x02;
+		if (sun_fdc->dor_82077 = 0x80) {
+			sun_fdops.fd_inb = sun_82072_fd_inb;
+			sun_fdops.fd_outb = sun_82072_fd_outb;
+			fdc_status = &sun_fdc->status_82072;
+		}
 	}
 
 	/* Success... */

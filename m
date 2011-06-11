From: Meelis Roos <mroos@linux.ee>
Date: Sat, 11 Jun 2011 16:51:01 +0000
Subject: Re: RTC problem on Netra X1?
Message-Id: <alpine.SOC.1.00.1106111948100.27021@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > > # hwclock --systohc
> > > Timed out waiting for time change.
> 
> The hwclock problem seems to have apperaed between 2.6.37 and 2.6.38 and 
> I will bisect it later.

Done bisecting. Found the following patch. Reverting this patch in 
3.0.0-rc2 fixes hwclock --systohc on my Sun Fire V100 (sparc64).

commit ac54cd2bd5b4db4f1c03392d63daf355627ea180
Author: John Stultz <john.stultz@linaro.org>
Date:   Wed Feb 2 16:55:19 2011 -0800

    RTC: Fix rtc driver ioctl specific shortcutting
    
    Some RTC drivers enable functionality directly via their ioctl method
    instead of using the generic ioctl handling code. With the recent
    virtualization of the RTC layer, its now important that the generic
    layer always be used.
    
    This patch moved the rtc driver ioctl method call to after the generic
    ioctl processing is done. This allows hardware specific features or
    ioctls to still function, while relying on the generic code for handling
    everything else.
    
    This patch on its own may more obviously break rtc drivers that
    implement the alarm irq enablement via their ioctl method instead of
    implementing the alarm_irq_eanble method. Those drivers will be fixed
    in a following patch. Additionaly, those drivers are already likely to
    not be functioning reliably without this patch.
    
    CC: Alessandro Zummo <a.zummo@towertech.it>
    CC: Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
    CC: Thomas Gleixner <tglx@linutronix.de>
    Reported-by: Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
    Tested-by: Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
    Signed-off-by: John Stultz <john.stultz@linaro.org>

diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/rtc-dev.c
index 212b16e..37c3cc1 100644
--- a/drivers/rtc/rtc-dev.c
+++ b/drivers/rtc/rtc-dev.c
@@ -154,19 +154,7 @@ static long rtc_dev_ioctl(struct file *file,
 	if (err)
 		goto done;
 
-	/* try the driver's ioctl interface */
-	if (ops->ioctl) {
-		err = ops->ioctl(rtc->dev.parent, cmd, arg);
-		if (err != -ENOIOCTLCMD) {
-			mutex_unlock(&rtc->ops_lock);
-			return err;
-		}
-	}
-
-	/* if the driver does not provide the ioctl interface
-	 * or if that particular ioctl was not implemented
-	 * (-ENOIOCTLCMD), we will try to emulate here.
-	 *
+	/*
 	 * Drivers *SHOULD NOT* provide ioctl implementations
 	 * for these requests.  Instead, provide methods to
 	 * support the following code, so that the RTC's main
@@ -329,7 +317,12 @@ static long rtc_dev_ioctl(struct file *file,
 		return err;
 
 	default:
-		err = -ENOTTY;
+		/* Finally try the driver's ioctl interface */
+		if (ops->ioctl) {
+			err = ops->ioctl(rtc->dev.parent, cmd, arg);
+			if (err = -ENOIOCTLCMD)
+				err = -ENOTTY;
+		}
 		break;
 	}
 

-- 
Meelis Roos (mroos@linux.ee)

From: Chris Newport <crn@netunix.com>
Date: Thu, 19 Aug 2004 13:32:47 +0000
Subject: Patch - Sun4d SMP now boots
Message-Id: <Pine.LNX.4.53.0408191358400.2910@mailgate.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I have now applied the patch posted to the list by Pasi Pirhonen
on 19Nov2003. This needs to be applied AFTER the patches from Thomas.

More work is needed to get rid of the previously reported compiler
warnings in the same function before this is fit to be submitted, but
I will have to leave that to those who understand what they are doing
<B-).

This now boots and runs, but is horribly unstable.

==== BEGIN INCLUDE

root@phobos:~# cd /usr/src/linux/arch/sparc/kernel
root@phobos:/usr/src/linux/arch/sparc/kernel# diff -ru sun4d_smp.csaved sun4d_s
mp.c

--- sun4d_smp.csaved	2004-08-19 13:12:24.000000000 +0100
+++ sun4d_smp.c	2004-08-19 13:46:07.000000000 +0100
@@ -340,7 +340,8 @@
 		register int high = smp_highest_cpu;
 		unsigned long flags;

-		spin_lock_irqsave(&cross_call_lock, flags);
+		//spin_lock_irqsave(&cross_call_lock, flags);
+		spin_lock_bh(&cross_call_lock);

 		{
 			/* If you make changes here, make sure gcc generates proper code... */
@@ -373,6 +374,8 @@
 				}
 			}
 		}
+		/* first run local copy */
+		func(arg1, arg2, arg3, arg4, arg5);

 		{
 			register int i;
@@ -390,8 +393,10 @@
 			} while(++i <= high);
 		}

-		spin_unlock_irqrestore(&cross_call_lock, flags);
-	}
+		//spin_unlock_irqrestore(&cross_call_lock, flags);
+		spin_unlock_bh(&cross_call_lock);
+	} else
+		func(arg1, arg2, arg3, arg4, arg5); /* just need to run local copy */
 }

 /* Running cross calls. */

===== END INCLUDE

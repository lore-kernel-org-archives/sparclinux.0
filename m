From: carbonated beverage <ramune@net-ronin.org>
Date: Sun, 15 Feb 2004 09:37:55 +0000
Subject: Re: [Q] sun mouse on 2.6.x
Message-Id: <20040215093755.GA27548@net-ronin.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040215002314.GH19221@net-ronin.org>
In-Reply-To: <20040215002314.GH19221@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Okay, tried adding this to drivers/input/mousedev.c:

=== mousedev.c 1.33 vs edited ==--- 1.33/drivers/input/mousedev.c	Thu Jan 15 03:06:00 2004
+++ edited/mousedev.c	Sat Feb 14 21:49:01 2004
@@ -428,6 +428,9 @@
 
 	list->buffer -= count;
 
+	printk(KERN_INFO "list->ps2:%x%x%x%x%x%x\n", (char)list->ps2[0], (char)(list->ps2[1]),
+	    (char)(list->ps2[2]), (char)(list->ps2[3]), (char)(list->ps2[4]), (char)(list->ps2[5]));
+
 	if (copy_to_user(buffer, list->ps2 + list->bufsiz - list->buffer - count, count))
 		return -EFAULT;

I see:

list->ps2:fffffffa00000
list->ps2:fffffffa00000
list->ps2:fffffffa00000
list->ps2:fffffffa00000
list->ps2:fffffffa00000
list->ps2:fffffffa00000
list->ps2:fffffffa00000
list->ps2:fffffffa00000

Shortly after the module loads.  I move the mouse.  Nothing.
Doesn't look like it's getting anything at all, ever.

But it works under Solaris... :-/

Ideas?

-- DN
Daniel

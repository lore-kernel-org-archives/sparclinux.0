From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 13 Oct 2006 15:26:14 +0000
Subject: Re: [PATCH] sparc32: remove '-s' boot argument
Message-Id: <20061013152613.GA27639@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20061012152243.GA21924@palantir8>
In-Reply-To: <20061012152243.GA21924@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Oct 12, 2006 at 02:52:18PM -0700, David Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Thu, 12 Oct 2006 16:22:43 +0100
> 
> > The '-s' boot argument is not working and not needed. Users should use
> > argument 's' or '1' to boot into single user mode.
> > This patch removes the remains of the '-s' argument.
> > 
> > Martin
> > 
> > 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
> 
> Applied, and I killed it from sparc64 too.

I'm afraid my patch was not correct. Although the kernel does nothing
with this flag, init does honour it and boots into single user mode.
Adding the case statement back prevents the kernel from printing the
message "Unknown boot switch (-s)" from the default case.

I did a sparc64 patch as well this time.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
Index: linux/arch/sparc/kernel/setup.c
=================================--- linux.orig/arch/sparc/kernel/setup.c	2006-10-13 16:16:46.000000000 +0100
+++ linux/arch/sparc/kernel/setup.c	2006-10-13 16:18:13.000000000 +0100
@@ -131,6 +131,9 @@
 	case 'd':
 		boot_flags |= BOOTME_DEBUG;
 		break;
+	case 's':
+		/* init honours this flag to boot into single user mode */
+		break;
 	case 'h':
 		prom_printf("boot_flags_init: Halt!\n");
 		prom_halt();
Index: linux/arch/sparc64/kernel/setup.c
=================================--- linux.orig/arch/sparc64/kernel/setup.c	2006-10-13 16:19:16.000000000 +0100
+++ linux/arch/sparc64/kernel/setup.c	2006-10-13 16:20:21.000000000 +0100
@@ -110,6 +110,9 @@
 	case 'd':
 		boot_flags |= BOOTME_DEBUG;
 		break;
+	case 's':
+		/* init honours this flag to boot into single user mode */
+		break;
 	case 'h':
 		prom_printf("boot_flags_init: Halt!\n");
 		prom_halt();

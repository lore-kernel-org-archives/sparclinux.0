From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 22 Dec 2004 23:38:36 +0000
Subject: Re: [sparc32] vm fault code handling
Message-Id: <20041222233836.GJ2725@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20041222143113.GT771@holomorphy.com>
In-Reply-To: <20041222143113.GT771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 22, 2004 at 06:31:13AM -0800, William Lee Irwin III wrote:
> Convert arch/sparc/mm/fault.c to symbolic fault codes, default to minor
> faults for unrecognized fault codes. Also treat VM_FAULT_OOM similarly
> to VM_FAULT_SIGBUS in force_user_fault(), thereby fixing a latent bug.
> 
> [ ... snip patch ... ]

Hi.

Here's a slightly modified version of that patch which makes the sparc32
code more closely match the sparc64 code by setting the default branch
of the case statement to BUG(). The rest of the patch matched what was
posted above.

Art Haas

=== arch/sparc/mm/fault.c 1.19 vs edited ==--- 1.19/arch/sparc/mm/fault.c	2004-07-13 07:56:23 -05:00
+++ edited/arch/sparc/mm/fault.c	2004-12-22 17:24:37 -06:00
@@ -294,16 +294,18 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
-		current->min_flt++;
-		break;
-	case 2:
+	case VM_FAULT_SIGBUS:
+		goto do_sigbus;
+	case VM_FAULT_OOM:
+		goto out_of_memory;
+	case VM_FAULT_MAJOR:
 		current->maj_flt++;
 		break;
-	case 0:
-		goto do_sigbus;
+	case VM_FAULT_MINOR:
+		current->min_flt++;
+		break;
 	default:
-		goto out_of_memory;
+		BUG();
 	}
 	up_read(&mm->mmap_sem);
 	return;
@@ -535,8 +537,11 @@
 		if(!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;
 	}
-	if (!handle_mm_fault(mm, vma, address, write))
+	switch (handle_mm_fault(mm, vma, address, write)) {
+	case VM_FAULT_SIGBUS:
+	case VM_FAULT_OOM:
 		goto do_sigbus;
+	}
 	up_read(&mm->mmap_sem);
 	return;
 bad_area:


-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 03 May 2004 16:42:27 +0000
Subject: [PATCH] Trivial reformatting patch
Message-Id: <20040503164227.GD29241@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

The following trivial patch does a bit of re-formatting on the
code.

I will probably be sending in a number of small patches this week. My
debugging efforts in trying to figure out the num_physpages problem
pointed out a few places in the code where useless variables are
calculated, externally visible functions can be made static, and a
number of other small things can be improved.

Art Haas
=== arch/sparc/mm/init.c 1.27 vs edited ==--- 1.27/arch/sparc/mm/init.c	Sun Mar 21 16:43:34 2004
+++ edited/arch/sparc/mm/init.c	Mon May  3 11:27:41 2004
@@ -369,9 +369,8 @@
 		end = start + sp_banks[i].num_bytes;
 
 		while (start < end) {
-			set_bit (start >> 20,
-				sparc_valid_addr_bitmap);
-				start += PAGE_SIZE;
+			set_bit(start >> 20, sparc_valid_addr_bitmap);
+			start += PAGE_SIZE;
 		}
 	}
 }
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

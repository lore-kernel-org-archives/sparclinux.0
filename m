From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Wed, 15 Jan 2020 16:07:50 +0000
Subject: [PATCH RESEND] sparc/console: kill off obsolete declarations
Message-Id: <20200115160749.GA3951901@rani.riverdale.lan>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

commit 09d3f3f0e02c ("sparc: Kill PROM console driver.") missed removing
the declarations of the deleted prom_con structure and prom_con_init
function from console.h. Kill them off now.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 include/linux/console.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d09951d5a94e..f33016b3a401 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -101,7 +101,6 @@ extern const struct consw *conswitchp;
 extern const struct consw dummy_con;	/* dummy console buffer */
 extern const struct consw vga_con;	/* VGA text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
-extern const struct consw prom_con;	/* SPARC PROM console */
 
 int con_is_bound(const struct consw *csw);
 int do_unregister_con_driver(const struct consw *csw);
@@ -201,7 +200,6 @@ extern void suspend_console(void);
 extern void resume_console(void);
 
 int mda_console_init(void);
-void prom_con_init(void);
 
 void vcs_make_sysfs(int index);
 void vcs_remove_sysfs(int index);
-- 
2.24.1

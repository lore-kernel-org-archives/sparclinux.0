From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 12 Jan 2014 18:07:30 +0000
Subject: [PATCH] sparc: don't use module_init in non-modular pci.c code
Message-Id: <1389550050-17936-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The pci.o is built for SPARC64_PCI -- which is bool, and hence
this code is either present or absent.  It will never be modular,
so using module_init as an alias for __initcall can be somewhat
misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of device_initcall
directly in this change means that the runtime impact is
zero -- it will remain at level 6 in initcall ordering.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index cb021453de2a..034229b3793a 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1005,6 +1005,5 @@ static int __init of_pci_slot_init(void)
 
 	return 0;
 }
-
-module_init(of_pci_slot_init);
+device_initcall(of_pci_slot_init);
 #endif
-- 
1.8.5.2


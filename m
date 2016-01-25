From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 25 Jan 2016 22:24:27 +0000
Subject: [PATCH v2 13/16] amdkfd: Use in_compat_syscall to check open() caller type
Message-Id: <f9ae00f060781de8174c371b3c1918ff429572f4.1453759363.git.luto@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org

amdkfd wants to know syscall type, not task type.  Check directly.

Unfortunately, amdkfd is making nasty assumptions that a process'
bitness is a well-defined constant thing.  This isn't the case on
x86.  I don't know how much this matters, but this patch has no
effect on generated code on x86, so amdkfd is equally broken with
and without this patch.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d2b49c026cf6..07ac724e3ec9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -107,7 +107,7 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	if (iminor(inode) != 0)
 		return -ENODEV;
 
-	is_32bit_user_mode = is_compat_task();
+	is_32bit_user_mode = in_compat_syscall();
 
 	if (is_32bit_user_mode = true) {
 		dev_warn(kfd_device,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9be007081b72..fd1a90a0f435 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -311,7 +311,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 		goto err_process_pqm_init;
 
 	/* init process apertures*/
-	process->is_32bit_user_mode = is_compat_task();
+	process->is_32bit_user_mode = in_compat_syscall();
 	if (kfd_init_apertures(process) != 0)
 		goto err_init_apretures;
 
-- 
2.5.0


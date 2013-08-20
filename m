From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 20 Aug 2013 19:17:24 +0000
Subject: [PATCH] sparc: fix PCI device proc file mmap(2)
Message-Id: <20130820191723.GA3683@p183.telecom.by>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Commit 786d7e1612f0b0adb6046f19b906609e4fe8b1ba "Fix rmmod/read/write races in /proc entries"
must have broken mmapping of PCI device proc files on Sparc.

Notice how it adds wrapper around ->mmap but doesn't do it around ->get_unmapped_area.
Add wrapper around ->get_unmapped_area.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 073aea6..9f8ef9b 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -285,6 +285,20 @@ static int proc_reg_mmap(struct file *file, struct vm_area_struct *vma)
 	return rv;
 }
 
+static unsigned long proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr, unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct proc_dir_entry *pde = PDE(file_inode(file));
+	int rv = -EIO;
+	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+	if (use_pde(pde)) {
+		get_unmapped_area = pde->proc_fops->get_unmapped_area;
+		if (get_unmapped_area)
+			rv = get_unmapped_area(file, orig_addr, len, pgoff, flags);
+		unuse_pde(pde);
+	}
+	return rv;
+}
+
 static int proc_reg_open(struct inode *inode, struct file *file)
 {
 	struct proc_dir_entry *pde = PDE(inode);
@@ -356,6 +370,7 @@ static const struct file_operations proc_reg_file_ops = {
 	.compat_ioctl	= proc_reg_compat_ioctl,
 #endif
 	.mmap		= proc_reg_mmap,
+	.get_unmapped_area = proc_reg_get_unmapped_area,
 	.open		= proc_reg_open,
 	.release	= proc_reg_release,
 };
@@ -368,6 +383,7 @@ static const struct file_operations proc_reg_file_ops_no_compat = {
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.mmap		= proc_reg_mmap,
+	.get_unmapped_area = proc_reg_get_unmapped_area,
 	.open		= proc_reg_open,
 	.release	= proc_reg_release,
 };
-- 
1.8.1.5


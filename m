From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Thu, 08 Dec 2016 18:11:51 +0000
Subject: [PATCH] coredump: Ensure proper size of sparse core files
Message-Id: <20161208181151.28127-1-dave.kleikamp@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: sparclinux@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

If the last section of a core file ends with an unmapped or zero page,
the size of the file does not correspond with the last dump_skip() call.
gdb complains that the file is truncated and can be confusing to users.

After all of the vma sections are written, make sure that the file size
is no smaller than the current file position.

This problem can be demonstrated with gdb's bigcore testcase on the
sparc architecture.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/binfmt_elf.c          |  1 +
 fs/coredump.c            | 18 ++++++++++++++++++
 include/linux/coredump.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 2472af2..cfd724f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2296,6 +2296,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 				goto end_coredump;
 		}
 	}
+	dump_truncate(cprm);
 
 	if (!elf_core_write_extra_data(cprm))
 		goto end_coredump;
diff --git a/fs/coredump.c b/fs/coredump.c
index eb9c92c..ecdb1e3 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -833,3 +833,21 @@ int dump_align(struct coredump_params *cprm, int align)
 	return mod ? dump_skip(cprm, align - mod) : 1;
 }
 EXPORT_SYMBOL(dump_align);
+
+/*
+ * Insures that file size is big enough to contain the current file
+ * postion. This prevents gdb from complaining about a truncated file
+ * if the last "write" to the file was dump_skip.
+ */
+void dump_truncate(struct coredump_params *cprm)
+{
+	struct file *file = cprm->file;
+	loff_t offset;
+
+	if (file->f_op->llseek && file->f_op->llseek != no_llseek) {
+		offset = file->f_op->llseek(file, 0, SEEK_CUR);
+		if (i_size_read(file->f_mapping->host) < offset)
+			do_truncate(file->f_path.dentry, offset, 0, file);
+	}
+}
+EXPORT_SYMBOL(dump_truncate);
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index d016a12..28ffa94 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -14,6 +14,7 @@ struct coredump_params;
 extern int dump_skip(struct coredump_params *cprm, size_t nr);
 extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
+extern void dump_truncate(struct coredump_params *cprm);
 #ifdef CONFIG_COREDUMP
 extern void do_coredump(const siginfo_t *siginfo);
 #else
-- 
2.10.2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED272471D1C;
	Tue, 15 Sep 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471891; cv=none; b=fvxgIuzLU7kMIyphVS7WW13ydw2ntXGR79+ssjuZ/9Xj0/J9MfIEM0P6zYLsLYK+0qkUHkb7zjgr8bDc9+YPT5o5FVVYzN9Vwm0UiVDu6Tn9QiGRMvGzOAYjNsPBLaa4NIFdQkfwsSh3wMRN1U6lF36sbbOj7k6a1J3jGoZLCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471891; c=relaxed/simple;
	bh=qwpcRc0Jz1/hf+VtwtU8xLhtdahWTgGJe+R6RdnVR1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBx3iJttbNcc1Z4qy7H+iA9CAJIiozX32KjQYKmIlCXRsCsnyJWtJfaOeYlG/Mk9EGEC3VKnDmKmYkpvgjPM0ckIH0tGSnk2ILoq6VESlqL+SprVvMil/AtC054sMPSyzSdXkxitMANi19FXIJ/R/0+5d1LF01zY2bBZdlflm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iha9zwIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iha9zwIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755561F00893;
	Tue, 15 Sep 2026 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471888;
	bh=BV+bpXMF0kMr9afG7XMe1ZpQQUGKxWkKKhyZrn6MnI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iha9zwIEtPNkm47XS9IHbSz+doc5x/a0q/BqO5RtdRLBAwJzWWK80HBFjho8vmdLm
	 FVXtzi7D7n3QZYfGQUCaFyIX3kmSsTcpUvtiUA6x4KKHv/BBBHR1xLNY7O8V+AYhW5
	 6cijN8aepL9eGspZfHpuTUE9Uq0wYtHVBWMS4wfdRaRp4qChXosjV75w3F2vajImL0
	 37udrL9kmbghIGDt8lvamiamwd5W3kRtRtu7QLfk+6ZfTko2QQy8lt94CL9MoHGkzk
	 YL+StidMUnw4Q+mYhHY2HGWnUmxnlaLD+cmj782YsQP2euPh3/aoEsXUeTUBCBHLQg
	 cIiDaVWOaMMdQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:47 +0200
Subject: [PATCH RFC POC 01/50] file: install files on syscall exit
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-1-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=12607; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qwpcRc0Jz1/hf+VtwtU8xLhtdahWTgGJe+R6RdnVR1g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kn5Lv3aQNl0bc5joV2rHG692cW0rpr7WL5SYUXhg
 aV+y6cpd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk0i+G/3mbDwQKNu5VuZek
 N3OWQP6mtXkp0f/+1gs5LXbLerLqtSkjwznpCQcXHti+8cTFD50rwvm6Jr72yVvkOkcw0aS/fZ7
 eGlYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So we've spoken about this idea quite a few times over the years that
we could reserve fds and files on a task and then install or a clean
them up on syscall success or error and get rid of most of the
complicated cleanup dance that we have.

My original approach to this had been to implement FD_PREPARE() based on
cleanup guards and use scopes to make this happen. The other idea was
what I'm illustrating here. It is overall equally robust and makes the
install fd and file pattern work even if it there's a ton of cleanup or
setup work happening in the middle. This is particular evident in the
conversions of various dma/drm code later in the series.

So this lets the syscall path do the install. fd_prepare() allocates a
descriptor like get_unused_fd_flags() does and records it in a slot on
the task. fd_stage() attaches the file to that slot and returns the
number.

When the syscall returns success the exit path installs every staged
file. When it returns an error it drops the descriptors and the files.

So a caller reserves, hands the number to userspace whenever it wants,
creates the file, stages it and returns errors without unwinding
anything.

fd_prepare() returns the slot itself, as a const pointer. The
preexisting fd_prepare_fd() and fd_prepare_file() give access to the fd
and file.

get_unused_fd_flags() and fd_install() don't change. A descriptor is
only reserved where a caller asks for it. And open(), dup() and all
other syscalls that maximize speed simply use FD_ADD().

The task keeps two slots inline. For SCM_RIGHTS and multi-descriptor
ioctls a spill array is added. It stick with the task.

Reservations belong to the thread and the syscall that made them. A
child of fork() starts without any. A thread can't unshare its
fdtagble with outstanding reservations. Kernel threads never return to
userspace so nothing would commit. Anything left at exit is a bug and
gets warned about and dropped.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c             | 203 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/file.h  |  37 +++++++--
 include/linux/sched.h |  21 ++++++
 kernel/exit.c         |   1 +
 kernel/fork.c         |   1 +
 5 files changed, 256 insertions(+), 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 628ca07dc4b1..90351241bb07 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -630,14 +630,215 @@ static void __put_unused_fd(struct files_struct *files, unsigned int fd)
 		files->next_fd = fd;
 }
 
-void put_unused_fd(unsigned int fd)
+/* Release @fd in the table, its slot is the caller's business. */
+static void fd_release(unsigned int fd)
 {
 	struct files_struct *files = current->files;
+
 	spin_lock(&files->file_lock);
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
 }
 
+/* Enough for SCM_MAX_FD, and a page of slots on 4K pages. */
+#define FD_SLOTS_SPILL_MIN	256
+
+static struct fd_slot *fd_slot(struct fd_slots *slots, unsigned int idx)
+{
+	if (idx < FD_SLOTS_INLINE)
+		return &slots->inline_slots[idx];
+	return &slots->spill[idx - FD_SLOTS_INLINE];
+}
+
+/* Room for slot @idx in the spill array, doubling as it fills up. */
+static noinline struct fd_slot *fd_slots_spill(struct fd_slots *slots,
+					      unsigned int idx)
+{
+	unsigned int max = slots->spill_max;
+	struct fd_slot *spill;
+
+	idx -= FD_SLOTS_INLINE;
+	if (idx < max)
+		return &slots->spill[idx];
+
+	max = max ? max * 2 : FD_SLOTS_SPILL_MIN;
+	spill = kvrealloc(slots->spill, array_size(max, sizeof(*spill)),
+			  GFP_KERNEL_ACCOUNT);
+	if (!spill)
+		return NULL;
+	slots->spill = spill;
+	slots->spill_max = max;
+	return &spill[idx];
+}
+
+/* Record @fd in the next slot, returns the slot. */
+static struct fd_slot *fd_slot_record(int fd)
+{
+	struct fd_slots *slots = &current->fd_slots;
+	unsigned int idx = slots->nr;
+	struct fd_slot *slot;
+
+	/* Nothing would ever commit what a kernel thread prepares. */
+	VFS_WARN_ON_ONCE(current->flags & PF_KTHREAD);
+
+	if (likely(idx < FD_SLOTS_INLINE)) {
+		slot = &slots->inline_slots[idx];
+	} else {
+		slot = fd_slots_spill(slots, idx);
+		if (!slot)
+			return ERR_PTR(-ENOMEM);
+	}
+	ACCESS_PRIVATE(slot, fd) = fd;
+	ACCESS_PRIVATE(slot, file) = NULL;
+	slots->nr = idx + 1;
+	return slot;
+}
+
+/* The slot holding @fd, if this syscall prepared it. */
+static inline int fd_slot_find(struct fd_slots *slots, unsigned int fd)
+{
+	unsigned int idx = slots->nr;
+
+	while (idx--) {
+		if (ACCESS_PRIVATE(fd_slot(slots, idx), fd) == fd)
+			return idx;
+	}
+	return -1;
+}
+
+/**
+ * fd_prepare - allocate a descriptor that the syscall exit installs
+ * @flags: O_CLOEXEC or 0
+ *
+ * Returns the prepared slot as a const handle or an error pointer.
+ */
+const struct fd_slot *fd_prepare(unsigned flags)
+{
+	struct fd_slot *slot;
+	int fd;
+
+	fd = get_unused_fd_flags(flags);
+	if (fd < 0)
+		return ERR_PTR(fd);
+
+	slot = fd_slot_record(fd);
+	if (IS_ERR(slot))
+		fd_release(fd);
+	return slot;
+}
+EXPORT_SYMBOL(fd_prepare);
+
+/**
+ * fd_stage - attach the file to a prepared slot
+ * @slot: slot from fd_prepare()
+ * @file: the file to install, consumed
+ *
+ * Returns the number. The syscall exit installs @file there when the syscall
+ * returns success and drops it when the syscall returns an error.
+ */
+int fd_stage(const struct fd_slot *slot, struct file *file)
+{
+	struct fd_slot *s = (struct fd_slot *)slot;
+
+	VFS_WARN_ON_ONCE(ACCESS_PRIVATE(s, file));
+	ACCESS_PRIVATE(s, file) = file;
+	return ACCESS_PRIVATE(s, fd);
+}
+EXPORT_SYMBOL(fd_stage);
+
+/**
+ * __fd_slot_fd - the descriptor number of a prepared slot
+ * @slot: slot from fd_prepare()
+ */
+int __fd_slot_fd(const struct fd_slot *slot)
+{
+	return ACCESS_PRIVATE(slot, fd);
+}
+EXPORT_SYMBOL(__fd_slot_fd);
+
+/**
+ * __fd_slot_file - the file staged into a slot, to configure before install
+ * @slot: slot from fd_prepare()
+ *
+ * Returns the file handed to fd_stage(), or NULL before one is staged.
+ */
+struct file *__fd_slot_file(const struct fd_slot *slot)
+{
+	return ACCESS_PRIVATE(slot, file);
+}
+EXPORT_SYMBOL(__fd_slot_file);
+
+/* Install every staged file, release the slots that never got one. */
+static void fd_slots_install(struct fd_slots *slots)
+{
+	unsigned int idx;
+
+	for (idx = 0; idx < slots->nr; idx++) {
+		struct fd_slot *slot = fd_slot(slots, idx);
+
+		if (ACCESS_PRIVATE(slot, file))
+			fd_install(ACCESS_PRIVATE(slot, fd),
+				   ACCESS_PRIVATE(slot, file));
+		else
+			fd_release(ACCESS_PRIVATE(slot, fd));
+	}
+}
+
+/* Release every slot's descriptor and drop the staged files. */
+static void fd_slots_drop(struct fd_slots *slots)
+{
+	struct files_struct *files = current->files;
+	unsigned int idx;
+
+	spin_lock(&files->file_lock);
+	for (idx = 0; idx < slots->nr; idx++)
+		__put_unused_fd(files, ACCESS_PRIVATE(fd_slot(slots, idx), fd));
+	spin_unlock(&files->file_lock);
+	for (idx = 0; idx < slots->nr; idx++) {
+		struct fd_slot *slot = fd_slot(slots, idx);
+
+		if (ACCESS_PRIVATE(slot, file))
+			fput(ACCESS_PRIVATE(slot, file));
+	}
+}
+
+static __always_inline void fd_slots_finish(struct fd_slots *slots, bool failed)
+{
+	if (likely(!failed))
+		fd_slots_install(slots);
+	else
+		fd_slots_drop(slots);
+	slots->nr = 0;
+}
+
+/* Install or drop the prepared descriptors based on @ret. */
+void __fd_slots_commit(long ret)
+{
+	fd_slots_finish(&current->fd_slots, IS_ERR_VALUE(ret));
+}
+
+void exit_fd_slots(void)
+{
+	struct fd_slots *slots = &current->fd_slots;
+
+	/* A syscall must not exit with prepared descriptors outstanding. */
+	if (WARN_ON_ONCE(slots->nr))
+		fd_slots_finish(slots, true);
+	kvfree(slots->spill);
+}
+
+/**
+ * put_unused_fd - give a descriptor back before it got a file
+ * @fd: descriptor returned by get_unused_fd_flags()
+ *
+ * Not for a prepared descriptor, the syscall exit releases that one.
+ */
+void put_unused_fd(unsigned int fd)
+{
+	VFS_WARN_ON_ONCE(fd_slot_find(&current->fd_slots, fd) >= 0);
+	fd_release(fd);
+}
+
 EXPORT_SYMBOL(put_unused_fd);
 
 /*
diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444d31..fe2893eea945 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -91,6 +91,8 @@ extern bool get_close_on_exec(unsigned int fd);
 extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
+void __fd_slots_commit(long ret);
+void exit_fd_slots(void);
 
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
@@ -118,6 +120,12 @@ DEFINE_FREE(fput, struct file *, if (!IS_ERR_OR_NULL(_T)) fput(_T))
 
 extern void fd_install(unsigned int fd, struct file *file);
 
+struct fd_slot;
+const struct fd_slot *fd_prepare(unsigned flags);
+int fd_stage(const struct fd_slot *slot, struct file *file);
+int __fd_slot_fd(const struct fd_slot *slot);
+struct file *__fd_slot_file(const struct fd_slot *slot);
+
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);
 
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
@@ -148,15 +156,32 @@ struct fd_prepare {
 /* Typedef for fd_prepare cleanup guards. */
 typedef struct fd_prepare class_fd_prepare_t;
 
+/* Do not use directly. */
+static inline int __fd_prepare_fd_old(struct fd_prepare fdf)
+{
+	return fdf.__fd;
+}
+
+/* Do not use directly. */
+static inline struct file *__fd_prepare_file_old(struct fd_prepare fdf)
+{
+	return fdf.__file;
+}
+
 /*
- * Accessors for fd_prepare class members.
- * _Generic() is used for zero-cost type safety.
+ * Accessors for a prepared descriptor. _Generic() bridges struct fd_prepare
+ * (the cleanup class below) and struct fd_slot (fd_prepare()) while callers are
+ * converted; the struct fd_prepare arm goes away with FD_PREPARE().
  */
-#define fd_prepare_fd(_fdf) \
-	(_Generic((_fdf), struct fd_prepare: (_fdf).__fd))
+#define fd_prepare_fd(_x) _Generic((_x),				\
+	struct fd_prepare:	__fd_prepare_fd_old,			\
+	struct fd_slot *:	__fd_slot_fd,				\
+	const struct fd_slot *:	__fd_slot_fd)(_x)
 
-#define fd_prepare_file(_fdf) \
-	(_Generic((_fdf), struct fd_prepare: (_fdf).__file))
+#define fd_prepare_file(_x) _Generic((_x),				\
+	struct fd_prepare:	__fd_prepare_file_old,			\
+	struct fd_slot *:	__fd_slot_file,				\
+	const struct fd_slot *:	__fd_slot_file)(_x)
 
 /* Do not use directly. */
 static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8b3d47a325cc..52bbf9931908 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -832,6 +832,24 @@ struct task_ipi_mask {
 struct task_ipi_mask { };
 #endif
 
+/* Descriptors this syscall prepared, installed when it returns. */
+#define FD_SLOTS_INLINE	2
+
+struct file;
+
+struct fd_slot {
+	struct file			* __private file;
+	int				__private fd;
+};
+
+/* Inline up to FD_SLOTS_INLINE slots, the rest in the spill. */
+struct fd_slots {
+	unsigned int			nr;
+	unsigned int			spill_max;
+	struct fd_slot			*spill;
+	struct fd_slot			inline_slots[FD_SLOTS_INLINE];
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1206,6 +1224,9 @@ struct task_struct {
 	/* Open file information: */
 	struct files_struct		*files;
 
+	/* Descriptors prepared by the current syscall: */
+	struct fd_slots			fd_slots;
+
 #ifdef CONFIG_IO_URING
 	struct io_uring_task		*io_uring;
 	struct io_restriction		*io_uring_restrict;
diff --git a/kernel/exit.c b/kernel/exit.c
index 97686af89501..ee108353a62c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1000,6 +1000,7 @@ void __noreturn do_exit(long code)
 
 	exit_sem(tsk);
 	exit_shm(tsk);
+	exit_fd_slots();
 	exit_files(tsk);
 	exit_fs(tsk);
 	if (group_dead)
diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..59c5cfa3e482 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -980,6 +980,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->btrace_seq = 0;
 #endif
 	tsk->splice_pipe = NULL;
+	memset(&tsk->fd_slots, 0, sizeof(tsk->fd_slots));
 	tsk->task_frag.page = NULL;
 	tsk->wake_q.next = NULL;
 	tsk->worker_private = NULL;

-- 
2.53.0


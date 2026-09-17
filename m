Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABB4E0211;
	Thu, 17 Sep 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658203; cv=none; b=HdVjbTHmp5q3LoaaKCDN8HQOwM6VUQPVW9YyZ90q64dtjIHvmQCKQXAyqkrB/S/YhA/PPFyUycaBS5J01wcvcluYLTX7CZZ9eu1mTaJLl4QBIr892f1u3+IvsPPzGop2s7QearoGeTBUFp8/pS16dkLwh5FeckZ19udH91v1Y8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658203; c=relaxed/simple;
	bh=FC3OWtLf/sdb0iJVCweCdI8laEBVDKGE/iTcFg6qk2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/3GN2v0zn4h/NlYMjqvZm3Dw0FyTnKPgoOhoINDT/ML5Z0V2csCb9L65Mm4CXkeN16T92dMMb7nqjyDuIaAlCBN7Ic8ubVMwmm5w72wv5+cKRP+pZoO2cJb1DCwh9w+CZbJWGF1eRIw4nNsRYAKo48vxhLJ9hsyfshT+9+/eSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=BSCqgURe; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="BSCqgURe"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1789658184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sR4dhkYHoqw12xEqNRPShiOnvwuRdnv5DtATk5Av280=;
	b=BSCqgUReiuEJNEZdBc+UYBtWo6RVQjX16UehxtIyPdG3EzvABkBng66p+iVMo3SPlnBZmQ
	edp0I0wOcv09Vje7Qm+UwMhLvxr/baMiv/1+jrKwOxrR0ScalGjfuLCJkbhnbWwyRhbPO9
	J6qv+S/j7TmfTna+2H1w0Sks62c1Eb4=
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	schwab@suse.de,
	fweimer@redhat.com,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 2/2] fs: allow positional I/O on files with unsigned offsets
Date: Thu, 17 Sep 2026 17:16:14 +0200
Message-ID: <20260917151614.376867-3-stian@itx.no>
In-Reply-To: <20260917151614.376867-1-stian@itx.no>
References: <20260917151614.376867-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pread64(), pwrite64(), preadv() and pwritev() reject a negative position
with -EINVAL before looking up the file, so FOP_UNSIGNED_OFFSET is never
consulted.  lseek() followed by read() on the same descriptor accepts
the position, and rw_verify_area() already handles it, overflow check
included.  Only the positional syscall wrappers reject it up front.

Check the position after the file lookup and let a negative value
through for files with unsigned offsets, as vfs_setpos_cookie() and
rw_verify_area() do.  Behavior for every other file is unchanged.

On sparc64 userspace is mapped above 2^63, so pread() on /proc/PID/mem
always failed with EINVAL.  pldd(1) could not read a target's memory
because of this, and gdb carries a userspace workaround for the same
thing (PR gdb/30525).

Signed-off-by: Stian Halseth <stian@itx.no>
---
 fs/read_write.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 36f3d8e..e46e814 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -753,13 +753,13 @@ SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
 ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
 		     loff_t pos)
 {
-	if (pos < 0)
-		return -EINVAL;
-
 	CLASS(fd, f)(fd);
 	if (fd_empty(f))
 		return -EBADF;
 
+	if (pos < 0 && !unsigned_offsets(fd_file(f)))
+		return -EINVAL;
+
 	if (fd_file(f)->f_mode & FMODE_PREAD)
 		return vfs_read(fd_file(f), buf, count, &pos);
 
@@ -783,13 +783,13 @@ COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, buf,
 ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
 		      size_t count, loff_t pos)
 {
-	if (pos < 0)
-		return -EINVAL;
-
 	CLASS(fd, f)(fd);
 	if (fd_empty(f))
 		return -EBADF;
 
+	if (pos < 0 && !unsigned_offsets(fd_file(f)))
+		return -EINVAL;
+
 	if (fd_file(f)->f_mode & FMODE_PWRITE)
 		return vfs_write(fd_file(f), buf, count, &pos);
 
@@ -1123,14 +1123,14 @@ static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 {
 	ssize_t ret = -EBADF;
 
-	if (pos < 0)
-		return -EINVAL;
-
 	CLASS(fd, f)(fd);
 	if (!fd_empty(f)) {
-		ret = -ESPIPE;
-		if (fd_file(f)->f_mode & FMODE_PREAD)
-			ret = vfs_readv(fd_file(f), vec, vlen, &pos, flags);
+		ret = -EINVAL;
+		if (pos >= 0 || unsigned_offsets(fd_file(f))) {
+			ret = -ESPIPE;
+			if (fd_file(f)->f_mode & FMODE_PREAD)
+				ret = vfs_readv(fd_file(f), vec, vlen, &pos, flags);
+		}
 	}
 
 	if (ret > 0)
@@ -1144,14 +1144,14 @@ static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
 {
 	ssize_t ret = -EBADF;
 
-	if (pos < 0)
-		return -EINVAL;
-
 	CLASS(fd, f)(fd);
 	if (!fd_empty(f)) {
-		ret = -ESPIPE;
-		if (fd_file(f)->f_mode & FMODE_PWRITE)
-			ret = vfs_writev(fd_file(f), vec, vlen, &pos, flags);
+		ret = -EINVAL;
+		if (pos >= 0 || unsigned_offsets(fd_file(f))) {
+			ret = -ESPIPE;
+			if (fd_file(f)->f_mode & FMODE_PWRITE)
+				ret = vfs_writev(fd_file(f), vec, vlen, &pos, flags);
+		}
 	}
 
 	if (ret > 0)
-- 
2.43.0


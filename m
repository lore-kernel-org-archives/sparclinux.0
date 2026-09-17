Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C33859D4;
	Thu, 17 Sep 2026 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658209; cv=none; b=FsBYzzx1hzv/ctdM4rAYDZZQN63T1pxVTdzKsvgd5iYiqKDoHDRCmrj0Ne3Ztbf+BMS6Qois9KBR/fUdm5khFUm04qPXerdkxvXrhLhXXpRyFC2EpiXzlUjH7w+wuaRgWIiE4gJaHwbbto2oGozgEPivjCTzHWhapd7YZrBWmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658209; c=relaxed/simple;
	bh=ctArWGu44S3wRR5JrZsCQaWBlGMqztUdNyeGuW/ZhnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pm766+WBs6KjnmNhuV2YFrdteY2XalDlEAb50dM/p+ycK8p73DZTcw/NTEhg/wn8ox2qG0sw05DMsz5nOPEWjLdB51aIAeFxaX+/5IpBHDrKbeNBAGyDBr2EOvW+QiarJ9hSlJHedq+IptgwZvSKou8l7NhIev86QQrgbhQUNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=LtRirBrs; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="LtRirBrs"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1789658180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RmUlCX8Jqu1rhSBhVQ90b9ktotpN47dsHDJt9sDAdTE=;
	b=LtRirBrsK6/3TgPp4manmjmL+PHPaD25/9NUg0Kts0RMbsmWZftfO+P650H1ZqMHZ+D6N8
	WeNEiYDx8VyE3e5TpbCdBsIYCnBAM3dw2e6PVn5smozE0OkwrsTlcHgkdQP251rFWpw28J
	GeM/BFFki82zMk4Z4aap1wlPaUuibZE=
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	schwab@suse.de,
	fweimer@redhat.com,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 0/2] fs: honor FOP_UNSIGNED_OFFSET in llseek and positional I/O
Date: Thu, 17 Sep 2026 17:16:12 +0200
Message-ID: <20260917151614.376867-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two generic VFS bugs found while fixing pldd(1) on sparc64, where
userspace is mapped above 2^63 so file positions on /proc/PID/mem have
the top bit set.

FOP_UNSIGNED_OFFSET declares a file's offsets unsigned, and vfs_llseek(),
rw_verify_area() and the mmap path honor it.  Two sets of syscall
wrappers do not:

  1. sys_llseek() takes a negative result from vfs_llseek() for an error
     and returns it truncated to int without filling *result.
  2. pread64/pwrite64/preadv/pwritev reject a negative position before
     looking up the file.

Both patches only change behavior for a file with FOP_UNSIGNED_OFFSET
and a position with the top bit set.  Today that is /proc/PID/mem,
/dev/mem, the sparc ADI driver and the DRM/accel device files; for all
of them lseek() followed by read() at that position already works, so
the wrappers now match it.

Tested on an UltraSPARC T4: pread(), preadv(), pwrite(), pwritev() and
lseek() on /proc/PID/mem at positions above 2^63 return the correct data
and offset; a negative position on a regular file or a pipe still fails
with EINVAL and position 0 on a pipe with ESPIPE, as before; and the
stock pldd(1) works again.  On other architectures the change is a no-op
for every file without FOP_UNSIGNED_OFFSET, and userspace addresses
never set the top bit, so the new paths are only reachable by passing
a bogus position to /proc/PID/mem or /dev/mem, which then fails in the
driver instead of the wrapper.

The glibc side is https://sourceware.org/bugzilla/show_bug.cgi?id=34641;

Stian Halseth (2):
  fs: fix llseek() result for files with unsigned offsets
  fs: allow positional I/O on files with unsigned offsets

 fs/read_write.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

-- 
2.43.0


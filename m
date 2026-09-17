Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAAC4973AE;
	Thu, 17 Sep 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658195; cv=none; b=YXjV0LiFA6ijhdHUGAcQHkMDfM5lHsu/HLJ+FWoPkova/69WO/NURDF/5cc2Bv6MtyEF9uOqHMjQEBpn0OxTC1PB8Dq/ZVjgo3saR804wmBouW0CIyL3uL6S+HJ3nN+felBN2Efc3IKdb6ltmwp9aqZ2L1/sSRvk8WwgQEO6Nek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658195; c=relaxed/simple;
	bh=g5d/ZvnrH1p6X1A9QkzjV8LjMSa0qXCx8idfmxZgFoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOHC59/RCEsQOpIybA+pMSDre6w4aRjAhIw4/P0NJXBCxxgL9GXDudld+G/Ilrcz5Dysh3CVUQvbI6peqDrXdrD2U0+E/yE4TaKJJwQAeF1ohCJETD0olVoQGr35MAlteQcB7W0jnN84I1icoMyYo1/ud2K3SFgVB2F6/JxU29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=VnuuY0Lt; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="VnuuY0Lt"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1789658184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KjXTfCrcBFbMR2l8YsQQ9ormReP0ZwV7qfL01A0yITk=;
	b=VnuuY0LtDlj8M1oiEmg+HBDJy1m/UE53OqoqBZRXIt4bvtMNpW5sQdvGc+cMe5C7jQ8fWy
	PHFgxIRAsTK7fa8Tg2/L1n8TXBe7hbqtfA2DlKIftyzOsK2qmBKI6sSOw1NFbx9w46+QGw
	ZVm0afi9QZixMyUKNQz+l6Qbw/Kp75w=
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	schwab@suse.de,
	fweimer@redhat.com,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 1/2] fs: fix llseek() result for files with unsigned offsets
Date: Thu, 17 Sep 2026 17:16:13 +0200
Message-ID: <20260917151614.376867-2-stian@itx.no>
In-Reply-To: <20260917151614.376867-1-stian@itx.no>
References: <20260917151614.376867-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sys_llseek() treats a negative result from vfs_llseek() as an error and
returns it truncated to int instead of storing it in *result.  For a
file with FOP_UNSIGNED_OFFSET a valid offset can have the top bit set,
so the seek succeeds but userspace gets a bogus return value and an
untouched result buffer.  ksys_lseek() has no such check and returns
the offset as is.

Store the offset when the file has unsigned offsets too, still treating
a value in the errno range as an error so a real failure from
->llseek() is reported.

On sparc64, where userspace is mapped above 2^63 and glibc's lseek()
uses _llseek, this makes lseek() on /proc/PID/mem return the offset it
seeked to instead of its low 32 bits.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e8c14e2..36f3d8e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -441,7 +441,7 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 			whence);
 
 	retval = (int)offset;
-	if (offset >= 0) {
+	if (offset >= 0 || (unsigned_offsets(fd_file(f)) && offset < -MAX_ERRNO)) {
 		retval = -EFAULT;
 		if (!copy_to_user(result, &offset, sizeof(offset)))
 			retval = 0;
-- 
2.43.0


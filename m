Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385E299929
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470781; cv=none; b=Qyct1MismMKuklFVv2JedrnPUOMP91RzQJ6QXDumLy16edIzdei3+GH8PU36lL4yONRSiIQlRyvV6u3vR0yYwgGvrRoxdUktCaBxHXUfZtvyir4OU66Dvmfd3YS4mIE0toLIv0ZOWQi/jcB0E4q4FP0S1N5k2jx3MgrCyXKhcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470781; c=relaxed/simple;
	bh=ZXD5S4tnLxPPecZdyrjAhuWLklLfN8H6/onF9mDq5R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROYQXxjPL8e380JMkYhk9sGAVeY2XpBaLppE30fPrrDZCR3JJWRJixV0nwDpbkEv3uvV5phKdoO0L4ywVO+1QxqJKq3Fs/sJKQv28tba7XAq/vhFPb8RjUVtf/eA01GSWVp8p54R+7k0MXmhGBCnHm+EsRIMRHvmNY5VOcAfv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSesdnOp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSesdnOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E409A1F000FF;
	Sun, 27 Sep 2026 00:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470779;
	bh=q/0HiXb3NWsAl7ojoxd2Pid5O7H0eLvuHIMMESFKuFg=;
	h=From:To:Cc:Subject:Date;
	b=nSesdnOp63k2IXDOtqopm054jda9MKWU6vgPDIccWSwAyjpC6mkdlbGzIsD09NSrM
	 bG9I7JqIoUzcbpwJmt7yvbtSsDH8NSn5wlIJCNwG7TOfAeqo0ILrWaOHKTb/3EHn3A
	 R9pvsQQ7c3/AsRDKdxrvSBhbXwPCrWknw18A3fbm3nfLcG+WJMcFgRjAnMvXYGn8Ti
	 Yc9rRDaHDkeT0xddv3tZJLNCzpKsvv33RVZsxEsaYxkuXavqe7a7WKejOxlCqeAnO4
	 nCsWXD/OSODLzS9vJzwoKOgOQx7xV1TgZNm9myBPlZP1oHUjT14WXFvJAJ7LofTzmF
	 HJKsUnJ3FRmdg==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 0/2] sparc64: CONFIG_COMPAT=n build fix and prompt
Date: Sun, 27 Sep 2026 02:58:35 +0200
Message-ID: <20260927005837.8402-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

852fed2e8bfe turns CONFIG_COMPAT off whenever the kernel is linked
with LLD, and that configuration has never linked - patch 1 fixes it.

Patch 2 gives COMPAT a prompt, keeping the default y, so a kernel that
will only run 64-bit binaries can save about 88 KiB.

Imre Kaloz (2):
  sparc64: fix the build with CONFIG_COMPAT=n
  sparc64: make 32-bit userland support configurable

 arch/sparc/Kconfig              | 8 +++++++-
 arch/sparc/include/asm/unistd.h | 2 ++
 arch/sparc/kernel/syscalls.S    | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)


base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.47.3


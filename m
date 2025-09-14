Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF4257842
	for <sparclinux@vger.kernel.org>; Sun, 14 Sep 2025 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822161; cv=none; b=XKHueGAkB1GU61JEW8ihiq60mFkQwHladj1AUSgrNwQk+l1t4jtRANDFv0lP2W2Nv4/OYVjORhHynrOk50+VXi/BiHCKidpBColByTrkURoxC/HCBE+KfS5ch4Th2j5LMi0JblHmcEx6f8CtxDYJUMjuAnA1qVGF1towZHg71Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822161; c=relaxed/simple;
	bh=n+mmy3PjKTU6Jj1te3ZtONq7xS36QH+38sfXYxmW5ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2RGs/rIpbOepxdDfM3KgV2/+ok/KBTjCS5dqDL6YdyRvCE3D+fa6dkUrjmHMROY2IIsjuGmN9si5y7SE/9rtRphJ/Y8l+6v0v/L+1Aqpg9nJkFfqSNpKoUM9LiOVZf/0qObW34KZnJYX7dSeQR4EyRIq2EQs4IfMOAVG38w/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnx7+S6v; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnx7+S6v"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f1987d44fso903890a12.0
        for <sparclinux@vger.kernel.org>; Sat, 13 Sep 2025 20:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822157; x=1758426957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ7mWaMdZxGJK1wTX4F7lWg1sPAH5qiKx6l6RS6EW/U=;
        b=Vnx7+S6vR5uXvbxbQI6Y2nSi9+hEKUhrI+HwiAIdN707y/+/0p2YE+/GeqFmuX1GRJ
         UmfbavpAMsUNv/JYJb/rHEKQIImz68EFaYQS6v90t97us53l6aJTcciPwYDeAptqB5uE
         KIVroc2zNs2ycQRgXSexOBVTJGNWyP0I7PBdHbRfFW+/H6OrVTg6b6+9tLmEf7kiELSY
         Wh0ffdJCq58eBl69bD7bPJX2rKH96f8FrWO8iO46le5j7Do/KceVIc7/U+x0Jpi9Um1d
         9aLhofIKfXtovdWaTt6eDwUVr+rWqj0/U7p18dRBUBcBFfwoO+WWnrDPTNnaIkPi+hV9
         p0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822157; x=1758426957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ7mWaMdZxGJK1wTX4F7lWg1sPAH5qiKx6l6RS6EW/U=;
        b=HpWb8ZCByYMIQ4g7CtL/z6UGn/aOzB8QREoaTPq1bHLrAAP6VK6F3nQMi7IwB+97T+
         m5UGasXzUYUJJ24SpnsfWARBVNwsdtqdYH/oqEjYg+MjZxMITF0k0Y+n5fgteDOStKj+
         KpTrcgzbtdEY9vkLS5t47OcpaSjYrlbPZRpdsPo7+or67wRmc1V0ul5mXAyNN65XAj8l
         +H5hpXOhvuWW3gfSutFXouJp4AYxroiym1GdErKfIP69pjghm/GZDFX9eoJcQRcZVzJG
         22Ma2/baEgpCqk8C0JjB/GgRp4hc3KSYus9b6/ue2qaHZOqReqB7CkIPvNl9EnEDQtlY
         pbFw==
X-Forwarded-Encrypted: i=1; AJvYcCX/kUH0t+NgoB5MK9I42NR5t9RgKpf+ixYm7DkAtWATAJLva5O6K70qCt2aVo1Y6hPASUjvQlmFt8zV@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvQvmiug8hSrpXeE0heC1TFuOj4/jM/5tEgVL+k9zq5plbTMz
	1GrdBPuTrUilDAbu2hRaqRE0rBejvTsFaFAY351DW4jOd27K0FAMaS5A
X-Gm-Gg: ASbGnct6EbejQ7ZdE5wr/hDbY1XBPY9uamCKzalusHEPdb+Xr+yKIWvC8AQfABdSxfn
	9snxOyKTTbtbImsDD+oiWLjPTA/fCcEOdMSAaKCfJ4Pe/NxHhcihvAmnTYzaCAu77V0WbQsZujW
	FtwUrWm38X5EQJCyqHIqTRRjRdeIkXSty7xq2g/68XbVXQB1SzJDXmgv9JJI1fIRz+3Ck3EIt4v
	i6h4Fod15A2HP8jkH9LRcBFRY2uHFeXFpo51m3R8g973R6XEuBS/8vQhZqtGg5X5jczauv+10CY
	qOk9BhW7hIbcoEvHklYh3mpsRuuvzQsoz+Qqxf69ED8XZcFU3RfZQVrwInj1XUgBw5VuMraacLr
	xWND1SsNElQdl/W5XFh+QDkrnKLTZ3w==
X-Google-Smtp-Source: AGHT+IHVlqrM3WGO2PMhAdJqFymXZDFmcHUFnmRqsIL52zZcyiB7/sntw8UcjJnO5qIuj3xo01B0kw==
X-Received: by 2002:a05:6402:278f:b0:62f:26f8:fea0 with SMTP id 4fb4d7f45d1cf-62f26f91103mr1500285a12.33.1757822156480;
        Sat, 13 Sep 2025 20:55:56 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62f2b2a8c38sm677327a12.31.2025.09.13.20.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:55:55 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 47/62] init: fix typo: virtul => virtual
Date: Sun, 14 Sep 2025 06:55:50 +0300
Message-ID: <20250914035550.3706342-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 8b648b09247a..cf19b7c0c358 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -636,7 +636,7 @@ void __init reserve_initramfs_mem(void)
 	phys_addr_t start;
 	unsigned long size;
 
-	/* Ignore the virtul address computed during device tree parsing */
+	/* Ignore the virtual address computed during device tree parsing */
 	virt_external_initramfs_start = virt_external_initramfs_end = 0;
 
 	if (!phys_external_initramfs_size)
-- 
2.47.2


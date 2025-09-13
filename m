Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E6192D8A
	for <sparclinux@vger.kernel.org>; Sat, 13 Sep 2025 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726244; cv=none; b=fA9Qtci4NiW2orScs4s50YcqAduenxDV37PtUtsX1ebfqUWHDrJ8p5Box5uOPW5wRKTXmCpblWg8mqkCCsaCrwKIqMocOCai6umseCYHSK2GfeDruTxLdPJLES0KFdrWtxfD0wry3/yQiQRQt0i6ZyqOfjTkuMQ8QZf2UdOuNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726244; c=relaxed/simple;
	bh=oyncyjaLrzPFmjkp22Lh+fbFcypfHWy3Ry54UY3bgvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7rlGBcl5uwmThitMBMGYBQDaFxj3O1W87RkwnFjR3JSNtXlee+uy82ysPtifKJFFF6SyMLJRGcEH49SkzfX5YqKNYqyyyXCJLoVjwg7KTCuHhPK5v67kcDQLmRKG4a3hnb4WuU/ioGlxPHzMe9tFlADOTY3gfTKjckrroAq3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv5lVuwm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv5lVuwm"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0787fc3008so355049066b.3
        for <sparclinux@vger.kernel.org>; Fri, 12 Sep 2025 18:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726239; x=1758331039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOKK4KIFki64V1O84ArLWA6Jx4UbLCdmK3IY8vRFz3o=;
        b=Pv5lVuwmVb5A8vNQP8+HTcG/JgQvDNSyP9WS6Bca1yZ7KNsWhFziOeULa55atldY8v
         xj7Ai8Wmr/W6iL+W+mDt0GJS58nDidso1Mc38FmXi35Hf9jI+c0BL/Rd5EpegbsT2FdL
         55imZcS1IHqYhRK8jy8fZXpkI1mp6pAi1A+6/sV3NjUm7xiFGPNuneK/9yErFJuxrGMJ
         NBxBg+gDyDJBszFRnyIWgZwc41qHM5oIWs5Qi1iOybheqkYijpll13+0q/V36vZC06Ef
         hWwsXstOJNXnY9cLrmXFxjFFhB/kqi+EAKFk+lKJWvxdct1z5kmzB2Q1dWF8nVWydKjL
         K9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726239; x=1758331039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOKK4KIFki64V1O84ArLWA6Jx4UbLCdmK3IY8vRFz3o=;
        b=PrKHoqIuQFZIKRdni8oWnDgzex3plLwUy/gBZUfhys/2fHcZ6gDrrKBJM5SfK0+VVO
         zBcvH+vBzqm/aOT3Vvu6hXyRt5Ze+zgSXAr8aQoY82LJQuyMd4gvamwqU6IPy9cPw5u5
         Lw/OoXuqMhgQueQFhDyuJE0O0vyI0NeEcz78OoDhEeCNsMcwjSaKWIeMyHlaqC7kV1qW
         OILVKXhJfAv2IJvlZqeCnceRc4NNtr8igRv4gnBYbtWErgQTDWkvVA3NFFmGYe+ei1H/
         Ky7ht8urLTY4wpQE0spjKI7bKnBup7F6hKzNabGViDIgatCBMhaW29ll9umVp0W4K0zr
         zSzw==
X-Forwarded-Encrypted: i=1; AJvYcCVzw/XuNabQrr+QK64E+eJ2kHy5+/vJd+D2zflWVGEmmlUF9bqRzo+rGVnUvbnrjf+yOJm/grxtCBPZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47bJmhfuPUuRxEBIQor02WzRvCFGghCe8q4ZgZ91fZ5bU0flz
	vo3PulATRRQKFrni3wgfqGPquMykDyYwr39ByvAF1Qv3OZwi9sLASil+
X-Gm-Gg: ASbGncsFa19VC85e7LAxn5zoFtPWsE5EpTnVkqYOjEM5toEdhUcbXQkVWeAdVDnk/A3
	5f8vDwJAY9uWF2NRFhqha5s+J7mz1bgUsfX8UfbemXsZYC6yKrfs0V+c3njGQLtvVcMODLCiQwE
	qMJ7Fopw+2uopoOCqvYgFDvrbfv9RWgf+K1VFvZbmhXVlHNJm5XiXOwep2d0n67OkWfluUXOGuA
	uj3JRCEfJUr2KGLhHcirXqwD62URfeD7lclp+wKz4QNRP0hmwcGPQopdgADFEBoR58dCQZy94VM
	aQdEubpgAxTLDt0owg9tYc7bRR7qe592/zWmuFh8dUbwZixhhAKI0AcCJKyzQPCPXml2S+VJVHa
	JtTKksVFjvE1ijVJvYwY=
X-Google-Smtp-Source: AGHT+IGWcEC7VhNjJKZzReFkWP7F1gkqH4tvvChKQBMnzdm+44287e9kqOEvM9aYYFOmJE4OYY5/Qw==
X-Received: by 2002:a17:906:4788:b0:b04:b435:fc6b with SMTP id a640c23a62f3a-b07c3a79fefmr497358466b.60.1757726238469;
        Fri, 12 Sep 2025 18:17:18 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33ae181sm4478774a12.22.2025.09.12.18.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:17:17 -0700 (PDT)
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
Subject: [PATCH RESEND 34/62] init: inline create_dev into the only caller
Date: Sat, 13 Sep 2025 00:38:13 +0000
Message-ID: <20250913003842.41944-35-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts.c | 5 ++++-
 init/do_mounts.h | 6 ------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5c407ca54063..60ba8a633d32 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -366,7 +366,10 @@ static int __init mount_nodev_root(char *root_device_name)
 #ifdef CONFIG_BLOCK
 static void __init mount_block_root(char *root_device_name)
 {
-	int err = create_dev("/dev/root", ROOT_DEV);
+	int err;
+
+	init_unlink("/dev/root");
+	err = init_mknod("/dev/root", S_IFBLK | 0600, new_encode_dev(ROOT_DEV));
 
 	if (err < 0)
 		pr_emerg("Failed to create /dev/root: %d\n", err);
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6c7a535e71ce..f3df9d697304 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,12 +16,6 @@ void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
-static inline __init int create_dev(char *name, dev_t dev)
-{
-	init_unlink(name);
-	return init_mknod(name, S_IFBLK | 0600, new_encode_dev(dev));
-}
-
 /* Ensure that async file closing finished to prevent spurious errors. */
 static inline void init_flush_fput(void)
 {
-- 
2.47.2


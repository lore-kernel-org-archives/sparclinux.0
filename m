Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2C405F7
	for <sparclinux@vger.kernel.org>; Sat, 13 Sep 2025 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724792; cv=none; b=rzdVl002nZRI7nZk5HLcvhV3cHmG80Kcleh15QZy8xeH0Tlx62UZJaUvaki1ThhHetqs4nEp14+iAWhwVJIPWKhwDubU+O4rPNhlj8HiS2+3tlLC0BOLzoVhQOdZTW8Pf11iUarZ8FRHY48H2808ES/I4OoehTjRUHz3ATW7BBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724792; c=relaxed/simple;
	bh=x5NNVyIF1R5eB/2ANpkfxinDkMZ4lHIXMUphyEE4B54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9UW7n3OvxtWikFUrjrYODmMdXcaWvLaBzoEJgTjoM9zxigEJSW9ZIdUdAeMke5IzXcebEOghF6qi9Z39xE8bxZc+HLBCRsbWJTPLV3k7vrm7bJYx3f8jqDY0e4uCm+7kKtHd7cKVPDCPf//pOwmd3KgRg5kRX4nEtKjlNKg6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGKxaKJJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGKxaKJJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b079c13240eso406062166b.1
        for <sparclinux@vger.kernel.org>; Fri, 12 Sep 2025 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724788; x=1758329588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=;
        b=KGKxaKJJAEmQb6XUp3nRwdDCCxc+u+hiDne6Z/NPf1uixihci6LE3WqQK66IqjXdY4
         Xb/SIK40YfVhek6ziJiApcg4teUqoYD+EUABCY4ZDilpIOpcxVeVt4xnP8Y3hMV830Jd
         BgRCzsXLuAt/64gYNvjWjTt0faQGDNZq5VES2V7LFxosLo+CyBxCqy0cFlgLTUfnd41y
         g5A5xGHGNE2ZrRJQWf4a4OG0sSfOVWqShG7OAgFkdiIQMVcQX7NExVIHdtllyNXyAyPe
         SXalYa6zfu1Jnx/pFPicmNaDPB3e4ynKFhUSu4lO0eWu8UaD73J3NMjlvmNcETXjIJLv
         jaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724788; x=1758329588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=;
        b=HlSbKfp1jkfn9iW3UX2cbGvE+NffaAvCk0HuXcIVhqTICjzmlo/ezzAElzkoR+4PDd
         KiKGPn55yelMHDPew/8Wm9LJkVP5lyOTFPaCWI7N41e82lO82zoJA5qvDf7Cyhu9UfyD
         R9Ge1SbDJoAoujl3jL6v91owbsvlFsYHvkgu8chHtyILrPUsNP2bHnvtAk3qfsV1tmwB
         40eZZuYPxIVHH0N1o1EPRZbNQzKtKu4btxgS7GYDlZhXM1FUg5rw59TBaMw7nGCr2uiS
         V1/jxzcuAP9XATf1LWw6WmcRHUXwRdsiob+uIF44T2qgmYaQ/PXuIAmlFajwKWxcmJ1t
         ucSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbAgRPnzsiVe6/PO5g8nOgFTi6bL1DzQCb957XDdSWNbuP4johaTIhxC8Ac6vwXcDBFXkHO94D8joP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy8onlRGa9X6v9FHXA2Lz8MZtc317JZ1m5ddCMmNBYaGHx3IEo
	AbzOt128IP9K//9Alz1/P+uC6EVnwdPurr0CV1flVGu3ae5JjoWeuvpf
X-Gm-Gg: ASbGncsk05EZwAxVOedCugmuWioEXS2HRebVF9SCYZKyQTGIeWeBrE5HIH3uPjVavZC
	cFUxM6f6S6R18+8Z8ht2Df9M32vlo1mySpN9YUfPpuGP8D9ewLAPfVe3iKMoTda5IeDpHEw9nqq
	anRonDYBOVmgqPmx1aDk3rn3GcHcP/UrPHiIdEhT/Hckg4/5ZnunfxQql2CZke7iojbnRu/7wwO
	bZqTL3e6F58noIuFH88kZIYX1o1sBA+Z1xL3rTilw7xZjazf1fHFLRd7s0pNtAuZfz3E1rjOebD
	0hz69nZqhbR05+/4bC3xNy1msgfU9+tck2mERjsX6A+C/tPD8Slys2ggckLpPZIYJEt6Zx3omHL
	ysyFCOcRR1AKpgVXE+nFUOM49UZ5bWw==
X-Google-Smtp-Source: AGHT+IFLH7pCvIgBYHEI5BCYMw7iR++gatKVbesXKTxSAgJfhChwCe/V59YIUp3mRnJ55soXUGFMnw==
X-Received: by 2002:a17:907:da4:b0:b04:2cc2:e49c with SMTP id a640c23a62f3a-b07c35bbcbbmr535243766b.19.1757724787764;
        Fri, 12 Sep 2025 17:53:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f22e8sm477916866b.87.2025.09.12.17.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:53:07 -0700 (PDT)
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
Subject: [PATCH RESEND 12/62] init: remove /proc/sys/kernel/real-root-dev
Date: Sat, 13 Sep 2025 00:37:51 +0000
Message-ID: <20250913003842.41944-13-safinaskar@gmail.com>
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

It was used for initrd support, which was removed in previous
commits

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ------
 include/uapi/linux/sysctl.h                 |  1 -
 init/do_mounts_initrd.c                     | 20 --------------------
 3 files changed, 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab937d0..cc958c228bc2 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1215,12 +1215,6 @@ that support this feature.
 ==  ===========================================================================
 
 
-real-root-dev
-=============
-
-See Documentation/admin-guide/initrd.rst.
-
-
 reboot-cmd (SPARC only)
 =======================
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 63d1464cb71c..1c7fe0f4dca4 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -92,7 +92,6 @@ enum
 	KERN_DOMAINNAME=8,	/* string: domainname */
 
 	KERN_PANIC=15,		/* int: panic timeout */
-	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index bec1c5d684a3..d5264e9a52e0 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -14,30 +14,10 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
-#ifdef CONFIG_SYSCTL
-static const struct ctl_table kern_do_mounts_initrd_table[] = {
-	{
-		.procname       = "real-root-dev",
-		.data           = &real_root_dev,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-};
-
-static __init int kernel_do_mounts_initrd_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
-	return 0;
-}
-late_initcall(kernel_do_mounts_initrd_sysctls_init);
-#endif /* CONFIG_SYSCTL */
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
-- 
2.47.2


Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C22745C
	for <sparclinux@vger.kernel.org>; Sat, 13 Sep 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725777; cv=none; b=jS6rP+5bmYiIE6BI3gFUXiqSSj+AeigdIxAs/VCx5uhH3eMj5EVcZW0oKnL9rZjGHfsUnuQ6qBBhBRscEopgJvkKEQtHtDmRk9NpnvKSEIrM7IBXjjfzqnujkT4pifengJdyJuCOcDJKnkIbSwQ+m+oV4jr1sCiRhZwCanqYSd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725777; c=relaxed/simple;
	bh=OB8rvKJ/i9Py5pg6KTYPvKorTOVHkmUl23UIALP6A5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3IkuMcnIeGC81+XI0L3eYRWmSWrdtQbdlUKa0b5RCYPM5BHKdko85vatgT6LacGJOkv4Wr/8W5V1+Z6d5cFdhGWV2TXR4CdJNhG7E1J9rvz7Mefr64rQh30A5ht/gCqQC2su/9839mkDeSML3LMWuWT/lQm6IO1/ShaCtPQqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a67LsgU+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a67LsgU+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b02c719a117so429933266b.1
        for <sparclinux@vger.kernel.org>; Fri, 12 Sep 2025 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725772; x=1758330572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=;
        b=a67LsgU+PqFcCyQYOwGfpgZYrvZLskJpWHMhCd23XBdT6GhY2QVzopMLEcTiTwcU8n
         aRXxksx8QL94IAJD0uxOztTCPgTj1BtWsyM/kG+nLV+TpshnC7uUxRKpC9wDTpLGZq94
         ZOqsUlHJQkT2klUn9663/rY9OOFnLqMxlMyaQUlsL96ITKc6UC1tGx3tp/iTsNpX/Gl0
         4qJb49YJJmcWjmVUIQnbNHgh0LOmGNGWxeSBQEvg4fPR2zxEy8hvhLyji2gZG7GN034z
         Lx6bYf49mEL+cge+EW32SYuLX3/YuiiyNTqmZ1EKoxUEqsDHaSGO3qHPWNhLDjtiY01k
         zmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725772; x=1758330572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=;
        b=lvGbvjEC9IkY6ZThMVJEC9woUTsX2FWyzejsYQM5OCkBOcmJdJxHl4Prpluo3quMB7
         CkABH7DkS0tl8fo5krrUvaFJk5B9fN9skES8a3kqyuXIokvNfc/C4Dl8wO5YRJJFVYkq
         EB0xpbS9ZTA6PKH+XOmvnTK9jjc/AlnaST+T0Y8fzL3x7mTBY7Rhhpc8oGi6sMkkhou9
         eDfmUIZG3ASykIBFujOgkRDXFrtb+PNrfCRuk0WI8VzGsz6aHR3aTjggC8/0mc/xqxLO
         uUVYZzLjuF8B8MVqjCsYM1grvnBq2nBYNbMQdqxsNQJWBPdB3xpW21wtMjJS3GLib/ab
         8Fow==
X-Forwarded-Encrypted: i=1; AJvYcCXB1SXT38HkDgB1J5Xvi0qA93BkjwphqArQrCZ9+P3CxcBdwfvxouwpjm24WUuyiWH5vSmaekGNF5UN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3esphDQeIAMV+z9367Rlb9Gxh0vAhznoH0hEOJau9Ir46aGD
	XhaqDN6gIYWolxnqtM0ai3+N+zNEZCQKR7Jlx6UZwohWrrAdG1cjtETx
X-Gm-Gg: ASbGnctOdq0tczr3hYYIRDqEPtDeHklAvYMIUxwrmxm2MRD7rbXUfuqnHtzYpBvi08/
	3R7Jld9V2u4U93qbW5xk19v//fdJ/g00A5SNyDIMmXaFUOo94EspX/5ZA9EEkYKTkgO6IUl2vwg
	/MTJTqv4Mm/Nu6lhEcOEEH4E+oFk5u94vv2qtzCmRSBtiV/KMbeu5rtWnVuu5F9MOcqcehk8qnc
	o5nqZx8unJQEO8BsxHnRLjrOMCvKdEXDzW8mYL9WyJjKxGJ15guGBXr9nOZSVS4EuW8z+7VdBSc
	lKQjw53tTeJARGgIfHBaucO2HK5W1PIlkFUaYYrT6G1/9wa8xyRg6uQnoMAxXbZ8v5ZljSQ76f8
	BIj8r8vRxgUrl6NjD708=
X-Google-Smtp-Source: AGHT+IHrHcZIQpP/M06nOcq3Snl8FXkxUTmgmKKbhKMXWfrO9iWe4P5Ilwjf7ocqvFrLGTk9+k818w==
X-Received: by 2002:a17:907:3d0c:b0:b04:250d:ee7 with SMTP id a640c23a62f3a-b07c37dca1emr487688066b.31.1757725771595;
        Fri, 12 Sep 2025 18:09:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07da7a8918sm104574066b.56.2025.09.12.18.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:09:31 -0700 (PDT)
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
Subject: [PATCH RESEND 27/62] init: alpha: remove "extern unsigned long initrd_start, initrd_end"
Date: Sat, 13 Sep 2025 00:38:06 +0000
Message-ID: <20250913003842.41944-28-safinaskar@gmail.com>
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

These variables already declared in <linux/initrd.h>, which is
included

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/alpha/kernel/core_irongate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 05dc4c1b9074..3411564144ae 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -225,8 +225,6 @@ albacore_init_arch(void)
 	alpha_mv.min_mem_address = pci_mem;
 	if (memtop > pci_mem) {
 #ifdef CONFIG_BLK_DEV_INITRD
-		extern unsigned long initrd_start, initrd_end;
-
 		/* Move the initrd out of the way. */
 		if (initrd_end && __pa(initrd_end) > pci_mem) {
 			unsigned long size;
-- 
2.47.2


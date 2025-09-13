Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38159481DD
	for <sparclinux@vger.kernel.org>; Sat, 13 Sep 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724597; cv=none; b=L/PxDSz4EnvJBwIuYhRKUpWp7WOxVPiq+ZlVaHw8rmeZpZ9UFQlu9XGO5cDvrhgW5IpMfzDXvdTtsFTAqomun+cNVjGYl1JOfgHG2SMl0EfitNxh9SaOSldzEQSzYz7RsZCOQetQG/YlHA/DdKBcCZP4c5QHpwMUtO+PlZavrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724597; c=relaxed/simple;
	bh=aIH0UEBp9jrH7zT+VD2BpCtGu5L0ukANS11y+zY/wiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4yU2/M3qHioc50t9tIE2GCx2mf0cqhAjnszbkfTnPpOE05slyWVfsnZ8LzgXDU+8FwYnpq/zpNPgXLkP4nliIwdKhPjPrkkNpVE5gi4jpQZqGJaxz+JzSh0mhzRC7L9KL9OXCVGgoQLq8PrGhvVoD095m3BT4tHDOX+SenG7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnalPX+q; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnalPX+q"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so4839179a12.2
        for <sparclinux@vger.kernel.org>; Fri, 12 Sep 2025 17:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724592; x=1758329392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6cH8q1TrVQNxjzjuQXybOp7uw+/s7mQTk4MQOvceKM=;
        b=bnalPX+qyvgr51ymiDlUfPxoeZUYWgEFDy0cQeYqymsBCvCezOGrJ3U8Al89pGPiSi
         SSyRFcIuh3aPN7d3nbj3vFvet/FtixGvtToqVpvbhZnl71bJcjH55pysGpeFLsxcJClr
         Bt/m6pOWSQS3nswISqsPVyKXarq9cHQAiqrIJRpMDOcq4sXGJxOcdj37SQNsEzQrAS07
         ojQ1n2EnI2YZzsJI23mG6otl+nP4GjF3XGApnMXBOQzVVuhDymKpXPgfAkD7IJvdXDnj
         ysQ8Cd7j3XqEpnxg98FXaz0YvfYwLiaeShFJBYv68hPUadpXC9ulul209mPf00t/7nOW
         Yx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724592; x=1758329392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6cH8q1TrVQNxjzjuQXybOp7uw+/s7mQTk4MQOvceKM=;
        b=wfBF/1jLEeq//fiuEDCz8aRs+dVbA4S0kNif+ciJHyaTC+g9nQ6nO5r8aPp7dewFPe
         wu3YBOKyC/Bk0Z5uXRG+zJIJ2TnT/26oqIwZpM+O/+IiRaG/8IiHhxbmx23vVnVX9QkU
         KXwst+F12odj5zCUBDNEVM9X/xae2FGGfrEbsAcwmOZQV2gU8i+odBdpxn8b3Dla/CPH
         C1FgVoAF2q87A/kZvB5w3vysajPa9z71K+Rbw78bWyLOm85OrwF5vQJWw8IVOItHRAWY
         JMzFJzMtxC7lUIdZLhREkl0jQplfEPSd0EzZ9t+qJtza5/T2Ue1Bhpnxehu3UNNSWQR/
         grgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs/C934/hgl6xOs/AXZ042oHJDSiV9tcJUfhytnXKsSJCDR2z966PKpfW4+kbkenAjbSoewEkaGEbP@vger.kernel.org
X-Gm-Message-State: AOJu0YycgDxfRbgkUYP71RYOSlyc2yvwHK1PMEhmXgp7Ui9lGSXXJMY0
	nQ63w4xXMwGfckP/mGJAJ+HMAJUHdyiP6AH6xPzi8uLBW1wiPEjv6h0/
X-Gm-Gg: ASbGncsjiSjYOdfwccH1lHF3eyzdiVOe0JvfgvsLAuUvyaCrMqkjTiRYGbH9vmnyZZB
	kK0foievpiyn72vCAd9KlSnhcBnXJtJQ+mJK2EpS7kwKmMdWx8wrQ5/zhdGgabkYttxD6FvrJju
	7YaxL5Fd+LnNA567hV40GIrAJJsIAEQooJWze+g8jZyKuJC37JhlrydNqGQhKfFbOmvVQTrZzce
	ZF1a9jaC94mOZkQT0uXK5Wtt4dIWOCrEmBoY3wSZiSKfjw8vvI81vbNo8RQk6/Wzg+GFDBoHVCI
	85rdLp4ZWdpgkTI1MKySdZErdyEZkyDJBIqr6xoRj+OJe3D+hk7qOKsZxMbkOwGm1rJmHHLTSwc
	o7MHBoJg8+CgcqKZweTUs/FHl7oURaQ==
X-Google-Smtp-Source: AGHT+IFuaD6uE53o0kMUFqkBYFUIpIv4YZNYfnndGaXs7B0K4+B96SRU2dTVgEWhisS3xuLKgCtRtQ==
X-Received: by 2002:a05:6402:4316:b0:62e:df3b:79a6 with SMTP id 4fb4d7f45d1cf-62edf3b81cemr3814693a12.1.1757724591635;
        Fri, 12 Sep 2025 17:49:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3b6csm4149162a12.32.2025.09.12.17.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:49:51 -0700 (PDT)
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
Subject: [PATCH RESEND 09/62] arm: init: document rd_start (in param_struct) as obsolete
Date: Sat, 13 Sep 2025 00:37:48 +0000
Message-ID: <20250913003842.41944-10-safinaskar@gmail.com>
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

It is unused now

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/arch/arm/setup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
index be77d4b2aac1..01257f30d489 100644
--- a/Documentation/arch/arm/setup.rst
+++ b/Documentation/arch/arm/setup.rst
@@ -86,7 +86,7 @@ below:
    initial ramdisk.
 
  rd_start
-   Start address in sectors of the ramdisk image on a floppy disk.
+   This is now obsolete, and should not be used.
 
  system_rev
    system revision number.
-- 
2.47.2


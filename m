Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBC15E5D4
	for <sparclinux@vger.kernel.org>; Sat, 13 Sep 2025 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725579; cv=none; b=B3KbsnPqKn0Lct/XFrvViV+cRIsCG0m4nnEXWwS+Px+o8WbtuTZvPFSVPtWoeD3ZxBTQ3FliELc21kjL5KNqHB5aZ88Zj2NSEh5o8wpgcan/WWp2DPDUmJctOitnWjTenafHqrzbU3GIRO00/8pFuLwIlvsS+RM1qjLVs3qyEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725579; c=relaxed/simple;
	bh=vklOel+wSCjK4qNA3bbVH6akiUZ5v6h3w1mLbg32yHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTEYZcmk5PUkOiNm/+Gr/Q+j4NqNLrYFfH1dgrkXozESnme18WSQMwxBWZPp9KOuqzSqtiTRBk/FhJeLYPFZ5e1sBO1RjNeoNQdT0HmpsU/tc2/K9QvbRAi8ZuPCOiNi7mBLcVTqlp1nrR4DY1BXEFgvTPlDbk9WbCbPELkBUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5jdjkTj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5jdjkTj"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62ed3e929d1so3247462a12.3
        for <sparclinux@vger.kernel.org>; Fri, 12 Sep 2025 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725575; x=1758330375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=;
        b=i5jdjkTjtptnVRTKu9gC1FGyG631gNTKOQcNNjiV1wIGpCO9LKpi2CJ2RQ0m8t4mDH
         ONVWomxhe69fjxeYMmICCmXv0Rr8TDz7s6BVZICN9NwGb1N7pNZmRqZGBcz40knM2HMI
         W7Ji8wqwO1cw0T53Aky2TLdNt7Ux9WDivWO8koeL4yJfRdO+vqooDEJ5hMj2vZ6iRCxO
         FLSx379lFdhQ1bMH9wAjwlrmjDNUBqy5D7r979gfnOOIkIHRqh07UgA4qY+vpqOY4JKM
         u+gd3SquikxVivxA1PhfxTy/48fwXe+t0GbKjBfMbOX3kk2O1YHm9m0ES0HTMJbOYUaG
         GRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725575; x=1758330375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=;
        b=YBA+1RHcs33jQJtv+wNfBDCpb0yqG9WrflTYXtI31fRpsVJzzVkBrdDtMLPsipdTJn
         Ieo0URJNLd/lBWLnHpCKe9AvCgvApx4xsQzLeHh4f+QDwwVqRt1dkYqUOQpj/13zu5FN
         +0hwjAXYk8/ot1XAMy/Z8FuqE36tvM/WI9jShTl48dzUlh8yTaTksi62XxuBATZ9vJFp
         rMY3GpOt38PpR3D02IvBwLrVidH0AZ2fcfRkmuOghf12Yjkx23x4HuL1wc9p66wOOzvJ
         rqr3vypBvYQkFXZHzCuYoeHX/1wp6CDwdZQz5M86ybgyGcBb812R5VXW5Ljk84NNYFNM
         Zqtg==
X-Forwarded-Encrypted: i=1; AJvYcCXcDRr9yWoqaQPYAD7r7BGwY+LJEts85JTSlZxGqvfS1tLzZAzk+PZFJVGvgU43SdOarQBtqH3MthaZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcwk5xMaxBJELTF6nQ4TwjLeMoxAXep6ixDO+SK54YiK7aoO/W
	ZvAinp+2OOkjK8mlx0wGRm42fcI39bp/RZGzBGce6yu3x+fKUfKurOzZ
X-Gm-Gg: ASbGnctepp+XN7tDgbUWhI1tdS8Pss3yZFrX+y9QauGpe9uLL1XNYOPYo6UXOwE+T6X
	jJ66DnwJ5f+lFk740Cux1GfvYa+x3YB4ERfkDxTCNgwcll9KQ/0g6KUaTRONVNDQk+ZLOYXVjRt
	xS8wUnXNnnNA47DYCegL9+XIuEbOCW61VOAb2VdctQo+x8HwbGpwFPPwLQVTAiO33D1/008DRc2
	B0RXGyXUZiTGNjaCdcDbTgKVTnQpeW0H8tRkQu3rSyVl6f83c0a3ljG3KhUI46WKwYskiRMzsbM
	oGUnUtKy9OcAEl+1t1JToxLjvivqXd8GRHnyb+5v2vkghCt8FkCxLzkGdbw+tXi5RXeSeLA+/nd
	QEQVzMDE/HlE1B13gi8S9PyFai/bDlw==
X-Google-Smtp-Source: AGHT+IFUls6LXsrCLze7uCxm9gIrKR+0qjIy+VauG9zkpfPwn7RwHzjJtZF9/Fq3L/RMfRZn925KxQ==
X-Received: by 2002:a17:907:c09:b0:b04:35c3:40b3 with SMTP id a640c23a62f3a-b07c384b024mr492655366b.15.1757725574734;
        Fri, 12 Sep 2025 18:06:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07d9e18c24sm112553466b.61.2025.09.12.18.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:06:14 -0700 (PDT)
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
Subject: [PATCH RESEND 24/62] init: remove wrong comment
Date: Sat, 13 Sep 2025 00:38:03 +0000
Message-ID: <20250913003842.41944-25-safinaskar@gmail.com>
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

This comment is wrong. free_initrd_mem may be called
with crashk_end and initrd_end as arguments

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 include/linux/initrd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index e49c7166dbb3..4080ba82d4c9 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -6,7 +6,6 @@
 /* 1 if it is not an error if initrd_start < memory_start */
 extern int initrd_below_start_ok;
 
-/* free_initrd_mem always gets called with the next two as arguments.. */
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
-- 
2.47.2


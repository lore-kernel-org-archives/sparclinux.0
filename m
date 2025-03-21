Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE4230BD5
	for <sparclinux@vger.kernel.org>; Fri, 21 Mar 2025 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586567; cv=none; b=Jdkk8PYeL14eeZGu95F4TyUzl7ENRD+RcuqPFsoAFFUAAYiOiCpB65XX8XrXZICLhc1qIjcQMUPecgVsxawem+CWC7LoZEm2QM7W12YNIpVn6WtSQ8aW+1U9PRRU9CcUrwDkeDyO01Bclep7xfNf+VemukYsYV7Sv2N6+jt1ioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586567; c=relaxed/simple;
	bh=U65D6SohAEKFKir81pK5H51AE5x6/jUW8l5jaJk9nGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+KB+Hr2Yeb88vUu2irT2UMraJEzzhQmpbbnixA8PkRq2ny3IBvlD1IYDqhAntabwhubNDzftINpljjInoyEA+vbOAyV9jS5lKBBJ5fLpjIgCxk7EGk+b5In97oJUiZb3M3SqDh3uTzjfRrL84NDFzW1f7ypuWmr9S+1yJwTgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoVSmLWx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoVSmLWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742586562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+CKY6hYnggEy5gDUo8IBcPB4aoVwWaaXqwhjqRQh5c=;
	b=AoVSmLWx5YwJPEtLVi1Z6cNl8Jc31u1ef/LKGwe8yfwooSvSDGvrrvPoQ6wu3w1+HZU0Qy
	y+YXTLPqu/ezYvYpytSKqXsT8DuC6fguSzCSQdjLb84vXphbZpLuZYQR+/3sojd2lQ1wKz
	mMHgRmzcqVdO5xykTVNvjbQFrN0Ey54=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-fsoT5kYGNxKvbesCJ9P7jw-1; Fri, 21 Mar 2025 15:49:17 -0400
X-MC-Unique: fsoT5kYGNxKvbesCJ9P7jw-1
X-Mimecast-MFC-AGG-ID: fsoT5kYGNxKvbesCJ9P7jw_1742586556
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so275791966b.2
        for <sparclinux@vger.kernel.org>; Fri, 21 Mar 2025 12:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586556; x=1743191356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+CKY6hYnggEy5gDUo8IBcPB4aoVwWaaXqwhjqRQh5c=;
        b=LJ+h0YzUEf3SOWRFR2Cg1O3QCMj1OeFVDRArqjTDtt1u1kiJtqsPXi2nuNcUr4r7Eo
         8S+G1tg5w3FsLR9LfNTAt0uCj81bqXebaqL7fSDikHLhpSKBy5vR+TS9Vx37AEEjxA2S
         MJb4V9plJIBt2U3AQyjF3tm9rjCpr+VTPiJzcL8SJ1Ewc9ZZEDa/w+lY/xwzs0WDp90M
         yrdnVKhf74M8w+vJFd4V7LZ8nMZ5eKwFbSIIrRUKf8XCCqDfPGL+fJIcWYc074EMqgln
         cuTicwEkODQcK0LeGqXFy8CKrl+zEKL/qtrEDzmPAY641XAgydlg8LMYabXNbpSVuswt
         Y71Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjqnsirbYnIwnjwxmlliMj0p6yZNV+QVWWOSF+divCt7P5u9jzuHQ2BlLf2gK0bks8mRCsFRlJDrC9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkaba/uGP8JExwPDByulrpa3EPQNVTFrTkWuQ8rzIdzGK121Lb
	KWQoX3dYX7EoeQAK/WzjQ5Q/GAzq+7Bc28vijY/rM3TwCFZtz3k/XWjmf3seuFEHhYMPwIuPqd1
	7b/qeTwX245/+Q8ARjt5zf8Jvoz0mEP7+6fDr9bd9aiDifNP4rBW3kcMwhw==
X-Gm-Gg: ASbGncs2l92lwS3E2fXJHiBmJd5105ZapgwU9iGcX6hIrsx1vINKqDFwUdS5lIEb2Ff
	CCMVjjehbIuNzGJxC9q/TFr2YewACbtW812c9mU8Z10QyEjHJyQUxOiQCXxwuugDEt1MSnL1sw2
	aFkusN72lOxuPBogEa/Cs6LR2fhbap9lFIgBDeCLcXkK+XUpdCNxdVfPi5we8PQA9oj7qZKoz5j
	Tg7fDuIMmjQVASnzLhfGmR1tlvJtztvYpXbRefcTycgwY/oK4I9t2vHldLA2YGJ4QSVlcUeXaxF
	/6Tkrnwj9ou2sDOd87VJMGvSGA6FFSIoIQTQ3J/R/A==
X-Received: by 2002:a17:907:9482:b0:ac2:13f:338b with SMTP id a640c23a62f3a-ac3f2537a13mr417245766b.55.1742586555818;
        Fri, 21 Mar 2025 12:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE364/oBuyn+cE4ig5ONss+vPjSo5TWTy9RSOBlsLCFEbZLg0sVEvc8UiI6SNuN3e2vwFGwrA==
X-Received: by 2002:a17:907:9482:b0:ac2:13f:338b with SMTP id a640c23a62f3a-ac3f2537a13mr417237066b.55.1742586555219;
        Fri, 21 Mar 2025 12:49:15 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3d38sm204412266b.39.2025.03.21.12.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:49:13 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 21 Mar 2025 20:48:41 +0100
Subject: [PATCH v4 2/3] fs: split fileattr/fsxattr converters into helpers
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-xattrat-syscall-v4-2-3e82e6fb3264@kernel.org>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
In-Reply-To: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3102; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=U65D6SohAEKFKir81pK5H51AE5x6/jUW8l5jaJk9nGM=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0u8e2nhsqffE2qNHBdc56kpaBv10/G5zKMBMNU5Y1
 7+08cOt3t6OUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAF7Fl+MO39MOayUtjz0Xc
 Zf+S85RBZMPrQyk/IssaWQR3V917GlLI8D93Rvvtmb0TdxnrLdm5326CcYQxW4JKaaBU3XVFNfO
 V51kB1DlIeQ==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

This will be helpful for get/setfsxattrat syscalls to convert
between fileattr and fsxattr.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/ioctl.c               | 32 +++++++++++++++++++++-----------
 include/linux/fileattr.h |  2 ++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4434c97bc5dff5a3e8635e28745cd99404ff353e..840283d8c406623d8d26790f89b62ebcbd39e2de 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -538,6 +538,16 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
 
+void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
+{
+	memset(fsx, 0, sizeof(struct fsxattr));
+	fsx->fsx_xflags = fa->fsx_xflags;
+	fsx->fsx_extsize = fa->fsx_extsize;
+	fsx->fsx_nextents = fa->fsx_nextents;
+	fsx->fsx_projid = fa->fsx_projid;
+	fsx->fsx_cowextsize = fa->fsx_cowextsize;
+}
+
 /**
  * copy_fsxattr_to_user - copy fsxattr to userspace.
  * @fa:		fileattr pointer
@@ -549,12 +559,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
 
-	memset(&xfa, 0, sizeof(xfa));
-	xfa.fsx_xflags = fa->fsx_xflags;
-	xfa.fsx_extsize = fa->fsx_extsize;
-	xfa.fsx_nextents = fa->fsx_nextents;
-	xfa.fsx_projid = fa->fsx_projid;
-	xfa.fsx_cowextsize = fa->fsx_cowextsize;
+	fileattr_to_fsxattr(fa, &xfa);
 
 	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
 		return -EFAULT;
@@ -563,6 +568,15 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
+void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
+{
+	fileattr_fill_xflags(fa, fsx->fsx_xflags);
+	fa->fsx_extsize = fsx->fsx_extsize;
+	fa->fsx_nextents = fsx->fsx_nextents;
+	fa->fsx_projid = fsx->fsx_projid;
+	fa->fsx_cowextsize = fsx->fsx_cowextsize;
+}
+
 static int copy_fsxattr_from_user(struct fileattr *fa,
 				  struct fsxattr __user *ufa)
 {
@@ -571,11 +585,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
-	fa->fsx_extsize = xfa.fsx_extsize;
-	fa->fsx_nextents = xfa.fsx_nextents;
-	fa->fsx_projid = xfa.fsx_projid;
-	fa->fsx_cowextsize = xfa.fsx_cowextsize;
+	fsxattr_to_fileattr(&xfa, fa);
 
 	return 0;
 }
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 47c05a9851d0600964b644c9c7218faacfd865f8..31888fa2edf10050be134f587299256088344365 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -33,7 +33,9 @@ struct fileattr {
 	bool	fsx_valid:1;
 };
 
+void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx);
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
+void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
 
 void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
 void fileattr_fill_flags(struct fileattr *fa, u32 flags);

-- 
2.47.2


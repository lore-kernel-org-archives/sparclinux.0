Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA0295522
	for <sparclinux@vger.kernel.org>; Mon, 12 May 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055973; cv=none; b=V4LMpY1Fbg0i7+pnvKQSSYYB+1hp3LbrlgeGTw23GKFu/Ef8mncRLIS1qkTSlSymsJNi+uvXQCqkNMyBKi1zLUNz34N9m8xzp8kT3TE8UXvIdgbjD61ZPxl9qDaWlVjinXwf3ao0micMB6i/pOBbYGBPLkV+xspv1MGV15KH59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055973; c=relaxed/simple;
	bh=9gJF743RWK+bJ6m7oQyctUYpmbwhq5qenEdMjKDH0Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFTeQytO/p4POtdRwSbhvNlYbeeMLoFnzxR02nL7+I9amuRyMLMDLMlpA6kgX0J7lQBL2TH7YO2korb4y31C1KqCX4tERcrqXUt1Cx8wxZ1YXHmfVeQE9koPuSxJCL2PFHlN8GKbzN2/v1qMCckSwe3L/HuSlTPjYs730O8zC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNsQv9bn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNsQv9bn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747055967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLzO0UetENOl7ymbAc9ZwNTqK+089tCghqZXKpGiOB4=;
	b=QNsQv9bnQ1GKbWM/G0UBFcPZiar86cGmsoMSilStBrahBIidbV/53UZcL2f5SNR+8WCmEk
	5m8ehGx6b8K74MGLhjRWFdoUj7YmJIqoqxICffKzfc0M5ytjMCs/2vLZWvffVnyEqqfLtK
	oNarGLhz0PesaghyqAhO5vg3Us5X9TI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-KhfmP0heO_Cg_cLCZk7icg-1; Mon, 12 May 2025 09:19:26 -0400
X-MC-Unique: KhfmP0heO_Cg_cLCZk7icg-1
X-Mimecast-MFC-AGG-ID: KhfmP0heO_Cg_cLCZk7icg_1747055965
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acf00f500d2so329318966b.2
        for <sparclinux@vger.kernel.org>; Mon, 12 May 2025 06:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055965; x=1747660765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLzO0UetENOl7ymbAc9ZwNTqK+089tCghqZXKpGiOB4=;
        b=UYcdL96VbPJoSgffqkFz+3krbYLusQmhK5rygVCM9FI92ygDWwEeDzWm1GwCDMRdhr
         iFQPa+t2I30O1lj7p1dvJ52t+qwOzjXTcHDIphfPT8i/M6lI4IgQBa49pUISNdAmMruN
         1t6MLINQdeNZpLOX14qujh6tjkIhfflb31x8Gm1Q8UShZN6QibJWC7DIexEuluO/arCn
         Aqw0rCSRXMl55L59sSJ2LEV7WC80wImounoM6pGLoIAFzizM1HtmLkSjD05p4k+Jn8iY
         RnTxyIGAioN/P2G1zisTxifsuIVIWETTLML8FvsN+76Oe9LFTQOXlSxkAcICGQ81IKDv
         8ptg==
X-Forwarded-Encrypted: i=1; AJvYcCWmMccdxAXWuNUl1E+5Q08HDYyMCpmt6lhIEbpxa0YoKSjxl4zwz0BwKWtjGy+Lq8Ek69gYIYcBYxwl@vger.kernel.org
X-Gm-Message-State: AOJu0YzTAofEm825wm0bWrCayKUQ7YcVPdqb+WLg5xck4tpka/gqhoPr
	r4PFK8iCxAxpVeZe0+rLT2v0QvOsitPkW8O4QqKO6+PSKmd4dc8y1se46eQghHrGg8RI2g3RO3p
	9btdSb7Htht4kymnO9/e5gQ/mMaRxiZEO7qALF8XIClIJRG19ST02Uht7cg==
X-Gm-Gg: ASbGncuctUdtEULWtsasnOOdvrpOaIydPZkEygIBWCU6GJflxzKi8/DwdwWaYy9VP5d
	UQwWRYEMotsfGpk1iiz5FiLzjFivXcWASZMwF8QrbHNqG4J6OY+yx50+27XMtCUSvttvt/8K7cm
	zidzYAk/HDsuELf8vO3h3km7J47llaabe0BJhDmKJ5pqn0dDzJ2wr8Mk9t+s3POC132PbbXwS7r
	BBgolBHOql5B1/nTTVPb9WQ2Ez17ogZtgyG/VseOXfNj454Vajmf5U8vbcsRJBkQxy7sSWN7oz9
	DfUFQJzdHz0Txd6es78tAdjLN/0=
X-Received: by 2002:a17:907:8b99:b0:ad2:2d6e:4962 with SMTP id a640c23a62f3a-ad22d6e52c2mr855521666b.42.1747055965119;
        Mon, 12 May 2025 06:19:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa3ZpYdTF3qd17gWEoRTHMnv+pL5522+Z5nSX7r6uDpni86IH6A8IHgBLuulX9yc13mwfyKQ==
X-Received: by 2002:a17:907:8b99:b0:ad2:2d6e:4962 with SMTP id a640c23a62f3a-ad22d6e52c2mr855517166b.42.1747055964687;
        Mon, 12 May 2025 06:19:24 -0700 (PDT)
Received: from [127.0.0.1] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bde09sm612328766b.125.2025.05.12.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:19:24 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 May 2025 15:18:56 +0200
Subject: [PATCH v5 3/7] selinux: implement inode_file_[g|s]etattr hooks
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-xattrat-syscall-v5-3-a88b20e37aae@kernel.org>
References: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
In-Reply-To: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
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
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=9gJF743RWK+bJ6m7oQyctUYpmbwhq5qenEdMjKDH0Lc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMhS/+h/6tvS4ypammLpAoYZzNSvmXjrOE5DOrL33V
 8CXj52HDmR0lLIwiHExyIopsqyT1pqaVCSVf8SgRh5mDisTyBAGLk4BmMjE64wMK86tctk6J8PH
 5NWsT9K3ktK/ublm/c3lZ8k/wnjIVFi0kZHh8PaZrp7Ld+k+Z2N7UH7CtdSLJcq5zkrlWQO7dK2
 M72wWABsnReQ=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

These hooks are called on inode extended attribute retrieval/change.

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 security/selinux/hooks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7a7dcab81db..9c6e264b090f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3366,6 +3366,18 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 	return -EACCES;
 }
 
+static int selinux_inode_file_setattr(struct dentry *dentry,
+				      struct fileattr *fa)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
+static int selinux_inode_file_getattr(struct dentry *dentry,
+				      struct fileattr *fa)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
+}
+
 static int selinux_path_notify(const struct path *path, u64 mask,
 						unsigned int obj_type)
 {
@@ -7272,6 +7284,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
 	LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
 	LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
+	LSM_HOOK_INIT(inode_file_getattr, selinux_inode_file_getattr),
+	LSM_HOOK_INIT(inode_file_setattr, selinux_inode_file_setattr),
 	LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),
 	LSM_HOOK_INIT(inode_get_acl, selinux_inode_get_acl),
 	LSM_HOOK_INIT(inode_remove_acl, selinux_inode_remove_acl),

-- 
2.47.2


Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DA1AE005
	for <sparclinux@vger.kernel.org>; Sat,  2 Nov 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569891; cv=none; b=U2mo1M8kUyLR3hAtD0EZsBdXZTyCXQocbZaMVypDToXpmBpTGGFGZHfTb6NUYsQ96XE6IJ02qq8BT4yqmA2tHE2+7PRWXp7KVtUic0BjVxPt+2/LU6EGRL/0Y+hJwQRnfGs1cjB/BohK56QD2809EpjHA0ZKW8407zGX2WLRDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569891; c=relaxed/simple;
	bh=tYeWMfxSx4vH4s+I4R38mJYh2p1UfaeTY/BCD1eWxkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5FtVFRW6vxj4t1OZg2hBWg+R85+Z6HbJKVPwcRBZ7mvC1OY8iz2mCa2DZRCSSjyEG4F+KcH2DJTUrJb/CLsNszYzqMYzSEpGBdO3Ld5080q8opZGVyptRk/vmVQrmkZVRoyklS6BPWreYhT6Mi3ihsLZ7sUh+41ynGqf/mnA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHwEZtCo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHwEZtCo"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so42002187b3.1
        for <sparclinux@vger.kernel.org>; Sat, 02 Nov 2024 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730569888; x=1731174688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdWo63oS/3PygmFUI3nbDvYOqCsDTsjYHv+g+IznqpU=;
        b=kHwEZtCoMIDCAe0fgDU+Xuaq2nh5BXHB0TvjjBi8xT8glKzHDYuLGjov6OD3tj7E1k
         r4OZkzC+N+yD9lHjCBQzwrBjdFITK0VK7VS5ulAOlXaXFjDwCxbsq5iB7MfyIIargRq4
         JIUIDS/IfXKxA9yPZ6Md1/DulUiMTJYxold39DRBjm7RqB8mIs8S0ufipUfsWLu/srPv
         ykwDtcC9ybon5LNYcNWY1u1yHXl02W0ueHSb2CvbTaexzaXfF6C9PZpKVB1bCDelJHxa
         jrBXdEXGEBYH4azqdITTwsYKtni/9rBOLDcBQDBgh1BEFSjiMZAxZqGfLm0jrjhIeAoG
         tZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730569888; x=1731174688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdWo63oS/3PygmFUI3nbDvYOqCsDTsjYHv+g+IznqpU=;
        b=Ia/80mY/CiZ+Movtv4SXPYFUr52nYUaUGDY6+1JuogG3V1UI4NDNK3BwUslNPSRARh
         w+sL7TkW82Sj8q5rHnSO+WVzdqhcMCu+SjU40V0O5ibsI6vUnS9llcjRMEwRaZKQBi8A
         m1Irurx6AFl/b+vSB6Ikb4PK3UfuqxCq3+G8IVhfCZ7ujjGmTOjRbKDjPIrUiuXPgVuv
         kdKoQ+dmVRbBIplx+Z+t8LUlyhxqP0iWQS3Q3GApr7+zY669jtAOMCghAjH6zc927UQY
         rU9gfG6+tvR7+I9Zx4WIbsJ+rATgY3fG/J2tsaQ6weIuRuG0qtueTF9917GtuaWUDm6E
         mPDg==
X-Forwarded-Encrypted: i=1; AJvYcCUIhWGVvMQwq2T4JbdPl0RTm7D+K3fCUuWsyZmJj29f/3jaMslNPk8Drvk7k/nWV0tlFlUCmei+rZrq@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHeMHJzbjKTNkEkwtjZXDH/axEMaU45BK7rAKZwNDZHmvD5I6
	DjHfmV4dzb9uTZTMrW0NYWjmjyrQMRlN56OgKd0k4hldHZJ6y6gPBSJmLggH6OxTeQ==
X-Google-Smtp-Source: AGHT+IH7LQgBzA2tMJPZhpergfNVuUy9qcXS3+8LW4j/tM/hz8d/Un776Cs1P3DAetNpOXBX+ju9Fw8=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a05:690c:200f:b0:6e2:ac0a:8982 with SMTP id
 00721157ae682-6ea6413e043mr907067b3.0.1730569888405; Sat, 02 Nov 2024
 10:51:28 -0700 (PDT)
Date: Sat,  2 Nov 2024 10:51:13 -0700
In-Reply-To: <20241102175115.1769468-1-xur@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241102175115.1769468-7-xur@google.com>
Subject: [PATCH v7 6/7] AutoFDO: Enable machine function split optimization
 for AutoFDO
From: Rong Xu <xur@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Rong Xu <xur@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Enable the machine function split optimization for AutoFDO in Clang.

Machine function split (MFS) is a pass in the Clang compiler that
splits a function into hot and cold parts. The linker groups all
cold blocks across functions together. This decreases hot code
fragmentation and improves iCache and iTLB utilization.

MFS requires a profile so this is enabled only for the AutoFDO builds.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
Tested-by: Yonghong Song <yonghong.song@linux.dev>
Tested-by: Yabin Cui <yabinc@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 7 ++++++-
 scripts/Makefile.autofdo          | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bd64fdedabd2f..8a0bb3946cf05 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -556,6 +556,11 @@ defined(CONFIG_AUTOFDO_CLANG)
 		__cpuidle_text_end = .;					\
 		__noinstr_text_end = .;
 
+#define TEXT_SPLIT							\
+		__split_text_start = .;					\
+		*(.text.split .text.split.[0-9a-zA-Z_]*)		\
+		__split_text_end = .;
+
 #define TEXT_UNLIKELY							\
 		__unlikely_text_start = .;				\
 		*(.text.unlikely .text.unlikely.*)			\
@@ -582,6 +587,7 @@ defined(CONFIG_AUTOFDO_CLANG)
 		ALIGN_FUNCTION();					\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
+		TEXT_SPLIT						\
 		TEXT_UNLIKELY						\
 		. = ALIGN(PAGE_SIZE);					\
 		TEXT_HOT						\
@@ -589,7 +595,6 @@ defined(CONFIG_AUTOFDO_CLANG)
 		NOINSTR_TEXT						\
 		*(.ref.text)
 
-
 /* sched.text is aling to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 6155d6fc4ca7f..1caf2457e585c 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -10,6 +10,7 @@ endif
 
 ifdef CLANG_AUTOFDO_PROFILE
   CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
+  CFLAGS_AUTOFDO_CLANG += -fsplit-machine-functions
 endif
 
 ifdef CONFIG_LTO_CLANG_THIN
@@ -17,6 +18,7 @@ ifdef CONFIG_LTO_CLANG_THIN
     KBUILD_LDFLAGS += --lto-sample-profile=$(CLANG_AUTOFDO_PROFILE)
   endif
   KBUILD_LDFLAGS += --mllvm=-enable-fs-discriminator=true --mllvm=-improved-fs-discriminator=true -plugin-opt=thinlto
+  KBUILD_LDFLAGS += -plugin-opt=-split-machine-functions
 endif
 
 export CFLAGS_AUTOFDO_CLANG
-- 
2.47.0.163.g1226f6d8fa-goog


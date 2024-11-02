Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD791AC448
	for <sparclinux@vger.kernel.org>; Sat,  2 Nov 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569889; cv=none; b=ACczz9x1kByM2iJ2xANVHeh42+jAmpGNvmeg23IZVukFCn+CfaaoZMDj2sP9EsOkv31zYm7+cZ7iKDOi0RbxU/J/4YPt091q024nGe/w7ms2zfkaXZQZhkFAzX5fo62gbE1PWfbeO8lqNk18BVvtGMeUxtplp+I55CcTn5mEQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569889; c=relaxed/simple;
	bh=JvxcRd6YmtrCl+GZCGplZl/ZNrWqWevvQT1yH4/zYYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ts/kpCylv1px92LGRcbqVOEs56o7a7DpRzMrS2o+6VPeJngYCvttMb+XBQ8+32ysZ2cdQBKOeZV0nPmu8Ua89Xr3xinVNym889quZbo16Lpx7R/B4/C+Id/0KePSh+os+Kj2H4IN0wHpZx+hbEHGiOD9uNv8Taz0R9U9QDTH5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZmJnN9G; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZmJnN9G"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30c7a7ca60so4247844276.0
        for <sparclinux@vger.kernel.org>; Sat, 02 Nov 2024 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730569885; x=1731174685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aocsS2GBm0tKtUkt4oMs70MBTwqe0y0WT7ej9bCD6/M=;
        b=mZmJnN9GGA30xBmN35vC76m/MU+qH8wbwBTf16NQnIRUd42SPz9QMvKKv6gxvOTLAb
         94coG8a68BAC1//deCbT6PpB45NU25pE3e7spZqyVUjsLuPv+jiSLgzctzipxAhMK2lz
         8z5hyDov2Ma8LwD7QPmzt56vBa1LeKaDl93ee0RNZu2TF8ABYDUDVIHNvK0a6GXBFhxb
         oCZV/3xqh7f0Q3NT4EUWjHjO0BlXdw5K62IhxTzVTfvO5DvO55BEdpH0OxH+Pny/8vsY
         eBsWC6tmE4qoH+qSaug/e0YwM/L/BkQLIO+hgL8vmyS+aGX20syHaA0pjHExZb7WjdWe
         pCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730569885; x=1731174685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aocsS2GBm0tKtUkt4oMs70MBTwqe0y0WT7ej9bCD6/M=;
        b=je+IUZKfQ42f4YqbHP/6jGtE4fDOAVeYZYKVvwBDpYQavFsvC+Tnp99dvcX0wbINuF
         WFODKb8ZbkhudSkzZxKCR+mr7jJlvr5i4eytph4fGlTebtwsdPnsXUNFcs5PpELQzAdC
         zMVQRhJvSzEqxSIYgcvel/23EmlAQ+ZLFMjJt9Rkuvjy+9FNMd4bLubZwj9vzjG+1OkG
         WdiO7KDbJmBFNo42EC46/JvMT9oqr+K2Rh/HFhOGv0aBGf6mng7e0tAGLRg08e8S9XmE
         /BdUarvX1Ssi3/31Hl3efwZwbPQ2GoXVk5RpUCArAM9kZGz33QCMA5Nr2ZjzA0E/ikKK
         YqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbZPWFakmC0P34fIoq4LDDIb9IPJdx04Stgpp9wq8iHYWvkqlDtPtkRItWYzCFHce8DowFVw1eIYEQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNCK1YqZ7O4YGHmGxMoSI8OTJRbybUx2qAPDLPeObt+LpaRHc
	FDd5r+YqfYzG3gP3m5Hnnjnjo0R+Zn93bn6FamEQ5XbewQ5/3bx8sFXkbcIeDhay5Q==
X-Google-Smtp-Source: AGHT+IHgnJ0YhCd1EkSEz+tdwpvNNsyp+LcO1wOdC/OUzSn1flY0X31/t3eGDeD9oP/MyR4nmcAVYVE=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a5b:f0f:0:b0:e2e:2cba:ac1f with SMTP id
 3f1490d57ef6-e3087bd5414mr138970276.6.1730569885221; Sat, 02 Nov 2024
 10:51:25 -0700 (PDT)
Date: Sat,  2 Nov 2024 10:51:11 -0700
In-Reply-To: <20241102175115.1769468-1-xur@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241102175115.1769468-5-xur@google.com>
Subject: [PATCH v7 4/7] Add markers for text_unlikely and text_hot sections
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

Add markers like __hot_text_start, __hot_text_end, __unlikely_text_start,
and __unlikely_text_end which will be included in System.map. These markers
indicate how the compiler groups functions, providing valuable information
to developers about the layout and optimization of the code.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Tested-by: Yonghong Song <yonghong.song@linux.dev>
Tested-by: Yabin Cui <yabinc@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fd901951549c0..e02973f3b4189 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -549,6 +549,16 @@
 		__cpuidle_text_end = .;					\
 		__noinstr_text_end = .;
 
+#define TEXT_UNLIKELY							\
+		__unlikely_text_start = .;				\
+		*(.text.unlikely .text.unlikely.*)			\
+		__unlikely_text_end = .;
+
+#define TEXT_HOT							\
+		__hot_text_start = .;					\
+		*(.text.hot .text.hot.*)				\
+		__hot_text_end = .;
+
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
@@ -565,9 +575,9 @@
 		ALIGN_FUNCTION();					\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
-		*(.text.unlikely .text.unlikely.*)			\
+		TEXT_UNLIKELY						\
 		. = ALIGN(PAGE_SIZE);					\
-		*(.text.hot .text.hot.*)				\
+		TEXT_HOT						\
 		*(TEXT_MAIN .text.fixup)				\
 		NOINSTR_TEXT						\
 		*(.ref.text)
-- 
2.47.0.163.g1226f6d8fa-goog


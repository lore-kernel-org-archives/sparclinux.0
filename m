Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267D17BB13
	for <sparclinux@vger.kernel.org>; Sat, 26 Oct 2024 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729919667; cv=none; b=fV5zVTDaQancRrgdF7lg2wbRFuMiF1vdG1he9LEt5umWXY3oNzf66b8aSW+pv2fKKOxecpp/Eigdfea0/+ZJuKlKUBKB6VYcEVgXa2zL1eXXrBk402EW0cSZr+mmRkBOMNCnPEdOSm47iVQmFX4Q2+xPDI6gEEFp7uL96SH2Kkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729919667; c=relaxed/simple;
	bh=gX6C+xmPZI4vviIG2gcRmXQgQ4QuSRea9Xum6Y8PdvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sw8vibsHkNfYVKR2vkA1KwhxBaMPAPjsixh/R6LUrwyoeTAvk6Q/17cJJ2gRg6e9iJM30EflQweaQLdpvS9ABAODn20VMUOBlKLy/TsP0ZdPrR3yo0b75ZvHlQ9HlZqkS3ZYUYhWi1S+aUmtOLXubnrxyE62PiccRd4PG/huld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjb1BEm5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjb1BEm5"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3c638cc27so55221177b3.0
        for <sparclinux@vger.kernel.org>; Fri, 25 Oct 2024 22:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729919663; x=1730524463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHmgx0WMT0WJm/0bRZiTBO3ZfS/7yoeScA7PHXz66a0=;
        b=yjb1BEm52l9vEo993Pr9ASeOKs91j9kbETemKEKs8yLmkWf5NBKxhGqvwGXprjX1zd
         mpvj2bvbDNdPCubRXJPRVCWZskpmL5yu8kcmXSkz3w//LSFxfuT5toRGefI87FcLOXg0
         r7DJqS45tcyHLN1auEr22Rh2+pBCG1JJbc8DpQkwf1jRLzwDQvR/MgYTzbdQuhPAbihV
         pef/g/oKoqFzqANf1Dhwv0eOMDgzUKXKaztymBnpF/EXDkW549xgGfPn7ZXsCQguAiyF
         NtpOwG1cFiUQ5J2g/UQqWLPMnk16jGg9htwq3Eiu0fq+oQnjUGdPubAUeQ5APCNa5ifb
         PZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729919663; x=1730524463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHmgx0WMT0WJm/0bRZiTBO3ZfS/7yoeScA7PHXz66a0=;
        b=in0F01yYZZxYrkvg6KUTiwrnAb1NjjtneXmoPThc4XuS+rCAT3XyEFMIg7yLWlYXUf
         btuR/vsqvr648fcLbVlo9S5eZUROQXJobOKUotAQ9KijKtAFtDHOUSzzcUeSTbmLgfUW
         xzgnhQXtcrxS/oNLZy7HeCG0xCgGFnEfD3X5WeTNvg4ddWPrT2IhrXVoLfO0jBqR9t75
         bgCsmd/aXCWP8DqomrZfelEdArxhNdteknH78k59uKveWI4EuuY+pSX9lywgWNy+v40i
         tzNPOx/LGL0hCuBspwTXl8LsvSy/6vs88sVwUljvck1/jK7WrmbGQ0jXDZix0nvkDiOo
         49fA==
X-Forwarded-Encrypted: i=1; AJvYcCWCwpSX7kjhyHU++T5ZMAtNk0Demw6Nc0YkirCyqr5zLxK3zYwAGti2VQeyEyiidtwck3gPEswL+gCS@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHK3ZLiiodW7CleigOlxrCWOshRVffl/UT9Rw56MoxU6gK3d4
	3VIdq8H9kBQb7bUqhCzSJ280ZnNdXoN1RpucI0muU2YFc3JdmK+vlLtLKmel5K61Dw==
X-Google-Smtp-Source: AGHT+IFwdCF0m/L8cOwxhS25nb8LXGI1xFUxVkPvvMAds6km/RMLSYmvagpwqP7CwRbJFodaTTB7c0k=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:9704:0:b0:e2b:d404:7acb with SMTP id
 3f1490d57ef6-e3087c0c240mr5801276.9.1729919663197; Fri, 25 Oct 2024 22:14:23
 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:14:07 -0700
In-Reply-To: <20241026051410.2819338-1-xur@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241026051410.2819338-1-xur@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241026051410.2819338-6-xur@google.com>
Subject: [PATCH v6 5/7] AutoFDO: Enable -ffunction-sections for the AutoFDO build
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

Enable -ffunction-sections by default for the AutoFDO build.

With -ffunction-sections, the compiler places each function in its own
section named .text.function_name instead of placing all functions in
the .text section. In the AutoFDO build, this allows the linker to
utilize profile information to reorganize functions for improved
utilization of iCache and iTLB.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Tested-by: Yonghong Song <yonghong.song@linux.dev>
Tested-by: Yabin Cui <yabinc@google.com>
Change-Id: I6dc9150c46983a576f4d4f1415dbdcab78a48021
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++--
 scripts/Makefile.autofdo          |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e02973f3b4189..bd64fdedabd2f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -95,18 +95,25 @@
  * With LTO_CLANG, the linker also splits sections by default, so we need
  * these macros to combine the sections during the final link.
  *
+ * With AUTOFDO_CLANG, by default, the linker splits text sections and
+ * regroups functions into subsections.
+ *
  * RODATA_MAIN is not used because existing code already defines .rodata.x
  * sections to be brought in with rodata.
  */
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG) || \
+defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
+#else
+#define TEXT_MAIN .text
+#endif
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
-#define TEXT_MAIN .text
 #define DATA_MAIN .data
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index ff96a63fea7cd..6155d6fc4ca7f 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -9,7 +9,7 @@ ifndef CONFIG_DEBUG_INFO
 endif
 
 ifdef CLANG_AUTOFDO_PROFILE
-  CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE)
+  CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
 endif
 
 ifdef CONFIG_LTO_CLANG_THIN
-- 
2.47.0.163.g1226f6d8fa-goog


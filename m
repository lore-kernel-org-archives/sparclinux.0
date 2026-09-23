Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CC57EDAA
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194770; cv=none; b=hE1Lqh3/4kjGvC+yZqwez/DlJbgoB+c8TFHjfrug3Ct1tIo5nkyAFt+wCqvHOZQTNvakvW9/G38D19kWYjq7sO9862Q0R8H6QzXzcgvstNfv+U0g3zLMf8NcCZkkuk6J6o0c0NPgG43bNammeSCpSaiiWQkk5BMx20LHvsXRPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194770; c=relaxed/simple;
	bh=AC8oylFdwQ8cFzwdlHbb126te9vtXzziDP7/wP1B/5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhJc+ZvSwEG9ibN58G9+oPB4Hw7+RKaBXQLVDIjpAT+ivm9NTd9hBwADsk6lIMxeM+UOZdRoHrXTFz+XnzoEnSfFrNfcLZJjFVUJXo+/UpGyVIt1S5CYjVUrbjIE/RnSTBHHB/ZDw/oGfkoVGP8jj3DKMsuWMYn5bjjvj92w7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOZM/cQ+; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOZM/cQ+"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efebso215725566b.1
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790194763; x=1790799563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TSFltJ3k/9xOW9Dlp3D0ImCoh69p5cGuVhZZbL+BLyM=;
        b=GOZM/cQ+o7m6jYlRgzO8Aw2YVG3SM9pBEaWRxwuq0Li9EuVL2YVsS2tTFFFp1XFW+v
         FqNNtBe6pIhFtC/PMIBhKUNKu41wpn8rItDcoEZGH6WvawP+E6GzRVday4TiZKHrbrOh
         ZaRK2ip8mt4PnAk403cXOx3BDaQ8O2DqddzaDatfv3fVaYulVECGVyNg7gToRfyaFWVF
         oDBx24VoYI5Q8y7NkSc6poe1gqobw2dSN8FlU7e1izq2S5Xg2bkrHvlt9zR4SJLqrF1K
         07acmlfmIzA1syW1ZVhv7xoBP8eM4A17AfHZpqg+iU4q1MW6evgRo7yvR5wGd+jtOWlS
         jMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194763; x=1790799563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TSFltJ3k/9xOW9Dlp3D0ImCoh69p5cGuVhZZbL+BLyM=;
        b=pNr0Beacv5PJPPMu2psFRP6uHA4yf1W86UklzZKcMJj9awdu6PWChKcFCPMnOq6ujh
         Rs3gtPC7siNakHjgQfT3hIHxBuQ8OFiOMtXhBU9gAmM7WwFD9X1e34TAPhlawftWqUNt
         FsdJhQ09huHBHtlLubmcHu8SEao5EOHSDoumokb1INloNK+hIUvu3rq2dHzLbAX1B6nn
         H8KpyRkcCX++U/QZDm+Vf65RhWxLSYfzBFVvsAv3KkTfWyKhxHldTLcUuZm1kYl3PwAH
         WSHRasB7aE90cvLTlWwRrV67Z7hfZhVboKtdpX79Kv/mabIjicCf4BxaTXt3yz9uZCXo
         EtTA==
X-Forwarded-Encrypted: i=1; AKwUvBwq3G2u3QVY3c05eYf5897RdBT3p7JNJzbaf9+IRG8Goa1vm3cXtXC7SqxJiWn+8YF2vj/M9VRjDmjK@vger.kernel.org
X-Gm-Message-State: AFuF++mN+7gcFmO2qszaX88G1c0QycU8LPykiAyeX+GeH4b8GEM5dJ5Q
	si8vMvy8VNM2qx1yIWTeSLolvAN+LqQmVnehLCvOM8B5Kuf3i2529/PX
X-Gm-Gg: AYBFou356FX+yC+x5RYzQ/srZ+26Gc6qwSdEB/TqysWUKMG/4DG4Yy6LGct+aewAqQb
	HIA3o4yhKA1QtqW+iE8SdepmTKI8gnw7xvL5A3AIopOGgS8B3jV84JK5CMhcYdXjXyjHLnJka66
	Bq/NRgEqnmzp+Gfjps18Sgt+yKjIjZtOfZ2fWisw7zNo9/Nv/Ku6gS+e69PPz3WQ7TyKgUmJMy2
	AJI4ouf2nR2vbFw5Zpd55NIiuR0AMz0fkWYmLgT7Hl6zeYSUiNvbMS4dVS16xhyZy5t83VxMeE7
	GC2lU8jGOjMAK8vyK7PI+vf1Oyx59mBl2uLrTqB3eds26XBjvWlsg8hUFdEHPaK0sgJThlRQ3s+
	psLC9HZk4X3HwRvoLi2aitfwkoO+cF9oVaO2RnQjJ++1YL3SbvOYWDM1xRE0NdKLFo9jt3SvQOZ
	ymikruHf/sXOqND9aGZ/FkTwzqRsOJi0hzo3ooKA1ViOIciugjthCqXwEIU2iPCslH/HdNg0P7P
	F7xMGyX2nJtJVJ89gUywZM2YcPHthrVY2l7myyM
X-Received: by 2002:a17:907:c23:b0:c2a:704c:8c75 with SMTP id a640c23a62f3a-c2ac25123f2mr22944766b.39.1790194762351;
        Wed, 23 Sep 2026 13:19:22 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae63dc17sm183626966b.33.2026.09.23.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:19:22 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [RFC PATCH 5/5] sparc32: document the compare-and-swap trap ABI
Date: Wed, 23 Sep 2026 22:17:21 +0200
Message-ID: <20260923201830.865553-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923201830.865553-1-linmag7@gmail.com>
References: <20260923201830.865553-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trap is userspace ABI rather than an internal kernel facility, so
write down what it promises: the instruction and trap type, the register
convention, the failure cases, what the AT_HWCAP bit means, and the limits
a caller has to work within.

Several of those limits are easy to miss. Replacing the __atomic_* helper
symbols does not by itself route every atomic write through the trap,
because the compiler can expand some of them inline and covering libc's
own uses is a different scope from covering application code built with
atomic builtins. The service is one aligned 32-bit word, which is not the
same as general byte and halfword atomics. The guarantee is indivisibility
of that one word and no ordering beyond it. And futex_robust_unlock()
currently writes the futex word without taking the lock the trap uses, so
that one kernel path is outside the guarantee.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 Documentation/arch/sparc/cas-trap.rst | 163 ++++++++++++++++++++++++++
 Documentation/arch/sparc/index.rst    |   1 +
 2 files changed, 164 insertions(+)
 create mode 100644 Documentation/arch/sparc/cas-trap.rst

diff --git a/Documentation/arch/sparc/cas-trap.rst b/Documentation/arch/sparc/cas-trap.rst
new file mode 100644
index 000000000000..f09d81e8f1ed
--- /dev/null
+++ b/Documentation/arch/sparc/cas-trap.rst
@@ -0,0 +1,163 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+The sparc32 compare-and-swap trap
+=================================
+
+Pre-v9 sparc has no compare-and-swap instruction.  A lock held inside one
+process cannot make a word atomic against another process mapping the same
+page, and a lock kept inside the word itself costs value bits, so the kernel
+performs the operation instead.  parisc provides the same service for the same
+reason.
+
+Interface
+=========
+
+``ta 0x11`` - software trap 0x11, trap type 0x91, ``SP_TRAP_CAS`` in
+``asm/traps.h`` - asks the kernel to compare and swap one 32-bit word:
+
+=======  =========================================
+``%o0``  word aligned user address
+``%o1``  expected value
+``%o2``  new value
+=======  =========================================
+
+On return the carry bit is clear and ``%o0`` holds the value that was found at
+the address.  The caller compares it against what it expected to learn whether
+the swap happened; there is no separate success flag.
+
+Registers
+---------
+
+``%o0`` is read and written.  ``%o1`` and ``%o2`` are read and are not
+modified.  Every other windowed and global register is preserved across the
+trap.  The integer condition codes are written - that is how success and
+failure are reported - and must be treated as clobbered.
+
+An inline-assembly wrapper therefore wants ``%o0`` as an in/out operand,
+``%o1`` and ``%o2`` as inputs, and both ``"cc"`` and ``"memory"`` in the
+clobber list, the latter so the compiler does not move accesses across the
+operation.
+
+On failure the carry bit is set and ``%o0`` holds an error number:
+
+==========  =========================================
+``EINVAL``  the address is not word aligned
+``EFAULT``  the memory access could not be completed
+==========  =========================================
+
+A successful return does not establish that the mapping is writable.  On the
+software path the kernel writes only when the comparison succeeds, so a
+mismatching value on a read-only mapping can be returned without the kernel
+ever discovering that the mapping could not be written.  The two
+implementations are not required to agree about an invalid operand: pass an
+aligned word in memory that is both readable and writable.
+
+The operation is atomic against another process issuing the same trap, against
+the futex operations in ``asm/futex_32.h``, and - on a cpu that implements
+``casa`` - against a binary using that instruction directly.
+
+The service guarantees an indivisible compare-and-swap on the addressed word
+under the participation rules below.  It does not provide any additional
+acquire, release or full-barrier guarantee for other memory locations.
+Userspace must supply whatever ordering the operation it is implementing
+requires.
+
+One kernel path does not participate.  ``futex_robust_unlock()`` clears the
+futex word through ``unsafe_atomic_store_release_user()``, for which sparc32
+uses the generic definition - ultimately a plain user store.  On a no-casa SMP
+system that store does not acquire the lock this trap uses, so it can land
+between the trap's load and its conditional store, and the compare-and-swap
+then overwrites the unlock while still reporting success.
+
+On no-casa SMP systems the non-PI robust-unlock operations
+``FUTEX_UNLOCK_WAKE_LIST32`` and ``FUTEX_UNLOCK_BITSET_LIST32``, including
+their private variants, therefore do not serialise with the software-CAS lock
+domain.  Their store can race with a trap-based compare-and-swap, and equally
+with the lock-backed operations in ``asm/futex_32.h``, which take the lock but
+still load and store separately.
+
+The integration point for this store remains an open question for review.
+
+What userspace has to do as well
+================================
+
+On a cpu without ``casa`` the kernel does the swap under a lock of its own, and
+**an ordinary store does not take that lock**::
+
+	trap                        another thread's plain store
+
+	lock
+	read word -> A
+	                            store B -> word
+	write C -> word
+	unlock
+
+``B`` is lost, and no ordering of an atomic compare-and-swap and an atomic
+store makes that a legal outcome.
+
+So userspace using this service to build atomic operations must build *every*
+atomic write from it, not just compare-and-exchange: an atomic store and an
+atomic exchange each become a compare-and-swap retry loop.  An implementation
+that routes read-modify-writes through the trap but leaves atomic stores as
+plain stores is not atomic, and the failure is silent.
+
+This does not apply to a cpu that has ``casa``, where the kernel uses the
+instruction and userspace can too.
+
+Replacing the ``__atomic_*`` helpers is not sufficient
+-----------------------------------------------------
+
+Providing replacement ``__atomic_store_4`` and ``__atomic_exchange_4`` symbols
+does not by itself route every atomic write through the trap.  gcc can expand
+an atomic store to a plain store, a 32-bit atomic exchange to ``swap``, and an
+atomic test-and-set to ``ldstub`` on v8.  ``swap`` and ``ldstub`` are
+themselves atomic, but they do not take the kernel's lock and so do not exclude
+against its separate read and write.  A call the compiler never emits cannot be
+intercepted.
+
+Two different integration scopes follow from that, and they are not
+interchangeable.  Changing libc's internal atomic macros covers libc's own
+uses.  It does not change application code compiled with atomic builtins; that
+needs compiler support - the possibility Andreas Larsson raised in 2019 - or a
+build that avoids the inline expansions.
+
+One aligned word is not general byte and halfword atomics
+--------------------------------------------------------
+
+The service operates on one naturally aligned 32-bit word.  A byte or halfword
+atomic synthesised by read-modify-writing its containing word is not safe
+merely because every atomic on the target uses the trap::
+
+	word:  [ atomic byte A | ordinary byte B | ... ]
+
+	cpu 0                             cpu 1
+
+	read the whole word under the lock
+	                                  plain store to B
+	write the whole word back,
+	  including the old B
+
+The ordinary writer of the neighbouring object ``B`` has no reason to
+participate, and its store is lost.  Byte and halfword atomics built this way
+need either width-aware accesses sharing this lock domain, or storage rules
+that give the atomic object its containing word to itself.
+
+Availability
+============
+
+``AT_HWCAP`` carries ``HWCAP_SPARC_CASTRAP`` (0x10000000) when the kernel
+implements the trap.  Userspace must consult it rather than probing, because
+there is no safe way to probe:
+
+- on a kernel without this support the trap is fatal;
+- on sparc64 a 32-bit process reads its hwcap word from ``asm/elf_64.h``, where
+  the bit is reserved and always clear, and ``ta 0x11`` there is not an illegal
+  instruction but the old 64-bit system call trap.
+
+The bit describes the kernel service, not the hardware.  It is set whether or
+not the cpu has ``casa``, because a binary built for plain v8 cannot use that
+instruction even on a cpu that has it.  A binary that does have ``casa``
+available - one built for LEON3 - should use it inline and ignore the bit
+entirely; the kernel uses the instruction too where it exists, so the two agree
+on the same word.
diff --git a/Documentation/arch/sparc/index.rst b/Documentation/arch/sparc/index.rst
index ae884224eec2..3a7d6df91a84 100644
--- a/Documentation/arch/sparc/index.rst
+++ b/Documentation/arch/sparc/index.rst
@@ -7,6 +7,7 @@ Sparc Architecture
 
    console
    adi
+   cas-trap
 
    oradax/oracle-dax
 
-- 
2.43.0


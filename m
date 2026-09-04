Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12844756CA
	for <sparclinux@vger.kernel.org>; Fri,  4 Sep 2026 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520377; cv=none; b=d1AmpHF4XojNtwepBy1jSFpcxzgQdgADc7FnKrIhulm93Vf3qUnpYMaejW0q3sGyKDcReWFA51ePoYfRjGj9xyVsFslaUH1/WgMdLZ87r6DOjXMcP0g/b4zwbOztxfkvIQNIVBiqT/w2Kj2hU13lRLoPAqrviJ5nRurfwU7WT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520377; c=relaxed/simple;
	bh=/HiXJ0uPiunlUOuIQ3WhK3PLz3rLr3IKGIOnF8dMxqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPXEq99cuDXO2M/mhqO014T7nDT3p/NVkz+kJtSYFNUZ/T0AVFB5oRPrRmwWLPaHwlIUAnLRm60Js4qPW4uWbvVldzZ06u3tNOyLeyA0lqUKuKUlWHmbvBXhDrSs0bdnYJHZnrtWo5oDkRzqOWwpr3nu8m0nuI+aYx8gd3uuzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOXzm21N; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOXzm21N"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6b5737bb2so1072591a34.1
        for <sparclinux@vger.kernel.org>; Fri, 04 Sep 2026 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520374; x=1789125174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zJQWGHjc4TCCyxSMpC9mNros2ugwbs2/DkxIDipn+DQ=;
        b=oOXzm21NfoiJkksUOmox+yefSSyvt737Et9i3hP4i/s5+A/EKmv/hgL07Ru53xScyl
         7gNs7/6R8WqKHmHqd7bJ8ScnG60oKqkzgAWRwKITvi1yOcg4jYQpgGOgaSALt067WSOb
         QqtqsfhuHkn19IBdoV2Fh3vg9I/ACR6Yu64ce1Yt5k8/Ho+Sc3KG7GGYFU7nYIdNi/TA
         1suHfWaWZtaCXEkriWH1lOv/kcNhA0nSgdab7BTyEKqBpICcGjqFWRucb8iNIfujyZKq
         ILvLJevNyfm4Wo1o+cfT3HN4ZTw6kfQ3ouMGtkwHoo0f/hA0GrQ5ZVlxNcouRBxVXvJy
         EbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520374; x=1789125174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zJQWGHjc4TCCyxSMpC9mNros2ugwbs2/DkxIDipn+DQ=;
        b=NPELRjiCGBj3KRcerOTqvqAWgQd1FqQY/yU9p/OvdXUMClmh5luJfsrMDB5Sja2vUJ
         5e8UeOrP9yGu4QEa9SfuFlGz2X2FOyddWKBTbr+RS1xclxwxi+TYEYfJvC/aCcWOAHnh
         i6CHJtIEVJAnYKvG1WDK0cTF4vSTgsFEYgV5o6LkFClSJyEskyEX1DEp3jEP2SpaVBqZ
         wxhhCNsVwaYzCZ0kNora3l7j3rjBQlmXPIhPNQmUGd0ShnLbmRzNOyHb6YEUSEJ2goWP
         uqiTBncYDM9QCpHlIioPjtyTuG91KOVp7VbXXHGbyA6DWYN3LgaRqyGp3+7Rf611iD6o
         WERQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCVndKI5aeeuxxGAgWUqnHhdyc30W4mWIAhbD9yzvaMMp9XYS+q0oaLBffZSMWouEipSTxU/UPCYoL@vger.kernel.org
X-Gm-Message-State: AFuF++lOu5C+r5t4OFe21nNj66L1ZMREpfRYlAlEp6XMujxvYlXN3wJC
	Jsh0Wp0RgxjhWZd/h1KNCwlF1MXnX4hdWNctQhkdAwjPL4ib0v4x5QiY
X-Gm-Gg: AYBFou1rciYbIZRgf2oaVqA8G1uItEZuEP5NdWTISuyJiLErftLBkyevnxC7t9Kj9CW
	qNVHSnKhofcmIIu/bSt/88FJBXCe80ELLvJh9xjYDafPYosT4x7rJz2MhSG7oqX1qZNiSaH4LsT
	GI/0JQPdAcTh7KaxnOOhDprrQ5fzIA1fEvMyKTgmrvHSK0v9XzZoF+I415gFGLClDp6x42fmcxN
	dvIUbgIRmP6SrIS2Yuy/I3f2V3xhGh9eBAcFvKk/SbOmelkPagjZTT1KYwtvOi3Jv8kIRHkuDiv
	deBnaC+AJ4Z3pYcKBEoEbAKYDR2POd9idsHmwsz9AWoftPnp7jLuZHY4b5wArz6zbfTUsP6Dk/x
	vg9XN2INxSkb4H5QHJDlD0RCNJDWD9GwGcX2tI5xMdwXgcMbvWyA8QoOUxVmMgmbPQeYBX59t9j
	svKRph9l6Q5SGhu33heHB+Qdc8INXfk+Ms++jPkkgWzuXNsOfB/eK2b4pkphgx2vY/4MGUEAOv2
	EYQgg6LBg3kWZcJuAHDOy5FPzE=
X-Received: by 2002:a05:6820:6ac3:b0:6a3:c6f8:4caa with SMTP id 006d021491bc7-6b6fa5e80f5mr3664891eaf.2.1788520374324;
        Fri, 04 Sep 2026 04:12:54 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm7305785c88.5.2026.09.04.04.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:12:53 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 1/2] sparc: fix typos in comments
Date: Fri,  4 Sep 2026 16:42:39 +0530
Message-ID: <20260904111244.24636-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904111244.24636-1-hemanth.selam@gmail.com>
References: <20260904111244.24636-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/sparc/include/asm/asm-prototypes.h |  2 +-
 arch/sparc/include/asm/bbc.h            |  2 +-
 arch/sparc/include/asm/hypervisor.h     | 10 +++++-----
 arch/sparc/kernel/head_64.S             |  2 +-
 arch/sparc/kernel/process_32.c          |  2 +-
 arch/sparc/kernel/process_64.c          |  2 +-
 arch/sparc/kernel/traps_64.c            |  2 +-
 arch/sparc/mm/init_64.c                 |  2 +-
 arch/sparc/prom/tree_32.c               |  2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
index a39a24c53216..51d5d218b42a 100644
--- a/arch/sparc/include/asm/asm-prototypes.h
+++ b/arch/sparc/include/asm/asm-prototypes.h
@@ -18,7 +18,7 @@
 void *__memscan_zero(void *, size_t);
 void *__memscan_generic(void *, int, size_t);
 void *__bzero(void *, size_t);
-void VISenter(void); /* Dummy prototype to supress warning */
+void VISenter(void); /* Dummy prototype to suppress warning */
 #undef memcpy
 #undef memset
 void *memcpy(void *dest, const void *src, size_t n);
diff --git a/arch/sparc/include/asm/bbc.h b/arch/sparc/include/asm/bbc.h
index 00a4f116144d..e82b59e1ae6f 100644
--- a/arch/sparc/include/asm/bbc.h
+++ b/arch/sparc/include/asm/bbc.h
@@ -87,7 +87,7 @@
 
 /* Watchdog Action register.  When the watchdog device timer expires
  * a line is enabled to the BBC.  The action BBC takes when this line
- * is asserted can be controlled by this regiser.
+ * is asserted can be controlled by this register.
  */
 #define BBC_WDACTION_RST  0x01	/* When set, watchdog causes system reset.
 				 * When clear, BBC ignores watchdog signal.
diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 94ac56d43746..1c5497189245 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -172,7 +172,7 @@ void sun4v_mach_sir(void);
  * Service Processor, and/or automatically restarting the gues.
  *
  * The 'timeout' parameter is specified in milliseconds, however the
- * implementated granularity is given by the 'watchdog-resolution'
+ * implemented granularity is given by the 'watchdog-resolution'
  * property in the 'platform' node of the guest's machine description.
  * The largest allowed timeout value is specified by the
  * 'watchdog-max-timeout' property of the 'platform' node.
@@ -1223,7 +1223,7 @@ unsigned long sun4v_con_write(unsigned long buffer,
  *
  * This allows the guest to report its soft state to the hypervisor.  There
  * are two primary components to this state.  The first part states whether
- * the guest software is running or not.  The second containts optional
+ * the guest software is running or not.  The second contains optional
  * details specific to the software.
  *
  * The software state argument is defined below in HV_SOFT_STATE_*, and
@@ -1585,7 +1585,7 @@ struct hv_trap_trace_entry {
  *			      "interrupts" property or "interrupt-map" property
  *			      in the OBP device tree for that device.
  *
- *	sysino		System interrupt number.  A 64-bit unsigned interger
+ *	sysino		System interrupt number.  A 64-bit unsigned integer
  *			representing a unique interrupt within a virtual
  *			machine.
  *
@@ -2925,7 +2925,7 @@ unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
  * endpoint defined by the given channel ID.  The tail offset specified
  * must be aligned on a 64 byte boundary, and calculated so as to increase
  * the number of pending entries on the transmit queue.  Any attempt to
- * decrease the number of pending transmit queue entires is considered
+ * decrease the number of pending transmit queue entries is considered
  * an invalid tail offset and will result in an EINVAL error.
  *
  * Since the tail of the transmit queue may not be moved backwards, the
@@ -3017,7 +3017,7 @@ unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
  * endpoint defined by the given channel ID.  The head offset specified
  * must be aligned on a 64 byte boundary, and calculated so as to decrease
  * the number of pending entries on the receive queue.  Any attempt to
- * increase the number of pending receive queue entires is considered
+ * increase the number of pending receive queue entries is considered
  * an invalid head offset and will result in an EINVAL error.
  *
  * The receive queue may be flushed by setting the head offset equal
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index cf0549134234..b8db806ad760 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -927,7 +927,7 @@ swapper_4m_tsb:
 	/* Some care needs to be exercised if you try to move the
 	 * location of the trap table relative to other things.  For
 	 * one thing there are br* instructions in some of the
-	 * trap table entires which branch back to code in ktlb.S
+	 * trap table entries which branch back to code in ktlb.S
 	 * Those instructions can only handle a signed 16-bit
 	 * displacement.
 	 *
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index dd8c6c02b0f1..d430ed632140 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -244,7 +244,7 @@ clone_stackframe(struct sparc_stackf __user *dst,
 
 /* Copy a Sparc thread.  The fork() return value conventions
  * under SunOS are nothing short of bletcherous:
- * Parent -->  %o0 == childs  pid, %o1 == 0
+ * Parent -->  %o0 == children  pid, %o1 == 0
  * Child  -->  %o0 == parents pid, %o1 == 1
  *
  * clone3() - Uses regular kernel return value conventions
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index e889da8e4835..a35100c608c5 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -562,7 +562,7 @@ void fault_in_user_windows(struct pt_regs *regs)
 
 /* Copy a Sparc thread.  The fork() return value conventions
  * under SunOS are nothing short of bletcherous:
- * Parent -->  %o0 == childs  pid, %o1 == 0
+ * Parent -->  %o0 == children  pid, %o1 == 0
  * Child  -->  %o0 == parents pid, %o1 == 1
  *
  * clone3() - Uses regular kernel return value conventions
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 28cb0d66ab40..a69bc0dee6a6 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -1142,7 +1142,7 @@ static unsigned char cheetah_mtag_syntab[] = {
        NONE, NONE
 };
 
-/* Return the highest priority error conditon mentioned. */
+/* Return the highest priority error condition mentioned. */
 static inline unsigned long cheetah_get_hipri(unsigned long afsr)
 {
 	unsigned long tmp = 0;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..43a774654ade 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1291,7 +1291,7 @@ static int __init grab_mblocks(struct mdesc_handle *md)
 					 "address-congruence-offset", NULL);
 
 		/* The address-congruence-offset property is optional.
-		 * Explicity zero it be identifty this.
+		 * Explicitly zero it be identifty this.
 		 */
 		if (val)
 			m->offset = *val;
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index 0fed89375b74..422a69437447 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -200,7 +200,7 @@ phandle prom_searchsiblings(phandle node_start, char *nodename)
 }
 EXPORT_SYMBOL(prom_searchsiblings);
 
-/* Interal version of nextprop that does not alter return values. */
+/* Internal version of nextprop that does not alter return values. */
 static char *__prom_nextprop(phandle node, char * oprop)
 {
 	unsigned long flags;
-- 
2.48.1


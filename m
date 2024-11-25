Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309918CC10;
	Mon, 25 Nov 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524806; cv=none; b=A0Vh8TWN3qxBo9N5wfHID8OK0+nJsgdw8oxtbV31Nvezr8Y1kEM0CcXaI5gds2+ZVunq0XelLL5JmBJLzAIB8eiWRaHk6sQsG84oCCHjojGH9PtXSDVrX/m5MCzJP9ZI7dBhlONOxI3iPuu7ltbEPosMdc5pDF6ogXIaaIg2olQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524806; c=relaxed/simple;
	bh=TSjIN0mW495WbxsCnfNx4szxFbShMiIOsnATq/4G7ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kt9x6jVRkUYJSMT3Ij6Ih4kWiCjm5WYz4GOKL1mVtyeeFjg1SoCKsQw2/dVTynXfb2LD2McBmYssCrUg57uice8saatFdFSaC0FdWT0d+ZqP9nZV2V9cmys2nxCyLQjaRr9rf1yt77gpjfZQDILU4du7lmuHVMEgZV+pqZxgi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x9Rnni7R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UjLs4BN7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x9Rnni7R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UjLs4BN7"
Date: Mon, 25 Nov 2024 09:53:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732524795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1QnVWg50V8x1Sp6K71wK7PCrKcfLt+CeyDojQPduSM=;
	b=x9Rnni7RlQePJRS+0pknLBKj7lhrj0sZWrYydPk11QlJbVs0eJklygRtqkNjpWIz2aRbZh
	ijJD4CzvTJV9mr4i+Aodir6+jPtVlYOERk7BYzhbwUMrK93SlyZpix3mlb2/XUL/bp2vBQ
	IXOErY+lgm3f2tqlNM0y7w9Gh7Bx3vLN8X/es87GaMB30YvT52UAZMj+cgjlAD18Twgf3X
	/We/F7IxZRjU53XzzK6QT6VIdRyLJt3OypwyVwWOf3F+65BNml0C4JdB54lQ+TsTVSj+AD
	sRPLVs0s00JwAMuDhoMfCgn1jNIqvdliUk+8tYywoh2yx8oLNQCbN6xSjemK8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732524795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1QnVWg50V8x1Sp6K71wK7PCrKcfLt+CeyDojQPduSM=;
	b=UjLs4BN7d5aWUCkMwDUUDLd0m2A032MtRhurvGDxCDbkF1dzdbpo9qC17yqxney/xmIUaK
	xGRUfQcY6yxYIHBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
Message-ID: <20241125085314.1iSDFulg@linutronix.de>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
 <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>

The pci_poke_lock is used underneath of the pci_lock. The pci_lock is a
low level lock used by the core code in sections with disabled
insterrupts. Therefore the pci_poke_lock must be a raw_spinlock_t.

Make pci_poke_lock a raw_spinlock_t.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net
Fixes: 560af5dc839ee ("lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2024-11-23 08:27:08 [-0800], Guenter Roeck wrote:
> 
> Is this a problem with the test or with the platform ?

platform. The patch below should fix it. It makes no difference unless
used on PREEMPT_RT. Since sparc does not support it I made the fixes
where the default option changed.

Could you test it, please? I don't have a even a compiler for sparc
right now.

 arch/sparc/kernel/pci.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 50a0927a84a6f..12e0b78cded55 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -42,14 +42,14 @@ volatile int pci_poke_in_progress;
 volatile int pci_poke_cpu = -1;
 volatile int pci_poke_faulted;
 
-static DEFINE_SPINLOCK(pci_poke_lock);
+static DEFINE_RAW_SPINLOCK(pci_poke_lock);
 
 void pci_config_read8(u8 *addr, u8 *ret)
 {
 	unsigned long flags;
 	u8 byte;
 
-	spin_lock_irqsave(&pci_poke_lock, flags);
+	raw_spin_lock_irqsave(&pci_poke_lock, flags);
 	pci_poke_cpu = smp_processor_id();
 	pci_poke_in_progress = 1;
 	pci_poke_faulted = 0;
@@ -63,7 +63,7 @@ void pci_config_read8(u8 *addr, u8 *ret)
 	pci_poke_cpu = -1;
 	if (!pci_poke_faulted)
 		*ret = byte;
-	spin_unlock_irqrestore(&pci_poke_lock, flags);
+	raw_spin_unlock_irqrestore(&pci_poke_lock, flags);
 }
 
 void pci_config_read16(u16 *addr, u16 *ret)
@@ -71,7 +71,7 @@ void pci_config_read16(u16 *addr, u16 *ret)
 	unsigned long flags;
 	u16 word;
 
-	spin_lock_irqsave(&pci_poke_lock, flags);
+	raw_spin_lock_irqsave(&pci_poke_lock, flags);
 	pci_poke_cpu = smp_processor_id();
 	pci_poke_in_progress = 1;
 	pci_poke_faulted = 0;
@@ -85,7 +85,7 @@ void pci_config_read16(u16 *addr, u16 *ret)
 	pci_poke_cpu = -1;
 	if (!pci_poke_faulted)
 		*ret = word;
-	spin_unlock_irqrestore(&pci_poke_lock, flags);
+	raw_spin_unlock_irqrestore(&pci_poke_lock, flags);
 }
 
 void pci_config_read32(u32 *addr, u32 *ret)
@@ -93,7 +93,7 @@ void pci_config_read32(u32 *addr, u32 *ret)
 	unsigned long flags;
 	u32 dword;
 
-	spin_lock_irqsave(&pci_poke_lock, flags);
+	raw_spin_lock_irqsave(&pci_poke_lock, flags);
 	pci_poke_cpu = smp_processor_id();
 	pci_poke_in_progress = 1;
 	pci_poke_faulted = 0;
@@ -107,14 +107,14 @@ void pci_config_read32(u32 *addr, u32 *ret)
 	pci_poke_cpu = -1;
 	if (!pci_poke_faulted)
 		*ret = dword;
-	spin_unlock_irqrestore(&pci_poke_lock, flags);
+	raw_spin_unlock_irqrestore(&pci_poke_lock, flags);
 }
 
 void pci_config_write8(u8 *addr, u8 val)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&pci_poke_lock, flags);
+	raw_spin_lock_irqsave(&pci_poke_lock, flags);
 	pci_poke_cpu = smp_processor_id();
 	pci_poke_in_progress = 1;
 	pci_poke_faulted = 0;
@@ -126,14 +126,14 @@ void pci_config_write8(u8 *addr, u8 val)
 			     : "memory");
 	pci_poke_in_progress = 0;
 	pci_poke_cpu = -1;
-	spin_unlock_irqrestore(&pci_poke_lock, flags);
+	raw_spin_unlock_irqrestore(&pci_poke_lock, flags);
 }
 
 void pci_config_write16(u16 *addr, u16 val)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&pci_poke_lock, flags);
+	raw_spin_lock_irqsave(&pci_poke_lock, flags);
 	pci_poke_cpu = smp_processor_id();
 	pci_poke_in_progress = 1;
 	pci_poke_faulted = 0;
@@ -145,14 +145,14 @@ void pci_config_write16(u16 *addr, u16 val)
 			     : "memory");
 	pci_poke_in_progress = 0;
 	pci_poke_cpu = -1;
-	spin_unlock_irqrestore(&pci_poke_lock, flags);
+	raw_spin_unlock_irqrestore(&pci_poke_lock, flags);
 }
 
 void pci_config_write32(u32 *addr, u32 val)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&pci_poke_lock, flags);
+	raw_spin_lock_irqsave(&pci_poke_lock, flags);
 	pci_poke_cpu = smp_processor_id();
 	pci_poke_in_progress = 1;
 	pci_poke_faulted = 0;
@@ -164,7 +164,7 @@ void pci_config_write32(u32 *addr, u32 val)
 			     : "memory");
 	pci_poke_in_progress = 0;
 	pci_poke_cpu = -1;
-	spin_unlock_irqrestore(&pci_poke_lock, flags);
+	raw_spin_unlock_irqrestore(&pci_poke_lock, flags);
 }
 
 static int ofpci_verbose;
-- 
2.45.2


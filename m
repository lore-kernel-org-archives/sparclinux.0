Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE13353A7E;
	Sun, 27 Sep 2026 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542218; cv=none; b=cyy8VtE6eeu4z2b142TeTbQ/HGYrDIZu9Zaf4FYk64ERbTzPV2tmNOjeELgn+sR36insYfFjXfgoHP1jcL1QvdBN0n/FbnZjoOb4iQBE/T7VHeDDapxMUbG4l2G/JO4Pc6QZD0IZs8bMQYT0XYJhZL0qC++I3X5ZJcuj5NDFZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542218; c=relaxed/simple;
	bh=9x5f3N6kZd8X3mXYat1GxFPubAgj1HskVa5K72n7ZyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeIe4KP1UQxNFy1IB6blq/4QSYKNMMioz0axp/LJ/EW34fO2JTwIkmAqpp17U1dUfh+2UioOVkplNAvJKs4uvdIRrtUPnNqhbW57/ZpIxO/7dHxp8FaE2v2be3Y3oN84IjwRdxA4corRbFl12noEctVek3YLk74PUGMK7ILSLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuKgyoPg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuKgyoPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9741F000FF;
	Sun, 27 Sep 2026 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542217;
	bh=6vsfbxzKzF6XBIMVOxCnSlc7L2gTTGMxUoIjEiFpFpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuKgyoPgzk8POgKoiZ+WH0ga6tPCw/Rh9VCH2yTYksUR0frO+fF27EWlczXainkxZ
	 OSe6tTrUHEzPOb6XXddZeKVTh8UNOz6oMtaZ3CrzoNvzCljvBYAM9tAEW9bRG9PojC
	 5ApQfybs4/A1r0hbOqacPqNSxuaBHiTlqmOs+5Uc2qAujIBGLxBOQ5Fa5+boJDKIB2
	 4vlEY3KNte92sqqxpwSyhSGjQBXcxYKz1L4u1Fuo03eFV7u+S0xNnyIWUwtvobyD6E
	 B9nrIM2eia8+MyeOLmP3bMRINLsPX3yq8fPrzBxxY5SuBATaWSRx3KOduqrxZB2Dht
	 dER6J3EjV5ZqA==
From: Imre Kaloz <kaloz@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: Andreas Larsson <andreas@gaisler.com>,
	davem@davemloft.net,
	sparclinux@vger.kernel.org,
	Tony Rodriguez <unixpro1970@gmail.com>,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	glaubitz@physik.fu-berlin.de,
	thuth@redhat.com,
	regressions@lists.linux.dev,
	nroach44@nroach44.id.au
Subject: Re: [PATCH v2] sparc64: increase kernel thread stack size to 32K
Date: Sun, 27 Sep 2026 22:49:12 +0200
Message-ID: <20260927204912.3667-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831172928.3082853-1-stian@itx.no>
References: <20260519075809.8993-1-unixpro1970@gmail.com> <20260831172928.3082853-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Stian,

I ran this on a Sun Ultra 45 (UltraSPARC IIIi, SMP). The unpatched
kernel hits "corrupted stack end detected inside scheduler" in
hub_power_on() on 10 out of 10 boots with USB devices attached. With
the 32K stack it boots clean every time: 6 boots with the v1 diff,
10 more with the minimal diff below. A forced hub/device rebind with
the stack tracer armed peaked at 15832 of 32768 bytes, so 32K looks
like plenty here.

On v1, Andreas agreed with 32K but asked for the dead else branches
to be pulled into their own patch with a fixup tag for 15b9350a177b,
since that commit should have removed them already. v2 folds the
removal into the same patch, so I'd split it back out for v3: the
fix as the minimal diff below, the else-branch removal as its own
patch on top. Nice work!

The minimal diff is below the scissors, feel free to fold it in.

Tested-by: Imre Kaloz <kaloz@kernel.org> # Sun Ultra 45


Best,
Imre

-- >8 --
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index c8a73dff27f8..ec552513d63c 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -100,8 +100,8 @@ struct thread_info {
 #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
 
 #if PAGE_SHIFT == 13
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define THREAD_SHIFT (PAGE_SHIFT + 1)
+#define THREAD_SIZE (4*PAGE_SIZE)
+#define THREAD_SHIFT (PAGE_SHIFT + 2)
 #else /* PAGE_SHIFT == 13 */
 #define THREAD_SIZE PAGE_SIZE
 #define THREAD_SHIFT PAGE_SHIFT
@@ -129,7 +129,7 @@ extern struct thread_info *current_thread_info(void);
 
 /* thread information allocation */
 #if PAGE_SHIFT == 13
-#define THREAD_SIZE_ORDER	1
+#define THREAD_SIZE_ORDER	2
 #else /* PAGE_SHIFT == 13 */
 #define THREAD_SIZE_ORDER	0
 #endif /* PAGE_SHIFT == 13 */

Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010416132A
	for <sparclinux@vger.kernel.org>; Tue, 30 Jul 2024 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722306403; cv=none; b=TmtZTraBMx4rKGIbdPJW0qS/zqEeLLhohkZmsofnCX8UzoNx772WKgZZZc1rO4WfA99umqsZI1Djzt+Q227rJrkBHIB92HHccasWSsNTOQLw7Nd1VF9MVQWXJh0UgXbVXTTpL7C0cJGs57zbB61gMMcWwWhGQBj4J5ReNIGEj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722306403; c=relaxed/simple;
	bh=EujhD2n1Ke7lPZKkibOLBAZurseJRlXkSsBCc47I7oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nZHJJRIrE1X6xFY2VzGVg5gGQ5l9KelPw+Eh+oZ33cu8eSk4Fh5/U4TpkL1BVFRhTnA6lc1nNABU/NwGaEcz1Eynbx92MHfenu+Z2+OqPgWl++jgsgoHQFBeMLijcO3Aqhz8PRHeETNFAdoZdapkF9pKoaAD/aSk5Kgz0vWqbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMiBfkyB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMiBfkyB"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b329ba782so5580305276.2
        for <sparclinux@vger.kernel.org>; Mon, 29 Jul 2024 19:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722306399; x=1722911199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpjJDC2/7eGvs2TUXo8T6/AXlUgH8srqN9C/rVg09l8=;
        b=PMiBfkyBoM++DGBz1g4NuSQnzPasJvL6kbjQziLAoPgtfrChbOkv2KnLHBoA9X2o1K
         h69ROOhwNEiBrsJWA3ATMuYT/e/Tu7BhTJihT5Cn8U/ZZTNjQ1mGwK40YzVZ9FCfI5vt
         l7IaEpnL+sJ0QElLc0gEH3++hSFLGj4NhdvTNpoIRTJ4nWdITQV93jybGCoMI2GTQmvG
         6Cm3+aIApcPGLnH47QtitQP/w78Di0s1Ufsgss+mj+74dIpgoWap79E3/kpB55ItB+Q5
         HAilTjS/4inOrx8WDBKdLAEuaaaDZN5fCmV3QxA2NoM/56A9qWcphMcLMJuy2xtj416d
         Cpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722306399; x=1722911199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpjJDC2/7eGvs2TUXo8T6/AXlUgH8srqN9C/rVg09l8=;
        b=RQ1jGGAwq/7ru3FSOYZACbmOA/kNrU7d+++IsOr2jycMhnPdArLdntcsEorZKGMRq1
         lGu/jl9AkApeuGGU4WSFTry7aTCc5Emr6F1V3stETq90+X/4bO/UiwohYsBBf63ujcB6
         q0p0RVy3Rdf8tlJzwPt0BchbEDjk60EJ7Pu4plKdsG16sxMf+ylDevDri1FuzOYMpabh
         P73/8ncVrLSheMzDv9BL4Is6/Pd4XIWxqVTM9riM994DGHMT4+VsZle+egX5pybkD+KW
         +IxISjM9cClbYZ1QzEz9HmTJQIPrwNV6ythKJFQsu/woH38B0M4RCCCu60yKRI8jpvCf
         lNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfBM46CMen+uhRBIYWO3qJW2mWb2APmF7m5uMTcqtHORGmEiThZQxSxSNWh591KLBtHKzTy/As4mMnDgJK8nmTNRS4xdVQ2FwGfA==
X-Gm-Message-State: AOJu0YwnlEtVDBe9bAVotNLyO1Z/8nNAXLHKkKDP0PXf+qardzclskhg
	x2MByRPoCZtgkQgun5S2DtFPYtncaECqkD71+IMJsbg3rLMTA9vBQ5hBoQQwylMTzsI0qjpzjiG
	kGAK86ksWBxTRpN8F2ayNlA==
X-Google-Smtp-Source: AGHT+IHxQctUGKYgd5oy7kYkF4T9KZlsamRVSF7Lno+W8mdbELZDi6ZWUht6vp6IR2OIsIspamJFWs+eE7Qt6tSYEw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:154d:b0:e03:589b:cbe1 with
 SMTP id 3f1490d57ef6-e0b545431eamr671930276.7.1722306398655; Mon, 29 Jul 2024
 19:26:38 -0700 (PDT)
Date: Tue, 30 Jul 2024 02:26:09 +0000
In-Reply-To: <20240730022623.98909-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240730022623.98909-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240730022623.98909-6-almasrymina@google.com>
Subject: [PATCH net-next v17 05/14] page_pool: move dmaddr helpers to .c file
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

These helpers are used for setup and init of buffers, and their
implementation need not be static inline in the header file.

Moving the implementation to the .c file allows us to hide netmem
implementation details in internal header files rather than the public
file.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/net/page_pool/helpers.h | 30 ++----------------------------
 net/core/page_pool.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 2b43a893c619d..8f27ecc00bb16 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -399,17 +399,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
 	page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
 }
 
-static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
-{
-	struct page *page = netmem_to_page(netmem);
-
-	dma_addr_t ret = page->dma_addr;
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
-		ret <<= PAGE_SHIFT;
-
-	return ret;
-}
+dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem);
 
 /**
  * page_pool_get_dma_addr() - Retrieve the stored DMA address.
@@ -423,23 +413,7 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 	return page_pool_get_dma_addr_netmem(page_to_netmem((struct page *)page));
 }
 
-static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
-						 dma_addr_t addr)
-{
-	struct page *page = netmem_to_page(netmem);
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		page->dma_addr = addr >> PAGE_SHIFT;
-
-		/* We assume page alignment to shave off bottom bits,
-		 * if this "compression" doesn't work we need to drop.
-		 */
-		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
-	}
-
-	page->dma_addr = addr;
-	return false;
-}
+bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr);
 
 /**
  * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2abe6e919224d..a032f731d4146 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1099,3 +1099,34 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
+
+dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
+{
+	struct page *page = netmem_to_page(netmem);
+
+	dma_addr_t ret = page->dma_addr;
+
+	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
+		ret <<= PAGE_SHIFT;
+
+	return ret;
+}
+EXPORT_SYMBOL(page_pool_get_dma_addr_netmem);
+
+bool page_pool_set_dma_addr_netmem(netmem_ref netmem, dma_addr_t addr)
+{
+	struct page *page = netmem_to_page(netmem);
+
+	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
+		page->dma_addr = addr >> PAGE_SHIFT;
+
+		/* We assume page alignment to shave off bottom bits,
+		 * if this "compression" doesn't work we need to drop.
+		 */
+		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
+	}
+
+	page->dma_addr = addr;
+	return false;
+}
+EXPORT_SYMBOL(page_pool_set_dma_addr_netmem);
-- 
2.46.0.rc1.232.g9752f9e123-goog


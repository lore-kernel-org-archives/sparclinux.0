Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B61AAE3F
	for <sparclinux@vger.kernel.org>; Tue, 10 Sep 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988533; cv=none; b=OY0EJ0r287RKVnTPHL8bHbSH0zUr+Nc+sSURd2fzku7CpTEvE1JwDlxMqMwVL3ORp0N0rgFcQp3ybanIC9bl4+4kOgp+UT4CwBK0YciLjMeeI0IXmPKTmiHlEUrOHncHGk3e+oBy713mqRWajvn9LGqzm58sGrrM84sfJ+Y3tlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988533; c=relaxed/simple;
	bh=Xy8VKEYnwSDTZv8an0rR9HKd/Tj5FfgAkYHF3vihv2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B7ZzFArQyQInn2Yi7qRAUSlHVmfK0AxHMvu/OC+n8NCeDk/PMiZKpzaxkEHzxy+ILTYXRekbO4luERi7+FRCKp9wCzlLTnP9b7fRl8hzhYZB+8GzyVZKyA0g1h3EEVFTlgt6N4NdMI5O4mLOAUyBsszzrly6Bg9QMoLNtX5u24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATHsfwNv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATHsfwNv"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4bd76f5a8so174271087b3.0
        for <sparclinux@vger.kernel.org>; Tue, 10 Sep 2024 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725988525; x=1726593325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr6gPDE1UK5B1I6Iwow8La1ZlcxSQmU/6SFdxdUBC4Y=;
        b=ATHsfwNvrfTKk+mFi4/+LHorWbqSOVBG4OlVIs1s4bu0WA2stczgVDF34saVXw6+D3
         olXRbNVN8+b8ReZq6DBsR4WC8zzp+xi/kGwZNSEzTGXnskxuUZlnw4XOaiwqc+hRAVCr
         4M4XIrVJfMC32RzuvHMvYobhittaGnD+UOFeH4ZinVxpy6eZ3ixDh+Q+8BqLTeuGnv37
         QMGaPTdPvUgUEQUdiJCAWd7ExUYCD76iiMXj+yv0yHfsP/VpfaiiAoeCb0pT+bWgQSvl
         TSi10y9qXu5XsKUSbIwpd9ODDDEpnzlk8VsbXHBaLSwZ5KtjMNU+1QAr3Fx5DamJnVXw
         ih7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988525; x=1726593325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr6gPDE1UK5B1I6Iwow8La1ZlcxSQmU/6SFdxdUBC4Y=;
        b=dNT6+AiV2iYvuG8i4cOfs/3jhr0K9KmjA+me7xgYJZyGHEVeH1FIOMJZEaUP4yQSZo
         +zaOCSZH+0liNWgbhyoLmqHB7w9XjA7Gv7Qda7WllIyknHwdGTuebo8XMG24RgrBIWVl
         pv/3nswhb5aq01W2gowRnlVKetZqIcLCyNnzQVIZQNtv6IUgOa5fZDnsKoHRT0/Oz79l
         Tkgwnoy1c/L9RBqloWc69M0jsNWXMcy9yoy3O+18+3P/Nuojva3t2zt+BArfjpMZtqVi
         Vfa2ebui+7MUC9GgLGuClF4CWG48rgE8abqblVCs+7MERKdNDMM6HStAUCtCg9XUHnKS
         E8lg==
X-Forwarded-Encrypted: i=1; AJvYcCUuVlbnbakmki5xe3wOYqQtpn1B8lQuNhzIGutyoN1bP8sE9mZtM4BgdnXIZ6t6SItwDUSe+W06LHxl@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhbOsIWziBeLuCHG7G0tO2mwK8H/SD6TVC43j1J/A1mPk+aTC
	cO7u+yhY9ApYaAnAsOevhUFqJKrwx7/tAr4WaWH1rp0OQmKyyUChhxzYJryZtaMeKd8oFkRTdAy
	qE69FE3Be7MKyS6K6kOTySA==
X-Google-Smtp-Source: AGHT+IGZCB+Bwki1p8fPYMVywna8K28oR2ffM3Z76Sw+TMtsD9U3aR4klRuEh553qX5yh3rrwgfboDT90OGw/cXyFA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:2e08:0:b0:e17:8e73:866c with SMTP
 id 3f1490d57ef6-e1d34a40ec5mr105962276.10.1725988524819; Tue, 10 Sep 2024
 10:15:24 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:14:57 +0000
In-Reply-To: <20240910171458.219195-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910171458.219195-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910171458.219195-14-almasrymina@google.com>
Subject: [PATCH net-next v26 13/13] netdev: add dmabuf introspection
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add dmabuf information to page_pool stats:

$ ./cli.py --spec ../netlink/specs/netdev.yaml --dump page-pool-get
...
 {'dmabuf': 10,
  'id': 456,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 455,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 454,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 453,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 452,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 451,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 450,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},
 {'dmabuf': 10,
  'id': 449,
  'ifindex': 3,
  'inflight': 1023,
  'inflight-mem': 4190208},

And queue stats:

$ ./cli.py --spec ../netlink/specs/netdev.yaml --dump queue-get
...
{'dmabuf': 10, 'id': 8, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 9, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 10, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 11, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 12, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 13, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 14, 'ifindex': 3, 'type': 'rx'},
{'dmabuf': 10, 'id': 15, 'ifindex': 3, 'type': 'rx'},

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>

---

v24:
- Code cleanup, no cast and use 1 if statement (Jakub)

---
 Documentation/netlink/specs/netdev.yaml | 10 ++++++++++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/netdev-genl.c                  |  7 +++++++
 net/core/page_pool_user.c               |  5 +++++
 tools/include/uapi/linux/netdev.h       |  2 ++
 5 files changed, 26 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 0c747530c275..08412c279297 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -167,6 +167,10 @@ attribute-sets:
           "re-attached", they are just waiting to disappear.
           Attribute is absent if Page Pool has not been detached, and
           can still be used to allocate new memory.
+      -
+        name: dmabuf
+        doc: ID of the dmabuf this page-pool is attached to.
+        type: u32
   -
     name: page-pool-info
     subset-of: page-pool
@@ -268,6 +272,10 @@ attribute-sets:
         name: napi-id
         doc: ID of the NAPI instance which services this queue.
         type: u32
+      -
+        name: dmabuf
+        doc: ID of the dmabuf attached to this queue, if any.
+        type: u32
 
   -
     name: qstats
@@ -543,6 +551,7 @@ operations:
             - inflight
             - inflight-mem
             - detach-time
+            - dmabuf
       dump:
         reply: *pp-reply
       config-cond: page-pool
@@ -607,6 +616,7 @@ operations:
             - type
             - napi-id
             - ifindex
+            - dmabuf
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 91bf3ecc5f1d..7c308f04e7a0 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -93,6 +93,7 @@ enum {
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
+	NETDEV_A_PAGE_POOL_DMABUF,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
@@ -131,6 +132,7 @@ enum {
 	NETDEV_A_QUEUE_IFINDEX,
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
+	NETDEV_A_QUEUE_DMABUF,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9153a8ab0cf8..1cb954f2d39e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -295,6 +295,7 @@ static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
+	struct net_devmem_dmabuf_binding *binding;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 	void *hdr;
@@ -314,6 +315,12 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
 					     rxq->napi->napi_id))
 			goto nla_put_failure;
+
+		binding = rxq->mp_params.mp_priv;
+		if (binding &&
+		    nla_put_u32(rsp, NETDEV_A_QUEUE_DMABUF, binding->id))
+			goto nla_put_failure;
+
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index cd6267ba6fa3..48335766c1bf 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -9,6 +9,7 @@
 #include <net/page_pool/types.h>
 #include <net/sock.h>
 
+#include "devmem.h"
 #include "page_pool_priv.h"
 #include "netdev-genl-gen.h"
 
@@ -213,6 +214,7 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
 	size_t inflight, refsz;
 	void *hdr;
 
@@ -242,6 +244,9 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 			 pool->user.detach_time))
 		goto err_cancel;
 
+	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
+		goto err_cancel;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 91bf3ecc5f1d..7c308f04e7a0 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -93,6 +93,7 @@ enum {
 	NETDEV_A_PAGE_POOL_INFLIGHT,
 	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
 	NETDEV_A_PAGE_POOL_DETACH_TIME,
+	NETDEV_A_PAGE_POOL_DMABUF,
 
 	__NETDEV_A_PAGE_POOL_MAX,
 	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
@@ -131,6 +132,7 @@ enum {
 	NETDEV_A_QUEUE_IFINDEX,
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
+	NETDEV_A_QUEUE_DMABUF,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.46.0.598.g6f2099f65c-goog


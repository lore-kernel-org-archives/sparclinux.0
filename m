Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D6158872
	for <sparclinux@vger.kernel.org>; Thu, 30 May 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100185; cv=none; b=VptngSxMb5BxU5jTJRP2cu3go21vpLKrql8wvwHK08n3/4D8Y0LX7NA7jHSbRgQdMyhcLpt880AU7Ye/a5XNR5O6q1ofErc8rDXhT6CP369CWFN8u+ltVmwBnArrE9rSU6lp75IMgmLv3ZkcZeMi6g/2aTVPF4rOBF9Ds38REso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100185; c=relaxed/simple;
	bh=c10vRAymnFEiD+J93cVDAwHMQipnrIDVb/DDxIZNtws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W5K4ZsfQ0eCXQaUEPeCtlXejYguhnuHCqp8vEP3Ti5KqQY0MbWiyhWLltMZdr7mWHFOpaLXiCAqHIfllFJYInEypT2ladMSmrhPc+PSsBcOG36s1PtsWjt0DITDhTx9rWaDCJPBjGH+19Xld8nsgDYswYzXbYMFxrxe2/Mj1fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQx4PI6A; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQx4PI6A"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df771bdee6bso615321276.3
        for <sparclinux@vger.kernel.org>; Thu, 30 May 2024 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717100181; x=1717704981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaEF0DqCm5CQkZB35PjEH+gJQ00Kx0ca44YJl8gv7Yk=;
        b=DQx4PI6AEZlcqseS7nlUwWauzeA7vJjByZP7oeq8vxzm+uKFmIgbyyTxwbxnV44oUZ
         cazPHOzBC0J+Q13MZNU/3nJCv58aYB4kQton3B2ti/jRfoXWj/foeQ/32ueZWclPNvNL
         KXje91b/2uOMi0QH/InptkH/4kjVkyEYz8aLRUy2tdW29fJ/J8BJNhb7QmYPelTL3/Nx
         UKnSqnwFatxq31OENazAzJOZO3Dgx2Js6DUGFQw+vzTQ47PlICH30DgiNunY5p1J9o+9
         MpdjQs7uIFyEoVH+6NWX9EUn80vJKWOieKaedtxr4F0JzHGffN6xR3ORT8g1UL+JymBu
         k8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100181; x=1717704981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaEF0DqCm5CQkZB35PjEH+gJQ00Kx0ca44YJl8gv7Yk=;
        b=REn9byQhY3/QJyH+D5CHlePN631Q33mFu27uUK2uMOq9rIkSAMLkIwagUsCzRmoB5u
         3pIKWbVD2JlZC0RIcHdHqDDjcIQzpCKD4tyxs0jhVOLrlk9CJMmJD24E7dcFGfruDqlB
         w/VGJWpbAVeTPFD58HVxYZTyvMeY62TY+Y4JgvhwRohcMy6bKmP5YRHiWiQ5/jEsyuMt
         p9Ydii5bNeqr/OHzoo4Z73nbtrfdEViycOWjwEksBx1BFvjsXWFMOtsKrPej6XwzKX9l
         vpnlOHon430AYzL3NSeUODEYJqj9qd4tpJQOqa5+VylVY4TOlfosKJBi+0w9oxhh0B11
         WPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDm4sEXwYyn/giDlOs3sSZTgEgviIBHCsaL/kqiqQ80gfwej/SyHuTksPYgT7n3c+pi3QpHjG0iEXO1tNlVE6ke6Lte+2T0UiNcA==
X-Gm-Message-State: AOJu0YwKYqj/EDXjjmy90GBkrapkP+srE0d8niKCE1jXlym80iM3XmYE
	T7v3CTuUh6l5jQkcUYHTChHIvWJLLd8dsg2+qXTLuLT3pXm0j+6Rc5BtZ8b6iFayrgmucAXGWmD
	3/us63OeU0tIzhSYCv2vDLQ==
X-Google-Smtp-Source: AGHT+IHQSp6ih1zR7n3tsFdazsyJvnckERFqUtnhikqH/B2yNteq1+Esq+3zctzZclvpF1Z7GTwU7qeCMRAP5FzJOw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:154a:b0:df7:6b9d:21fd with
 SMTP id 3f1490d57ef6-dfa5a68894emr293702276.8.1717100181353; Thu, 30 May 2024
 13:16:21 -0700 (PDT)
Date: Thu, 30 May 2024 20:16:00 +0000
In-Reply-To: <20240530201616.1316526-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240530201616.1316526-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240530201616.1316526-2-almasrymina@google.com>
Subject: [PATCH net-next v10 01/14] netdev: add netdev_rx_queue_restart()
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
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

Add netdev_rx_queue_restart() function to netdev_rx_queue.h

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v9: https://lore.kernel.org/all/20240502045410.3524155-4-dw@davidwei.uk/
(submitted by David).
- fixed SPDX license identifier (Simon).
- Rebased on top of merged queue API definition, and changed
  implementation to match that.
- Replace rtnl_lock() with rtnl_is_locked() to make it useable from my
  netlink code where rtnl is already locked.

---
 include/net/netdev_rx_queue.h |  3 ++
 net/core/Makefile             |  1 +
 net/core/netdev_rx_queue.c    | 74 +++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 net/core/netdev_rx_queue.c

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index aa1716fb0e53c..e78ca52d67fbf 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -54,4 +54,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 #endif
+
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
+
 #endif
diff --git a/net/core/Makefile b/net/core/Makefile
index 62be9aef25285..f82232b358a2c 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
 obj-y += net-sysfs.o
 obj-y += hotdata.o
+obj-y += netdev_rx_queue.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
new file mode 100644
index 0000000000000..b3899358e5a9c
--- /dev/null
+++ b/net/core/netdev_rx_queue.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/netdevice.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
+{
+	void *new_mem, *old_mem;
+	int err;
+
+	if (!dev->queue_mgmt_ops->ndo_queue_stop ||
+	    !dev->queue_mgmt_ops->ndo_queue_mem_free ||
+	    !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
+	    !dev->queue_mgmt_ops->ndo_queue_start)
+		return -EOPNOTSUPP;
+
+	DEBUG_NET_WARN_ON_ONCE(!rtnl_is_locked());
+
+	new_mem = kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_size, GFP_KERNEL);
+	if (!new_mem)
+		return -ENOMEM;
+
+	old_mem = kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_size, GFP_KERNEL);
+	if (!old_mem) {
+		err = -ENOMEM;
+		goto err_free_new_mem;
+	}
+
+	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
+	if (err)
+		goto err_free_old_mem;
+
+	err = dev->queue_mgmt_ops->ndo_queue_stop(dev, old_mem, rxq_idx);
+	if (err)
+		goto err_free_new_queue_mem;
+
+	err = dev->queue_mgmt_ops->ndo_queue_start(dev, new_mem, rxq_idx);
+	if (err)
+		goto err_start_queue;
+
+	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
+
+	kvfree(old_mem);
+	kvfree(new_mem);
+
+	return 0;
+
+err_start_queue:
+	/* Restarting the queue with old_mem should be successful as we haven't
+	 * changed any of the queue configuration, and there is not much we can
+	 * do to recover from a failure here.
+	 *
+	 * WARN if the we fail to recover the old rx queue, and at least free
+	 * old_mem so we don't also leak that.
+	 */
+	if (dev->queue_mgmt_ops->ndo_queue_start(dev, old_mem, rxq_idx)) {
+		WARN(1,
+		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
+		     rxq_idx);
+		dev->queue_mgmt_ops->ndo_queue_mem_free(dev, &old_mem);
+	}
+
+err_free_new_queue_mem:
+	dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
+
+err_free_old_mem:
+	kvfree(old_mem);
+
+err_free_new_mem:
+	kvfree(new_mem);
+
+	return err;
+}
-- 
2.45.1.288.g0e0cd299f1-goog


Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE355158D70
	for <sparclinux@vger.kernel.org>; Fri,  3 May 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767060; cv=none; b=PJawcpGPdmqqJH+5EF3lB698ZEN4jcyGMJkiAW4Z5DWwF8jMsjbmwOCVrWwkezXzqvX7lpNe2pEJDAifwjs1F97YQeIPUuH4i/7LPDuMKEthYriiCgOaZ91z3HKm4Ky4BgzoGx7j5yusz+dJugJ8NF6AZuwRVhMKgNFtB8GSk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767060; c=relaxed/simple;
	bh=atCvgdMV0JNn9Qp/m9GZW6Z7D46Y3/r5gcCPjNPxDaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPegeWXAjnODJcEWry6V/ttkn3TkPhvhIKfHDOpNg/A9SPSKiSMxE5tJj8ig3ZzoYkQsOo0gRUaAOExFnCQwVD/u1agOgZPITE1j/4rzH4CM4i/hvRdTFsXYCC5R/hIExoikJtBGxX5WB8qfXhJ2wmPrQMfZxgVM31Jt/xJW/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXraE1Cg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXraE1Cg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a524ecaf215so532266b.2
        for <sparclinux@vger.kernel.org>; Fri, 03 May 2024 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714767056; x=1715371856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atCvgdMV0JNn9Qp/m9GZW6Z7D46Y3/r5gcCPjNPxDaY=;
        b=BXraE1Cgqyr5gr4R1yA5bOlellj2XeZR3ELw04tSwgwfVv7Tej6f7AujDIMDuINB9N
         q2nEFO9qOEOvh7HiQReLkvkWl9rakjWPl9SNFurQZQAs8DOlxuJjeYtxzcy6KEPNqqVf
         mwGAzmTZDZUQIyusOpqki566NwoJRymeYhZF0faPskN7YR9xUI8DTCq7DVLv/ZuGgRBy
         VfUrZztINEbwkYEdTK3UD6K5jJ2XqM612KvTehIfS51KV69MgrJejg+oDxSW3IlsJPsO
         jOH3BSBbOuyK5XYgLAnbMwFMEoHPp/g5j9BgwCfWSYACT8UAkV3w6IWQfdiM9MX4ard4
         eLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767056; x=1715371856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atCvgdMV0JNn9Qp/m9GZW6Z7D46Y3/r5gcCPjNPxDaY=;
        b=L5lHFIGEv9bPkBO0OrtXt96m8hnZchoOfEIwz6kKdEjJjUEtISkDhQ0+/dNqLFiiOb
         pMmZjKkiru5cjPugq2QyfJwnma1kAzeO7qIDZ4p64L/IGnTTz9YrdkdVYFY0hQlOMYYg
         vdzxMDW4HHxgXnlwizwvjjw6GHKZ+SjwevqYDucrY/5eQvzDr7J3OWRZOsJvZfjuo4sy
         +9jRPtEiDxfLMko0lQvt/lxWOdHcVajI7qufoG0rdzk+LOcrZJr2MRgQbuo3puBRlod8
         A9KPNTJWN3ZHz1v9DdrbFwZUfdgQ660mt4Jm8WDR9kp9uplkQ5YmbteADd5j6r59iRmm
         WA0w==
X-Forwarded-Encrypted: i=1; AJvYcCWr8HZTvIq+GLTe2TxYU50+IbWjnz1NetQBVi7kp3X3n+qqEttQjSQwzUxVhXvgPXSBj5mdmdPjuO7/IdyrBoB7PBo2YoDII121fw==
X-Gm-Message-State: AOJu0YwQ9r+PN288aT7Q7E/M5SZF2v/Zvs3qqDSN4YsR0M5lv4BSu1ly
	g0xmOD/uFkQ23YI0E3LjN+nqLf3ZnbE8VnDlO+LB5Uvva9Fyz8l2agpDJsDcNI9ZdEuv86NMQO3
	LgP4tzhpuso7dR3qOp1Z0S269p5e1U0EglCRV
X-Google-Smtp-Source: AGHT+IGWuTH3tkleUzlLfpne/Dggcuo50hlED+Ywh+UOAOcbaWh6EvDDw4vd2uLlNQ7vtR/GRuLWEPXod8Vuv8D8Zd0=
X-Received: by 2002:a17:906:29d4:b0:a59:165f:87e6 with SMTP id
 y20-20020a17090629d400b00a59165f87e6mr2459058eje.48.1714767055895; Fri, 03
 May 2024 13:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com> <ZjH1QaSSQ98mw158@infradead.org>
In-Reply-To: <ZjH1QaSSQ98mw158@infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 3 May 2024 13:10:44 -0700
Message-ID: <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
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
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply.

On Wed, May 1, 2024 at 12:55=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Still NAK to creating a=E2=85=BAbitrary hooks here.

Is the concern still that folks may be able to hook proprietary stuff
into this like you mentioned before[1]?

I don't see how that can be done as currently written. The page_pool
grabs the memory_provider_ops from the netdev_rx_queue struct managed
by core net stack and not really overridable by external modules. When
the netdev creates the page_pool, it gets the core-managed
netdev_rx_queue via something like __netif_get_rx_queue() and passes
that to page_pool_create().

We could make the memory_provider_ops even more opaque by only
allowing the device to only pass in the netdev + queue num to the
page_pool_create, and have the page_pool_create query the
netdev_rx_queue struct, to make sure we're getting the one managed by
core.

Long story short is that as currently written I think it's pretty much
impossible for someone to plug in a proprietary out-of-tree memory
provider using these hooks, and if desired I can change the code
slightly to make it even more difficult (but maybe that's pointless, I
don't think it's possible even in the current iteration). The only way
to get a memory_provider_ops in is to seek to merge it as part of the
kernel with community approval. Is there something I'm missing here?

> This should be a page or
> dmabuf pool and not an indirect call abstraction allowing random
> crap to hook into it.
>

What is the suggested fix here? I do something like:

cp net/core/page_pool.c net/core/dmabuf_pool.c

and then modify it such that the net stack maintains 2 page_pools?
There are a lot of cons to that:

1. Code duplication/maintenance (page_pool.c + dmabuf_pool.c will look
very similar).

2. The hooks enable more use cases than dmabuf_pool + standard pages.
In addition to those, I'm thinking of (but not working on):
a. Limited memory pools. I.e. a page_pool limited to a certain amount
of memory (for overcommited VMs).
b. dmabuf pools with GPU virtual addresses. Currently we seek to
support dmabuf memory where the virtual address is an offset into the
dmabuf for CPU access. For GPU memory accessible to the GPU we need
dmabuf memory where the virtual address is the GPU virtual address.

3. Support for multiple page_pools is actually more proprietary
friendly IMO. Currently the page_pool is internal to core. If we start
adding additional pools we need to have some uniform behavior between
all the pools so core can operate on memory that originated from any
one of them. In that case it becomes actually easier for someone to
develop an out of tree pool and use it from their out-of-tree driver
and as long as their out of tree page_pool behaves similarly enough to
the decided uniform behavior, it may be able to fool core into
thinking it's an in-tree pool...

[1] https://lore.kernel.org/linux-kernel/ZfegzB341oNc_Ocz@infradead.org/


--
Thanks,
Mina

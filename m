Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F7323D
	for <sparclinux@vger.kernel.org>; Sat, 18 May 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715992774; cv=none; b=V5Wfw3yR2WV7IwzzwbWiqUd2eJ9VWL8tujcTX2arTgYDFkh7789+kah7CDstrSi0QRbYeFnkwEVfCf6xNzDS7YzrCEJ3mkfOxuZ/L3bKl6B6WCYcLED/47HOuF7g4peL6r0ilStORuU9nUDnkTuPxZvspkHhl3XU2hJ9VXbyQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715992774; c=relaxed/simple;
	bh=4V5YW8ORGMY45KRj8UEqSm59pF8Y+sc6mDeE+TSeGJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR0XZj2/WmS4MvBiLKw1GXzSCDiJcrJgPT82eDHsMLMpl9Qz/Q+D5vuMfznhDyOrcw2omaD/2y6VIkzQi1Rp8NCxzWtRY7DlOCw0SRI4yKqEotgIBOIO5dLRaoZy8F289FMS6FBNyBRuhdUDUyqt5qG3SjkE2nM83qQJhF009qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=SV2zemg5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="SV2zemg5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee42b97b32so26031635ad.2
        for <sparclinux@vger.kernel.org>; Fri, 17 May 2024 17:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715992772; x=1716597572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p7Punv+O2VI5RKAkHRkhtEk7CBj9yRK2PJX5XN6bfhc=;
        b=SV2zemg5NtIR3pbXcUpjQL4Nh2uV808bM0bYra4XbVqoECYENJz6/Yy1du6GUsBF1T
         XjClNZyHgkq1IjzGsNu0VF4KSRcFvP8duWW93pNhihxONKxIBHEuEju184pzDGSNNupq
         ib3YMvRdDHjiHmp2OxcZgusnPxfFWYkd34Nlw+eS/M5SIsLUf3Mrx9wPF3j4JbN0L51J
         8Ns52iIbDMMJzhPw7VAE6tB2RCkaU9f1rM9auoIgPX19Bn4lqARdC5AzZbrjVYBG9xPX
         cdNuEoJX1TmbwOv4k+7AFSI4ow5gFWRUrYzogvoH4IJNgoo7XBVgU2ba15ADfeNZaYsV
         sGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715992772; x=1716597572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7Punv+O2VI5RKAkHRkhtEk7CBj9yRK2PJX5XN6bfhc=;
        b=RIfm9QcG4UEoYCcyh+HVNCwYAzPBcYyfol/BLPK0Qvl8i/OfULSw9cVvcrun4oUWM2
         0FchcSa6L3vFZ8Eexq7wiXmmaxJMz1BGz6DV4pXmgsY7E3sMzPBTCq+FDEk+KGlqrIOh
         O9tWhpUCnOfXyaYEHVue0EuBMBDZ/cjp6LzM6HnhvkATyCGXnYlG9ZBpxGZdQ6OVpDaQ
         MzAQp9vaf5DRGjtW4rkcY7yqbqfNpDviH2umjx+hscxzXfStsv5Lr+cIhWFwfEyzlb1t
         vUprs8O33Y1BobdXzPh7xMDov9baSHBTALQhJG+11BHm1JEKP/h6eQORfU0AV7vibapm
         AaPg==
X-Forwarded-Encrypted: i=1; AJvYcCWSe6UqRmzv8OD0xX+XO3/Ykq+7woIkcmReUgpVSvCXZXdHfrk1gLJNUXBhdSAUYQyH1o6wQ5/pzwsgWkKvTnt/6TVmz5wwf2ehTQ==
X-Gm-Message-State: AOJu0YwFxtyA5cDHwZz5XepW7pDfLrDpGNniJ67Tb8eAfWOyma37muof
	MqiNM/qYqLWDHzWLDKXiS+Sq4Vzr1oqXwoA1mTIV+CymOneRhlozZJy/1qNBKlA=
X-Google-Smtp-Source: AGHT+IG2kizdOiSw0uylPEq0qK5Nujj1quEtxgB2wxc39/tXdkGx33RSfpvHjRCh3dNNGsAUN6Msjg==
X-Received: by 2002:a05:6a00:1397:b0:6e6:89ad:1233 with SMTP id d2e1a72fcca58-6f4e02a6150mr30537733b3a.2.1715992772166;
        Fri, 17 May 2024 17:39:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::6:9fd9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2bccsm16503658b3a.170.2024.05.17.17.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 17:39:31 -0700 (PDT)
Message-ID: <090be3c0-42e6-4b97-8b03-eb64b06a2911@davidwei.uk>
Date: Fri, 17 May 2024 17:39:25 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/14] netdev: netdevice devmem allocator
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-6-almasrymina@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240510232128.1105145-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-10 16:21, Mina Almasry wrote:
> +/* This returns the absolute dma_addr_t calculated from
> + * net_iov_owner(niov)->owner->base_dma_addr, not the page_pool-owned
> + * niov->dma_addr.
> + *
> + * The absolute dma_addr_t is a dma_addr_t that is always uncompressed.
> + *
> + * The page_pool-owner niov->dma_addr is the absolute dma_addr compressed into
> + * an unsigned long. Special handling is done when the unsigned long is 32-bit
> + * but the dma_addr_t is 64-bit.
> + *
> + * In general code looking for the dma_addr_t should use net_iov_dma_addr(),
> + * while page_pool code looking for the unsigned long dma_addr which mirrors
> + * the field in struct page should use niov->dma_addr.
> + */
> +static inline dma_addr_t net_iov_dma_addr(const struct net_iov *niov)
> +{
> +	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
> +
> +	return owner->base_dma_addr +
> +	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
> +}

This part feels like devmem TCP specific, yet the function is in
netmem.h. Please consider moving it into devmem.{h,c} which makes it
less likely that people not reading your comment will try using it.

> +
> +static inline struct net_devmem_dmabuf_binding *
> +net_iov_binding(const struct net_iov *niov)
> +{
> +	return net_iov_owner(niov)->binding;
> +}
> +
>  /* netmem */
>  
>  /**
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index d82f92d7cf9ce..1f90e23a81441 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -54,6 +54,42 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
>  	kfree(binding);
>  }
>  
> +struct net_iov *
> +net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +	struct dmabuf_genpool_chunk_owner *owner;
> +	unsigned long dma_addr;
> +	struct net_iov *niov;
> +	ssize_t offset;
> +	ssize_t index;
> +
> +	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
> +					(void **)&owner);
> +	if (!dma_addr)
> +		return NULL;
> +
> +	offset = dma_addr - owner->base_dma_addr;
> +	index = offset / PAGE_SIZE;
> +	niov = &owner->niovs[index];
> +
> +	niov->dma_addr = 0;
> +
> +	net_devmem_dmabuf_binding_get(binding);
> +
> +	return niov;
> +}
> +
> +void net_devmem_free_dmabuf(struct net_iov *niov)
> +{
> +	struct net_devmem_dmabuf_binding *binding = net_iov_binding(niov);
> +	unsigned long dma_addr = net_iov_dma_addr(niov);
> +
> +	if (gen_pool_has_addr(binding->chunk_pool, dma_addr, PAGE_SIZE))
> +		gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> +
> +	net_devmem_dmabuf_binding_put(binding);
> +}
> +
>  /* Protected by rtnl_lock() */
>  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
>  

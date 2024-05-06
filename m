Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E215A5
	for <sparclinux@vger.kernel.org>; Mon,  6 May 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714955364; cv=none; b=om42md5aFXkosv+lGrKvsWUos6anSLubnJL2g2pRMKsLOC0LdODNFMIxYiti8TYLpcl8MFObu6Eig/iz68ft8S78PI05E2cG56cPuSYYqfU/H3C+91HKFZwrRXJ6vWm+UHWiUJHAiTwkm498svuwFSMc6uy5+yqVlraU+xlUwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714955364; c=relaxed/simple;
	bh=7p83fI6SjhbSz9whdN8AjeYm5Iaq6UXmW/wjThWyv6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbmiakXWv3b3pTYqdgIVw8rsdxxStFDIDFb++tEk21pwhOYspHg89VFFU+fAU998f1dRNj88X1aQ+YSKA5BXjP8gr3B5eb08Iw9TlsMn5/vOrmnefwYHjZ7q7Mq5A07kqBCT+YI4kXZVBRYNhrx+1s24sK+qDkKd5I8wkIOIoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=YJtQ3EPk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="YJtQ3EPk"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b27eec1eb1so981767a91.0
        for <sparclinux@vger.kernel.org>; Sun, 05 May 2024 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714955361; x=1715560161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTixdwfAlIVssw/yTwe1uZ1trqj6K9Ho7zGTIsCsG3k=;
        b=YJtQ3EPk7IxrNvgo8weclRLgIUIWkSOI2Uep1o1M/rk9e0dB+mVfcDL2Ra/RKgbRaV
         4yD0nNAz17zHnC1JbqzasjATt3Y4kUqFfBfl4uDx/zyyAwmCgdWBqfnXG64JOZ3VVasD
         TpWrwpoJPMZ1aCGn4xBszZrjTzvv5gHLPW4FLW7M2xKyeRN3dmeqwv7P7Qzj6PulULEp
         iKKq9LW6PdJR11ebmc1NoRMdfQ6vYQYYHA7xQiZMqlhAGok5r3mf8gMd5KZKadxtoFqx
         EMNG1nXwcBwffehAbXoAJ9b4BN0JZNUl2iEcpz1iMRyOz+EEFNblqZD7QukB/0M0HXcx
         nJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714955361; x=1715560161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTixdwfAlIVssw/yTwe1uZ1trqj6K9Ho7zGTIsCsG3k=;
        b=Rym7vwnh9cgCMKoRArTyqvfpG9QxrGXNrEcQ9q3E5bmCxHy3sBCG4NGXKFC4vORZQv
         7ZL/y6ujdNlyBK67s/abNFEjZ2UmmrB2XamN56ZAQqSLGxGEgJAURVVvqAotsNUdI2Sk
         LSHSseWkZ+qK7n4cGW/Y0A2zZw4RloxG0iG97DN8wQlMZdrPQVPmme3yf2sHRwMcRxiJ
         5AVgZlrZ8c7T5BXgh1AF7ZC8NCUrP+SyvtVLKrtzxeCGWOaqpeUiUVXIpfMfl3y9SMph
         pjUNQGSCgEKMDu0oZNZUvo8iSnuP7UqYP14ZP3+havoHxMVIXIPBn1aSoxbWqLvJjzr9
         K3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO8ri/p55inGIb8SeREl/qn10uMjg7CaL7t83ZtxSDW5pPo0pJXHWSITgJwTWXp5TZ17PIz5MfYoQHJMFwomq4OVsz8l/3kjr/tw==
X-Gm-Message-State: AOJu0YzaSYGg4PZM6ymCqmg33rgiQ6Bxd1STv2Bg4CXLeyul1wCn3EcT
	m0ndRG7Kv6kdToXpVCHxM5Al/+MAiA1FvuHDIbVWlQCvMTODmbkNK2hZufRiec0=
X-Google-Smtp-Source: AGHT+IFapiyynwMzWBFC3qoHSlJe6Vp0gcSIQLTrnjL4T2m4HyoHAt77UaMOEYoyby7VMZX56YX6rQ==
X-Received: by 2002:a17:90a:d30a:b0:2aa:c2ba:3758 with SMTP id p10-20020a17090ad30a00b002aac2ba3758mr8212757pju.42.1714955361360;
        Sun, 05 May 2024 17:29:21 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090a710400b002b1314ba8c0sm8708252pjk.57.2024.05.05.17.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 17:29:20 -0700 (PDT)
Message-ID: <306cf793-6f96-4a22-aca0-53c0ccefc0a1@davidwei.uk>
Date: Sun, 5 May 2024 17:29:18 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Christian Brauner <brauner@kernel.org>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Florian Westphal <fw@strlen.de>, Yunsheng Lin <linyunsheng@huawei.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>,
 Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Richard Gobert <richardbgobert@gmail.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>,
 Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-8-almasrymina@google.com>
 <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
 <ZjH1hO8qJgOqNKub@infradead.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZjH1hO8qJgOqNKub@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-01 00:55, Christoph Hellwig wrote:
> On Fri, Apr 26, 2024 at 05:17:52PM -0700, David Wei wrote:
>> On 2024-04-02 5:20 pm, Mina Almasry wrote:
>>> @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
>>>   */
>>>  typedef unsigned long __bitwise netmem_ref;
>>>  
>>> +static inline bool netmem_is_net_iov(const netmem_ref netmem)
>>> +{
>>> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)
>>
>> I am guessing you added this to try and speed up the fast path? It's
>> overly restrictive for us since we do not need dmabuf necessarily. I
>> spent a bit too much time wondering why things aren't working only to
>> find this :(
> 
> So what else do you need?  I was assured last round that nothing but
> dmabuf and potentially the huge page case (that really just is the page
> provider) would get added.

I'm using userspace memory so having this gated behind
CONFIG_DMA_SHARED_BUFFER doesn't make sense for us.

> 
>>
> ---end quoted text---

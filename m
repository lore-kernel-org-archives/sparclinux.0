Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59664D51E
	for <sparclinux@vger.kernel.org>; Wed,  6 Mar 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709692136; cv=none; b=oFJAEE/M0MMj1FxKMJXhEZE3jDY5uup3cxUpPfvGET8otgJd1A8rIXbP/aBcMwTh8iYgDUf03ASmW4Cb7TprrKj4UO0hrJwS7AWFFRawYxR2nQvFzx30Bai2wc8jmo0dA67ZGy0NoDHVlM78caP1rMpFLsmaTjKlLBo5Db6HF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709692136; c=relaxed/simple;
	bh=m/4/IJpnreuZGBCjDFZuh5CJChe0Zp0mf+/fUUyVNyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6mAvMKijx7370rp7k8oS85jrUZb3FzACVQdKmmkasW0Y2DVYAyUXCKtNJV74ciHmWjFkOAm72DaYozt/dMFhZZQ8vjyMGqfFaQsCIll5rg47Hy5smeGdA+fdlW0P0yD3z8JTQGTE5Abx9q6ZITB/P/Pi/+k5hX7vTE7GChguw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=tXzN2w3m; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="tXzN2w3m"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1e992f069so178886b6e.3
        for <sparclinux@vger.kernel.org>; Tue, 05 Mar 2024 18:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709692133; x=1710296933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9CloCqaM+25WoaR2YknpneBnZb2s33DuZ5EXKAJgUk=;
        b=tXzN2w3mIA42+kxiYmI+IfLVus4l/QCyp13ANiYCaN2AX0ORMGh8eFZyBZrHwi5+ui
         zNdIkjkiBk4A/hgNMWzvhoZCVZgub5eQsDzmq3IH7LIsjQRrvMfh2CRMGVf8ialf+Rus
         nghzApmYQfTLUlMYRSXbb4x6B6akvEuK4rNb6WwQoK4aLQOK0EG+oA4Ab7xlOOeaibDg
         nJSUHhZ9ODRVCyFEvPMgBTKDGO9DRMtkgCfGe4EIFAsUKHZm1wpITxZLA3udaKd58MVY
         6IouXTOA0w+XUEzqhiMWwJtLgVug5qR8dVcL0sonjarAz3MYOIYP8a1XnRJ4sV8i2/vC
         ncEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709692133; x=1710296933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9CloCqaM+25WoaR2YknpneBnZb2s33DuZ5EXKAJgUk=;
        b=NeqnVxPPvz2HVs7j8eauAuIWzWqg0Q7bHm4HTcPOgfvE98WLS6f+HvaPySU5n4go5I
         BR5GzK75WZ4eBBPv9buUGCewDisbDJbjUxUWqUpKOz5R5RqHCjw8GafnRocZmGU+3Fd2
         I5hNjtQF2DknZBUCvADoZzlksrN/KMBchtDbYOYEimUkQZA8zqzdeq+tL34SfXqza3+u
         cdQAQ6rGgWI8kaIJID6ZKDUCGD7tl4z37QYRIRdt6CJ6NsYlWuJozsY4FLSTZ5PmnNXq
         nFR5DMhVH1vWE5Gr/SmSX5eR5NANWozaKgxou5SOhN6jhe5wLKX7O/q+bweTEVrPpJYt
         F4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXQA/XPDAXW5E6hlfEpUCOfSwby01FN6iMp7g+wR6oCyaq2dt8BP74v0gbK5Yi6mN4N8UefISGJIOVjeZooPbR8MY5J+poVBl+WhA==
X-Gm-Message-State: AOJu0YxSpXG3v/WsAaM/UZtvGOeIpZufxJvHfOFwwBSFSF5roL2KM5L+
	uLgwnHBqEUN50hjwKzeLAXaZ2mq3shfPzDrIEYbDlmnd3fBKgZGV0JM6J9CCLw4=
X-Google-Smtp-Source: AGHT+IHKixed8Mkgk+0mpRfXfdBzYVdPnWZ0ptxrRYAk7Gk8YnML1zfyWGAr7RcPhYJE96tLslzelg==
X-Received: by 2002:a05:6870:1786:b0:220:8d17:6ebd with SMTP id r6-20020a056870178600b002208d176ebdmr3863595oae.42.1709692133363;
        Tue, 05 Mar 2024 18:28:53 -0800 (PST)
Received: from [192.168.1.24] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id x35-20020a056a0018a300b006e5bdc19842sm7873904pfh.73.2024.03.05.18.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 18:28:52 -0800 (PST)
Message-ID: <383c4870-167f-4123-bbf3-928db1463e01@davidwei.uk>
Date: Tue, 5 Mar 2024 18:28:51 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 09/15] memory-provider: dmabuf devmem
 memory provider
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
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
 Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-10-almasrymina@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240305020153.2787423-10-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-04 18:01, Mina Almasry wrote:
> +	if (pool->p.queue)
> +		binding = READ_ONCE(pool->p.queue->binding);
> +
> +	if (binding) {
> +		pool->mp_ops = &dmabuf_devmem_ops;
> +		pool->mp_priv = binding;
> +	}

This is specific to TCP devmem. For ZC Rx we will need something more
generic to let us pass our own memory provider backend down to the page
pool.

What about storing ops and priv void ptr in struct netdev_rx_queue
instead? Then we can both use it.

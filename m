Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853C19C54A
	for <sparclinux@vger.kernel.org>; Tue, 10 Sep 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982739; cv=none; b=XhoGn48qYOlmHBXdNe3Y6tBvpM6sZp5rZFkEwOVcHVhVkENS4+axClyANwEhsyPznMszuKJ39baiBvL3RLAIhdY87Y1CmwOr+KPYyd4GDroVC8ZB4u3DE0cHYtjOaRfpqp4w+x4ySWEIjnA1NdT+0s1VJLg2GUs4UhXEYPoi5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982739; c=relaxed/simple;
	bh=oCjdkvGBXYk951UuNZ8GUxFDU3TLEafF/eKU6VJhJjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOcZMJpFC+HCbxCbEVCLLd2XFuBHaIXRh862abWTZhYix06Phg4KQ/MiCN/BDw+lVNBgP9/zAU+ub5gKNaKWaB/gK75krbn3I3RnYlLwqbJbgBowO1mIBV+1LLx1ZhXx7BTPRHEpNV4QmcXLoEbdruCcC08rzoonV5YxtT1gSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrXvSgil; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrXvSgil"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4582fa01090so300251cf.0
        for <sparclinux@vger.kernel.org>; Tue, 10 Sep 2024 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725982736; x=1726587536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gszVQrHTml2s4rQX/N3KISfWtIKCjIZkEmtrFN+rLM=;
        b=GrXvSgilpWPDTzYZ9WABiQnJcvcxeBR4bm9wsuD4lVoyCFmn4tA8tyIqlbn3NDhtnn
         Fb+3yNQxZ9V5xDPLtYREJm0lw4h7K0Rb6SyRAXHhMNvDEZP2U1aSz2X28F6hzxZbfqHv
         icxm2c7yOJTBZ72I32Oc7hKkV6kVfNgUmgjNa94lEo1R0sGHmyrsGpCQdgbWdcirjeAB
         Psog1zEKxDmlyl1nf/Qmx7p5/lT15i6QKlnbX6Yk0Y4u1y0vmH5c60tEwsY3GV/f5e16
         AV+0L13zNQiReNL+oSFisUKmIYwvYFa4DTs73zRv2+f3St49KEhoPnaEMo1FVb0vovyC
         nAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982736; x=1726587536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gszVQrHTml2s4rQX/N3KISfWtIKCjIZkEmtrFN+rLM=;
        b=ilpL/w59RyRctZCd/IZKSz3gGATtlzKSNXxXruomuecwje3czm/rKJ+v8jaMsvARCo
         9rU+PB4thi7sZ6IC63Zd5WasHjaq6OEsMFeikB8ipzU5tqLkcDCfHsCftYTMcXnWNCgJ
         DGc/SZuj9LpKwXyhzD1XYi0V0+rz6JzRCPbwNZ35qynJo+2fOc+hCQd/B4FNM1pEXg8c
         rEAGa30Q4xYLzZoxto11S7CTSkRvTdhuyIv0UpKkJ1b2BLfZUQnsn3lFfFwG3OfONgZE
         RAPi0s/63uweCcLVk2zcSlvEELuhGFNhXnEOJzeYd4hvP0SIRjbR1oReHWkCnmbWSnIf
         W90g==
X-Forwarded-Encrypted: i=1; AJvYcCUhKjFoPEg4wN2+crPAZwDh82X/RvJGsspBh9KDQbuwSHHWX9UNNUSQ7FVw2qQOW1z7w1f/YU9hoIxu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx524r8iiSjdaGip3T0LDqQlxZs+MW9n8hIc6n0Vl5H8lDBR3pr
	MSRn0OLTbobTJip1LeI/yJGkKXDoMCFWkRYo84lIQ9WnDqHSfFat74mbqb6jX9VD0wrM0SCE03O
	LaO5YSEPaHjo7PgO/IKv2/wnuqys+gkVvQBpM
X-Google-Smtp-Source: AGHT+IEK6weRhBb+6I+yqObyHVaZqmcs2wOCh/JwTg5EmvszzOI8s/itZSBxrrNFolb48wNjfmGjViIMiDzaN91ZR8I=
X-Received: by 2002:a05:622a:13ca:b0:447:e0e1:2a7b with SMTP id
 d75a77b69052e-4583f0063b0mr2792721cf.23.1725982736186; Tue, 10 Sep 2024
 08:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909054318.1809580-1-almasrymina@google.com> <20240910080237.2372cfa6@kernel.org>
In-Reply-To: <20240910080237.2372cfa6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 10 Sep 2024 08:38:42 -0700
Message-ID: <CAHS8izP4EO3t=7-n2Ok5pgKe+JjJV+T3EH1PaTW=YU234kEpGw@mail.gmail.com>
Subject: Re: [PATCH net-next v25 00/13] Device Memory TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Sep 2024 05:43:05 +0000 Mina Almasry wrote:
> > Device memory TCP (devmem TCP) is a proposal for transferring data to a=
nd/or
> > from device memory efficiently, without bouncing the data to a host mem=
ory
> > buffer.
>
> Mina, if you'd like to see this in v6.12 -- please fix the nits and
> repost ASAP.

Running my presubmits now and will repost in the next 2 hours or so.

--
Thanks,
Mina

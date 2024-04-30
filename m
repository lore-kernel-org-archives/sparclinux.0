Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5291836CB
	for <sparclinux@vger.kernel.org>; Tue, 30 Apr 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501791; cv=none; b=AThfhCiJzXu8kOxYHHKC6en/GFk+8mtjPexiHm2KvThpWQ1Cw4tUv0G4z+Nh5avFVKgoSlHuU3grggjC+8tMy8/pqSdwM6SFn1Ph0PXzLyb9iC1A76CyJ6Y6MSqmLfGIozIDy9+v6MoybbPBCR2FVHVZZqcxDqg3u1NijmpXge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501791; c=relaxed/simple;
	bh=4qmsTK6gsAp5ggmO11EIahCqaDERkMqdREmKHL1EhBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHSzf9h+4JEw9QAWX0C5rkNFtgo2ne9P6viDLQXaRrvGoHYFKL3Y95+uR8+fPVrGBfM32ASQ0Gw9Ff/oSzBL2w9cz2qJoAgV63QYaRRlftNMP4t6qRf/RTZtmPezL7yy2ZE3xgggizOOOq6M6khLo/C92+JKmPnsSBiBknU7XVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQNkA40U; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQNkA40U"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso80052651fa.0
        for <sparclinux@vger.kernel.org>; Tue, 30 Apr 2024 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714501787; x=1715106587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1aj9TYKSBdPXW7U/K10knZmptyDbqlwkvpIjAvkFLw=;
        b=uQNkA40Uv+64tJUyAefZWORZ0K+RgW2c5ariOT3Gye0uRCur7O5X3Gn1e9MlnwaC9k
         4N46pXEsc/htnCzwsrewkLoXD8Q3cY594QxvtatRbs9utARfDfdHirspzubeicVw3HJF
         VmjCOS4j5A7gGC+Hzd9FAnU2Ss2siq4jDjvH1im3GGteLySjS1ETNS9ArCOz8RSL/DJd
         EtIqpVID8YdfV/7uYqER445NWCiJSpgp0GdcGsj7mO0EvcdG784607wO0IguFyXP4Dka
         7ISIY488W0EqU4Y/slwRbM8bFJ2Y9BcM6zXG5JxUFTqdiGoK76x4u2p6/61HUi1Q2fAl
         Z6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501787; x=1715106587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1aj9TYKSBdPXW7U/K10knZmptyDbqlwkvpIjAvkFLw=;
        b=Q1sYEVinAa59yOP67E8vphb6LOw6Es2UEl8tOedQkwDGXhwGcuAtFgoafNHB7xODkW
         lvsiM6WPJdTzw0JdJUojtOBX5eWnp67hVMRDXLgENVkBfUSTjAh4jKpgQCuaQpxcqrHb
         rhubDado10Ho0mAfEw5/NY5MntGc7ulfqagq1Wc03LnunwYqlaYI5hr586Xsaki9IrEJ
         +cpdeHcQNg6B6uSP23+izykAXblhTmP3AgV/49iwxeL42KixBkChSPBPEf9YrrkLqCG9
         JuICsVgMurZ3uiimuARW+RyFKWJkHU6oRlA87mDUNbzpS2ZiXv0mrtq+0xhiic986pX9
         Kbzw==
X-Forwarded-Encrypted: i=1; AJvYcCUZRfe2iDFXjF4QK1jZ68OHEjhfeDzVeoapy/k3vDZbUdFzKOBmm29epcg5bxtNpe/j+WtSxIKlp3VonchzX7sXgGZ1oC+fl6TPzw==
X-Gm-Message-State: AOJu0Yx1pVggTehtxDQsarsqhj9pmI6vjG/vqx+pln9MNtVoX2vFE+PV
	e8bCrL6Ij1vbLzDCQdrdEnebXcL7AXZcogZF6lbTd9iC9sRKmTaAjxwlDhs/awFIgMAFK+Rsnxz
	G606G+ctX9kvnwiWbQ5qTzC4HlauUaFIqiQVb
X-Google-Smtp-Source: AGHT+IH0gaB2E/IC4/ciB9fJSDhMnVEQNygzcW8LVJwvG8xEFCDgTF/mhBRXlaBuFxJh5ugqGtCSIbfkywn/lGfB5fQ=
X-Received: by 2002:a19:ca1b:0:b0:51c:d05b:6b8d with SMTP id
 a27-20020a19ca1b000000b0051cd05b6b8dmr194410lfg.23.1714501786252; Tue, 30 Apr
 2024 11:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-8-almasrymina@google.com> <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
 <CAHS8izPeYryoLdCAQdGQU-wn7YVdtuofVKNvRFjFjhqTDsT7zA@mail.gmail.com> <aafbbf09-a33d-4e73-99c8-9ddab5910657@kernel.dk>
In-Reply-To: <aafbbf09-a33d-4e73-99c8-9ddab5910657@kernel.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 30 Apr 2024 11:29:31 -0700
Message-ID: <CAHS8izMKLYATo6g3xkj_thFo3whCfq6LSoex5s0m5XZd-U7SVQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
To: Jens Axboe <axboe@kernel.dk>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 6:46=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/26/24 8:11 PM, Mina Almasry wrote:
> > On Fri, Apr 26, 2024 at 5:18?PM David Wei <dw@davidwei.uk> wrote:
> >>
> >> On 2024-04-02 5:20 pm, Mina Almasry wrote:
> >>> @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
> >>>   */
> >>>  typedef unsigned long __bitwise netmem_ref;
> >>>
> >>> +static inline bool netmem_is_net_iov(const netmem_ref netmem)
> >>> +{
> >>> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)
> >>
> >> I am guessing you added this to try and speed up the fast path? It's
> >> overly restrictive for us since we do not need dmabuf necessarily. I
> >> spent a bit too much time wondering why things aren't working only to
> >> find this :(
> >
> > My apologies, I'll try to put the changelog somewhere prominent, or
> > notify you when I do something that I think breaks you.
> >
> > Yes, this is a by-product of a discussion with regards to the
> > page_pool benchmark regressions due to adding devmem. There is some
> > background on why this was added and the impact on the
> > bench_page_pool_simple tests in the cover letter.
> >
> > For you, I imagine you want to change this to something like:
> >
> > #if defined(CONFIG_PAGE_POOL)
> > #if defined(CONFIG_DMA_SHARED_BUFFER) || defined(CONFIG_IOURING)
> >
> > or something like that, right? Not sure if this is something I should
> > do here or if something more appropriate to be in the patches you
> > apply on top.
>
> In general, attempting to hide overhead behind config options is always
> a losing proposition. It merely serves to say "look, if these things
> aren't enabled, the overhead isn't there", while distros blindly enable
> pretty much everything and then you're back where you started.
>

The history there is that this check adds 1 cycle regression to the
page_pool fast path benchmark. The regression last I measured is 8->9
cycles, so in % wise it's a quite significant 12.5% (more details in
the cover letter[1]). I doubt I can do much better than that to be
honest.

There was a desire not to pay this overhead in setups that will likely
not care about devmem, like embedded devices maybe, or setups without
GPUs. Adding a CONFIG check here seemed like very low hanging fruit,
but yes it just hides the overhead in some configs, not really removes
it.

There was a discussion about adding this entire netmem/devmem work
under a new CONFIG. There was pushback particularly from Willem that
at the end of the day what is enabled on most distros is what matters
and we added code churn and CONFIG churn for little value.

If there is significant pushback to the CONFIG check I can remove it.
I don't feel like it's critical, it just mirco-optimizes some setups
that doesn't really care about this work area.

[1] https://lore.kernel.org/netdev/20240403002053.2376017-1-almasrymina@goo=
gle.com/



--=20
Thanks,
Mina

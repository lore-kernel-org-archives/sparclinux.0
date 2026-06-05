Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413644D695
	for <sparclinux@vger.kernel.org>; Fri,  5 Jun 2026 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645096; cv=none; b=KxrqLYVQoAC37PxQzwQWSYui89ddSGeK832TVRBFeewvZmyymof+c2O9RcGXFbBeGGfVxjYWyYLlxdlfByWULPq6nfoEgduFyF9kV/fq18aw0gmsZiQisuTt1b7GCSbBlSSirzd9L80yIR7yrsjGLEKYL8gvoQkz3aex4I1Nz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645096; c=relaxed/simple;
	bh=5W/tWie+s0GyiFfiVzYnA5c+lJxiUZ1i+gzNpq+8JKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8wk9VGIMMnUmV+lCo0bqweFrjNpXU7WWHn1G681ClQE0fd2XP0EUEYi6AAtgGYrs9gKEzJBZ8y3qnrfUUvsvv7iSYLZFEFC25n5Igr2XSZhSJt9JBCnia+BnlvdVYcT6YhHjSdU0Yq+NT1tCmIV9WdA11V7BMGQ7jEnKm/xuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5873983d19eso1547869e0c.2
        for <sparclinux@vger.kernel.org>; Fri, 05 Jun 2026 00:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645094; x=1781249894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJPTFXFfEVfaClOO5icEXfzsJcEhxZLVJwj7hX3l3SM=;
        b=QBQ20JIJ/aaka8Yzn2pDfpwAtRQLJqhYne0iXL4E1Z5FJuD88V2y2GUJVFAlaHPAOP
         RXE8mxMMMCAzVccT8/28otoIvqaQJbjn69aeseNl9FQ4KUEW58BhXw6TPOqBac2aKivG
         VfAlAZcCWJ1WljLa4gcY84jg/A0huBFHXgNIFkv75fd8sOscxhSpZt+4qKJWU0SW9P8w
         pTcz16WHH2CndKoWeYB3FOFgn/BjF+YCSXCl7RtrBo8OnF4+UFc4OCRQWxJcUf+TIlBE
         kHUwfaNjzXpFOOQZ8cn/Eab8talYkrbUtqEY8O7ZZNTHgcJqw15NaWyNwaPw6E843cuW
         3IYw==
X-Forwarded-Encrypted: i=1; AFNElJ8c6a8ty8LoPsb5WNpl5UvIzvaDnwMg51c5pRPaItOr+M7K9qzmFkc3tWBdbEB543grHEzZjID9h5ma@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWA6FdMIzg4OQ5AUe6ed5Qt4WW1xgJP0T4+EwEhJPavALUeUF
	D46rOu4WuXcPJMOAlKpybFH9xPdlD51aM2tjWZAl8njrGuPJCXql4EKKTYiIU998oGA=
X-Gm-Gg: Acq92OHl3/+4s0djfAM6zozLrRs2psd2NCeg9uSKpeGyj+Gf68Fu5QsLi2eJJtAwuzP
	f3jxAgEetzEWS2Uck/qwcmr/fD0mqQm2PVEa3iUzfv34XGfFuI10nDopl9FCPah+UZ189lzoxVf
	j2TM+3a1LjfJXQuoJ5wiQKNirPrXUEVHVCP5N8pR+QzlfOqtKH0jj8x3aeEDpyoNmuW7/WWjWeN
	KGQ716ZBOGyuKqx9iwupQHsoHunp85Ewdkoj3piprd0jGIPqDjEvV3Ekx/XmrO8ORGgzzS4aeQP
	0jBqZBXi64ppqzXDr+kyDzTnNDZvN4XiYrCHQku8ppNKy7JmeYjWxS4WGPXrM1VGz+yoSOZZGjI
	WC+K9vWQrwT/DN1vNfNtq9+9lL/lgqwQWvy+awyWTMdqmeh+HZ/mX87h9HcWczOgYwPZuevQUIM
	qsJuRIFYyuztpvfsufp/CYod0sAIw4eArQE4MR9dbRePbIC0jThajoLmlQ7MVQMp4l/6FPOsc=
X-Received: by 2002:a05:6122:8282:b0:5ab:26f:49f5 with SMTP id 71dfb90a1353d-5ac50312b75mr1163347e0c.6.1780645094438;
        Fri, 05 Jun 2026 00:38:14 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44d226sm6670926e0c.11.2026.06.05.00.38.14
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 00:38:14 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6cfb0a137c9so1035136137.1
        for <sparclinux@vger.kernel.org>; Fri, 05 Jun 2026 00:38:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9uezji9SQsXrEV2qSNfj13INgACtmXj9e6dU13mdRl+TEU4Kqw55pZZFBNqQtTptVOw+ECQKnMPtRf@vger.kernel.org
X-Received: by 2002:a05:6102:cc8:b0:62f:3abe:907f with SMTP id
 ada2fe7eead31-6feed1adbffmr1189675137.4.1780644646130; Fri, 05 Jun 2026
 00:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com> <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
In-Reply-To: <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jun 2026 09:30:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVhjYBhKUPzx-FAKWAAkUwcpYh0v2V5w64OMJtREZr4PQ@mail.gmail.com>
X-Gm-Features: AVVi8CdzPUN0PjO13sCwZaAxIjLcvwA5tXzyJ1zGjjn5YbgvhAb6LM_UbfPQhv4
Message-ID: <CAMuHMdVhjYBhKUPzx-FAKWAAkUwcpYh0v2V5w64OMJtREZr4PQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] scsi: core: Remove remaining reference to the
 pktcdvd driver
To: Bart Van Assche <bvanassche@acm.org>
Cc: Catalin Iacob <iacobcatalin@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hoi Bart,

On Thu, 4 Jun 2026 at 18:01, Bart Van Assche <bvanassche@acm.org> wrote:
> On 6/4/26 6:20 AM, Catalin Iacob wrote:
> > Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
> > export that is now dead code. Remove it.
> The subject should say something like "Unexport
> scsi_device_from_queue()".

<pedantic>
But that is not what it does: the symbol is never exported, as
CONFIG_CDROM_PKTCDVD_MODULE can never be set?
</pedantic>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D940800F
	for <sparclinux@vger.kernel.org>; Fri, 10 Jul 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687994; cv=none; b=euSao/5S2PgolxfIChf5+VyXK8927XQ9q17lTtOLLIWqjzV42vRlKtlWT/cZ7ADfRsrhWwdG+FQia4SaA1g1rWiy+KE1E4UKPIKG8UuvLBd+e1wkglOFTM3styHjtTcRC48+PK/DXufxZulB/iPqa0E9+awcRsCBS4xyURcRphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687994; c=relaxed/simple;
	bh=sxv6a13OPgrK6TOsUQ/kBJYeYtA4hSsjpL/QVUw8MJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpGuIAEU/pPJdFUSq9o2LAYIF+AC3YiUfrKral5b0Xn6QXk6w9uFrj7OOWnvbQqa2LqBK9hC7wKbx4r218VLjuRPVUwXycGCBJ5neeBvVw6Kfuc0MJQ5driUOnY5qQRaWLL8n5OFvLBandl0B3exYRGNBFIPrWbMnlSg7XchrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8OWjDEK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8OWjDEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783687992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTxMckJ71iKdcnC625lbZ9WJQgTp+gyXuVTaxsSZYeA=;
	b=J8OWjDEKLF/xTVKFpihR0nhIX5b8wnHizp0DFgE4jc1gb3P1+PstAiwvQz2D2rzsVTQL3j
	N+Kdl86oTDPuc3AqNpHuvrS0G7WkzECRmRe7L8TGAL7XW/hi2hk2TbjqTuh58RDcd8C1mW
	Fa30w8OZqxP9CKPB/KPb+cO/cD6kj5o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-h8c0qsSBOU6lIxwvVZU6uw-1; Fri,
 10 Jul 2026 08:53:08 -0400
X-MC-Unique: h8c0qsSBOU6lIxwvVZU6uw-1
X-Mimecast-MFC-AGG-ID: h8c0qsSBOU6lIxwvVZU6uw_1783687987
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAB831955F1A;
	Fri, 10 Jul 2026 12:53:07 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8AEF2180029C;
	Fri, 10 Jul 2026 12:52:47 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Jul 2026 14:53:07 +0200 (CEST)
Date: Fri, 10 Jul 2026 14:52:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type bool
Message-ID: <alDrGBMdTuoLcVyy@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
 <alDaOw8t-e3rxIPm@redhat.com>
 <alDmTcgzMlKiio9H@kunlun.suse.cz>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alDmTcgzMlKiio9H@kunlun.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/10, Michal Suchánek wrote:
>
> On Fri, Jul 10, 2026 at 01:40:43PM +0200, Oleg Nesterov wrote:
> >
> > I can only say that ptrace users do want to skip the syscall and set the
> > return value on entry.
> >
> > See
> > 	[PATCH v5 1/2] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
> > 	https://lore.kernel.org/all/20260709100949.94345-2-renzo@cs.unibo.it/
> >
> > The changelog explains that currently this doesn't work because
> > among the arches which define HAVE_ARCH_TRACEHOOK (at least) arch/mips is
> > broken in this regard.
>
> Or it could be documented that setting the return value has to be done
> in the exit trace, and that would than work on any architecture AFAICT.

Well, ptrace users know the problem. And this what they have to do
currently.

> With ppc and s390 using the same register for the syscall number and
> syscall return value it's very much impossible to poke the return value
> on entry into a register using the generic register access function. As
> of now there is no place to store the value ot of the return value
> outside of the registers, either.

I know nothing about ppc and s390. Can't comment right now.

> And the current PTRACE_SET_SYSCALL_INFO indeed sets the syscall nr and
> arguments on entry and the syscall return value on exit, that
> disctincion is implemented.
>
> Not sure how the patchset you point out is relevant, it only adds
> changes in the exit case.

No. It allows to skip-and-set-retval on PTRACE_EVENT_SECCOMP.

But ENTRY -> EXIT transition is not yet allowed due to the problems
above.

Oleg.


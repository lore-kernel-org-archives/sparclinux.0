Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8841F7F3
	for <sparclinux@vger.kernel.org>; Fri, 10 Jul 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683674; cv=none; b=u0T9Vqz6yKVPWyGfhBSNOJXl21zaqNbObLMCLzVur4YpQQU2RKU3r/ZaAWtEyGQeyC6IKVzgdoxy4HRlYQipyb+GgOU++IXw5JdT9eyKQZYRtakEqAytsMRLxHH5nCS1FOdt4gg11/ufDQnOvbP9uxaZJKc5pInjvtXk6ESckPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683674; c=relaxed/simple;
	bh=yn22xVYmK++EhinRZRQNCMhLcj+IBqHTKVWiPIkBZ3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+AJI8r+TkVmZuAQMEdpeTSAizxfeJsRoB4IZYbVxs7FX+QdDl3/jhzgvMHTalH0R5QouFlvSIKAirogVVIGirWLQRDB6ht5rP7qudss+MRi6P27Yplnu0AirV3H5McHo6Q2cClnoO2HMoQryaUH4UI3hWDKuaGT/Zc2ghmLaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coucknf6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coucknf6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783683668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okIzKFIsL/4R4vmkR+TFByt5pFrNsTBzPM+Bl8mNt+c=;
	b=coucknf6A+waUPUimJ+aw066iT5BpUfwyYwZOEZTdCRSK5GctCY5NmMqaDhYKO/ytn4GHM
	Q2PX75WsJ2e/2hahYlpGtsoIxmyOoz9bq4ODPxoDa2/2QLf34YlfAKQeQmWKZ00xuBQ+U0
	GR3l9qHUN27FZMq7Epe7gxqBhNaRfQU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-cFhP2ZLNNFiXrmd253DeWQ-1; Fri,
 10 Jul 2026 07:41:04 -0400
X-MC-Unique: cFhP2ZLNNFiXrmd253DeWQ-1
X-Mimecast-MFC-AGG-ID: cFhP2ZLNNFiXrmd253DeWQ_1783683664
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB5C41800365;
	Fri, 10 Jul 2026 11:41:03 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8F127195419F;
	Fri, 10 Jul 2026 11:40:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Jul 2026 13:41:03 +0200 (CEST)
Date: Fri, 10 Jul 2026 13:40:43 +0200
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
Message-ID: <alDaOw8t-e3rxIPm@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alDQ7isUKJFl8Va4@kunlun.suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/10, Michal Suchánek wrote:
>
> On Wed, Jul 08, 2026 at 10:34:38PM +0200, Thomas Gleixner wrote:
> >
> >   1) The set in stone rule is that if the entry code returns -1L as the
> >      syscall number then the architecture code has to skip the syscall
> >      invocation _and_ is not supposed to change the return value.
>
> Which stone?
>
> Pics or it did not happen.
>
> >
> >   2) There is no guarantee and never has been that any of the involved
> >      mechanisms (ptrace, seccomp, tracing) will change the return value
> >      when it sets the syscall number to -1L.
>
> For ptrace to correctly emulate a syscall it needs to set the syscall nr
> to an invalid value on entry, and the desired result if the syscall on
> exit AFAICT.

I can only say that ptrace users do want to skip the syscall and set the
return value on entry.

See
	[PATCH v5 1/2] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
	https://lore.kernel.org/all/20260709100949.94345-2-renzo@cs.unibo.it/

The changelog explains that currently this doesn't work because
among the arches which define HAVE_ARCH_TRACEHOOK (at least) arch/mips is
broken in this regard.

Oleg.


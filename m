Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152746AA6B
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163008; cv=none; b=ZTosD45UC1rRq/Y7kqZ92Kitkx0xfERDqWQgM/3MLWdY5BiJNntN6s9A1ytiC/fTqGA0wTLOVyXF8BxOy4bdgkFqPUaHXD7C/VGxWvFQxjDWFuAwWZee2DHTGuwZyh2nHrUlOFTqGcj2lKffiMpzkLRgKP9jMaxcDrQ0eLCzQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163008; c=relaxed/simple;
	bh=AYhacAIOU9DfNtEKQcLBl4WUi74t7QonBaw7zJRbTMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKYZCbOkvpuJM5ajWdM/OC56QBE22NsQehn1ZE7DfAw+Id4dxjI1M3IFUnHqSf2p5FsmGpls9S8jnEcQjNOdoS2lsNuYVMN+NJqDtyBw6UrP18MH6Tcp9giW773zvzgidQlRiRJpised54kD/MsAKblKM17pld5uR58PLjnCJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIPJpYp8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIPJpYp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790162997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AYhacAIOU9DfNtEKQcLBl4WUi74t7QonBaw7zJRbTMw=;
	b=bIPJpYp8SAvjpZ0hLmxcgWBBZD4aKLNw4pyzFJp9H04E6JcBVDr8Ik0Gd8/7ua43hTSnBm
	LA8r6ianIPOgrDVM9CWa+jOYuHNfiLKVKgAgDgOt+V8YdaFOTJafSGFIO7Zw5ToKEexGA3
	SWZ8EpsuhfvGyCWS0WAOHYt6kD5YIOA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-gooFaoLZMMuKAK_dogOFiQ-1; Wed,
 23 Sep 2026 07:29:53 -0400
X-MC-Unique: gooFaoLZMMuKAK_dogOFiQ-1
X-Mimecast-MFC-AGG-ID: gooFaoLZMMuKAK_dogOFiQ_1790162988
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D61E1955F14;
	Wed, 23 Sep 2026 11:29:44 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 27F2A418;
	Wed, 23 Sep 2026 11:29:29 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 13:29:44 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:29:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, bpf@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com, sgrubb@redhat.com,
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, davem@davemloft.net,
	andreas@gaisler.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com, tglx@kernel.org,
	peterz@infradead.org, luto@kernel.org
Subject: Re: [PATCH v3 01/14] audit: log all six syscall arguments in the
 SYSCALL record
Message-ID: <arO4GNT_5wNEYsCO@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <855572d1b7461e7f258547be0f11c74029755110.1790088067.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855572d1b7461e7f258547be0f11c74029755110.1790088067.git.rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 09/22, Ricardo Robaina wrote:
>
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3). The remaining two are captured but silently
> discarded before reaching the audit context. This leads to the
> need for auxiliary records when audit-relevant data lands in the
> 5th or 6th argument of a syscall.
>
> Extend the SYSCALL record to log all six arguments, by adding
> arguments a4 and a5 (5th and 6th syscall arguments respectively)
> inline within the existing record. Also add the two new args to
> the audit rules switch case, so audit rules can filter on them.
>
> Rather than plumbing two more register arguments through every
> architecture's syscall entry path, retrieve the arguments from
> pt_regs via syscall_get_arguments(). To keep the series bisectable,
> add new helpers audit_syscall_entry_regs() and
> __audit_syscall_entry_regs() that take a pointer to pt_regs, rather
> than modifying the existing ones in place. Later patches convert
> each architecture over to the new helpers, and a final patch removes
> the legacy helpers and renames the new ones back to the original
> naming.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


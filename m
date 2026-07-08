Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443C2D73B5
	for <sparclinux@vger.kernel.org>; Wed,  8 Jul 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526687; cv=none; b=O+SX5ssGqkbTG6CJmhLqoQd3SXytp7M4hvXJKqJnych5bSn6euhhee19yC6YxejVLHHBczEotcN9SnoSAUDTE/pT0Xa0EW6kWu/HueKGtcCnz1tgmPOvRFknxrZGxQHZkvHSV/4siXNsItFCYJuj0aY/VXmIr+ewhXI5UfTmR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526687; c=relaxed/simple;
	bh=rkZTTrKDp1fLIJPaNfi+EBow6fHXCvgjUtBGn831Gm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1Vdn5qG3yq7O3oYPto5H9avvH8QezejUxuMLXjn/gfaHs6ooN3PxwV5zhY/A0PP4RRrkcYbdDneebVznEkZuUasFHK0VEECIezoQCrACvnJElT4DeGFuLD6+a5N3sWatBNVrwkQwQFbXwvP+FpCx/G7mzXziwElUbJmCvCsvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuuf1ohe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuuf1ohe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783526684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P/ciXzD2S1KvjG8yWg06YK1HrAoM9H+3p3KtWGqU68=;
	b=iuuf1oheDmr80eGro4ZxsWDPvNcq7DnVe9M+8z5Ip18WDZqORfcsEBu7m5gmT49e/dNmaM
	ceirg6j24P+UAuQXf64Do6KckDJ68fAK6UmulyBDUfHWRpJrZG7oBdFSrz2sp2LmrxXQrR
	zM0NYvD+xzkgoR1iA1YaCB9VJQrJOAo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-qPokMTyLOx-BsdXwY4WVTA-1; Wed,
 08 Jul 2026 12:04:41 -0400
X-MC-Unique: qPokMTyLOx-BsdXwY4WVTA-1
X-Mimecast-MFC-AGG-ID: qPokMTyLOx-BsdXwY4WVTA_1783526680
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EECE18009E0;
	Wed,  8 Jul 2026 16:04:40 +0000 (UTC)
Received: from fedora (unknown [10.44.33.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1D1D21956040;
	Wed,  8 Jul 2026 16:04:21 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Jul 2026 18:04:39 +0200 (CEST)
Date: Wed, 8 Jul 2026 18:04:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>,
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
Message-ID: <ak51A77h1YRIl5tz@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
 <2e6ed364-ce8f-4b4b-8675-acd07f140f4f@huawei.com>
 <871pddsuzl.ffs@fw13>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pddsuzl.ffs@fw13>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/08, Thomas Gleixner wrote:
>
> On Wed, Jul 08 2026 at 09:43, Jinjie Ruan wrote:
> >
> > The return value of __seccomp_filter is checked in the wrong way, check
> > -1 should be replaced with check false, maybe:
> >
> > -               if (__seccomp_filter(this_syscall, true))
> > -                       return -1;
> > +               if (!__seccomp_filter(this_syscall, true))
> > +                       return false;

Or simply

	return __seccomp_filter(this_syscall, true);

and remove "return true" below ?

Either way, I personally like this change, I was always confused by these -1's.

Acked-by: Oleg Nesterov <oleg@redhat.com>


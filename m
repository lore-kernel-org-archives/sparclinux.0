Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA220C016
	for <sparclinux@vger.kernel.org>; Fri, 10 Jan 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502300; cv=none; b=Hbojh0RH+use35KRwgDdP3f0yulHtnuf5GdP3wjs0oBZoCjAZHprWIvWWkZFVmsw35Ei2XP3ewNkLa/vuPpydTvOYXY0jKu6+5LlPDGG/v2+A34ZuCLAlgOgXk5YzK+IX5YB3MCC1e6i6NYkzuru0GY00JOYehOXu6KLiv7yyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502300; c=relaxed/simple;
	bh=ENLLV/0PrVWHZJnSd10hwquS1U8BMVZB3K1bFjotxyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/C6IkUg3drukrMLIGgeOXip5IjUxeVrKQqz2qbS1w75UEMtFbkF371D8s2apJgQMHwewskKxj0lMpEeR6R2KyBY8M6REaoM0hCUuhO8cBJEbRjcutT5ZZrmmtoQ6qreNeKKRBm+PHPCpV8paT2Sa5vzF6B8fAOcun0LtGUCqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpFonKHK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpFonKHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736502296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
	b=OpFonKHK4rsGIFf7HSuUlaFhBRRdsLlK1R0arRX8Qgj5U/1r5D9F44B4TYsKgwx49xHb+n
	5vBk4tEV8CbMFGi4NRmAKUmHTkpEW8Vd0dtx1wt9VRXgkCiiKSc63/ZnsFhVqgMtiikhQ6
	B6aTnOhYbqo/Q402brHq8KN6vSuJqMs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-hCsWdUy4OmSMqSmC9xe8Rw-1; Fri, 10 Jan 2025 04:44:54 -0500
X-MC-Unique: hCsWdUy4OmSMqSmC9xe8Rw-1
X-Mimecast-MFC-AGG-ID: hCsWdUy4OmSMqSmC9xe8Rw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so969358f8f.2
        for <sparclinux@vger.kernel.org>; Fri, 10 Jan 2025 01:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502293; x=1737107093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
        b=Z3VfAwKCOyb+zlycUaJ9iHo5K8JUtr51xe0Ikkyyy70LSLLwAsaBcQbtdU8z/Du051
         otINsd05CURQ6rPCwvvk554uA0ZKezG16wn9unpxTAh0iw1fg7nK1EC7dvHc3mFln7QC
         xkU1GDnL4vwxFk3ttxCIrWnBnH3sOIw5m5A5ZWM7zWqmZ520fpdBrdiiWAZgBGICl6VT
         jSBmYWO/MT3JXL0awWwcvd9iZz4BRRoKF6BVseTHeiujW8yoDi5iPfkyzow8mPFu0ymS
         LGIqNaNVEKHdssD5dG6ZLXWIdp2x92k8NbfF/9P27ZZZHEhRY3xVT4mT6s0andWmlveo
         vMOg==
X-Forwarded-Encrypted: i=1; AJvYcCXha6Y9RCtWUTEjY/PnJbNN/2GoHYDNVxnCPke9y6oJSePriMiWMUW4jYgj4P/7qQWf2pes4LjQg71A@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXurOmbZ3994u1hLfvRgdczPa/jHNB4wfJk8XKuK8pcvVxeQh
	4B6OrffPUb+txukGtMvwv0uZAhXKA+kmU5aM7uoTAMFYJzB7xS/Wn35rdFXKIgZb0OkD5kslRdM
	SKh14mbTAiyY1H/q4aD1ewzYIFbc8V5Pb8i6ROjepXa0tCHgD9/++oHyuXQ==
X-Gm-Gg: ASbGncsrcGzDSGMqqDxqjett2sFZd0YzrRucQ0ZI6ffLYV+40PtaiZdmUZM+hp7EpqQ
	GCZzTTylwJm8tscMjrH3ZaB2AfMrUXx8lVtrCiokSCT3UhdWAXoW2nwCc0larUCyDxVOj3W74/r
	87qTUGroaYDra/MVSlUCAhRQqDuxG1MeYct5Pd2JeambPu+bpS1b1mzwXjWfshp8c+K31ykEn5j
	qwGTycxLg4fTXqTEFBCILvdL1VtdtLOCOER4wKWyBTlUpYJvob2OPZTBKdwRisI/7f269SoUUkS
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910082f8f.45.1736502293453;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWMxVaNXeUTe+wjdV2pCbQXCctILb5vVg9f3+psJOjGS23Sr767uuQBsbyCemBlGukLyZjgw==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910059f8f.45.1736502293124;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383965sm4140444f8f.31.2025.01.10.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:44:52 -0800 (PST)
Date: Fri, 10 Jan 2025 10:44:51 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	chris@zankel.net, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <4ad35w4mrxb4likkqijkivrkom5rpfdja6klb5uoufdjdyjioq@ksxubq4xb7ei>
References: <20250109174540.893098-1-aalbersh@kernel.org>
 <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>

On 2025-01-09 20:59:45, Arnd Bergmann wrote:
> On Thu, Jan 9, 2025, at 18:45, Andrey Albershteyn wrote:
> >
> >  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
> 
> You seem to be missing a couple of files here: 
> 
> arch/arm/tools/syscall.tbl
> arch/arm64/tools/syscall_32.tbl
> arch/mips/kernel/syscalls/syscall_n32.tbl
> arch/mips/kernel/syscalls/syscall_n64.tbl
> arch/mips/kernel/syscalls/syscall_o32.tbl
> 
>        Arnd
> 

Thanks! Added

-- 
- Andrey


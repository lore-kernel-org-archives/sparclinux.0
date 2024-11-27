Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED217C96;
	Wed, 27 Nov 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726442; cv=none; b=LaQewCJKiCLysDXbu0QCwXaTLZvjLWSDmX5714+ttkyt1qcqTRU4jnf1coXx+4T5U8iXbRKetumV+5sRRb5q2eKWo71gtfhkswSF6h5HtReJNnr1izDnIGTn/C0AlszzZ4+i8TsBZugOmAVwkjMIFs9zEcuELymH2fdaISID/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726442; c=relaxed/simple;
	bh=kmTGzgyDpZn1Fn4Eb1y+CbLVGkXnVF3S86LX6rvnkz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVU6/F4ctveyyCppFDGwK2GR0r5CI9i/4ccbgWiX5Ikucx9ChkOwlK2kP0Y8yogtSWXCV/W5+YtZdw07yvQ/9AwYkY1IC6g/4aDO2OFJR3jtkqvyIe5y7IrF35cN3n9zaKQaCmjZ90amvBLsU56gZfJsxsDmDWNk5jOWroFdC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJVvUvJG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Md3FlJmX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJVvUvJG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Md3FlJmX"
Date: Wed, 27 Nov 2024 17:53:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732726437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V6TLBvyInykSDFc+FqVHujzt1ulKNH1trpfBPs+rUlI=;
	b=QJVvUvJGyXssfjIQAzeKVpAA4U5DupcTHtuwGVBYXulNp+475oBpy67vuJQWIYm7gLNEIm
	7aGd/ZaSjdJstXk0LA0Ckqcwjc5NmoP3eZz8nFVYl97ap2L9LMRMydXlpT81Xm0B1TNJsx
	7+7asV4TOsSYeCdaQYP9qKllMZh5kMTALUYQaGgvFLdDExwMunv9W8G1VhgPaRWODFhvSv
	FKqq+5My9vac1BHuEcsHgW3QhylUQ72erfwZjF92YT/n4DkvQrqXUn1g+BAWTLFmMOxHoW
	S2P3UsxbeIGgLiw70YvDjpVNOXoPsonxZIFGtA4ri1UOjKE7PaPSflYNgznTkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732726437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V6TLBvyInykSDFc+FqVHujzt1ulKNH1trpfBPs+rUlI=;
	b=Md3FlJmXY3YKf3NtQnqrRCfazRFvbuPR//i3H5C0gpb5wyZJLUndUCvS1HNv8Ebl91rsyt
	KN0RAUrLZb2pAwAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andreas Larsson <andreas@gaisler.com>, Waiman Long <llong@redhat.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
Message-ID: <20241127165356.hnkqmgcc@linutronix.de>
References: <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
 <20241126112000.UkTwR0Iv@linutronix.de>
 <48b9d642-9739-4333-b4b9-319df8a85e2d@redhat.com>
 <b698d599-ef4e-4966-92fb-1f84d7a0df75@gaisler.com>
 <4eb7bb8e-c2aa-4ce5-9f15-3086fccf4e46@roeck-us.net>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4eb7bb8e-c2aa-4ce5-9f15-3086fccf4e46@roeck-us.net>

On 2024-11-27 08:02:50 [-0800], Guenter Roeck wrote:
> On 11/27/24 07:39, Andreas Larsson wrote:
> > Even though this is for sparc64, there is work being done looking into
> > enabling RT for sparc32. If the amount of fixes needed to keep
> > PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd rather
> > see it enabled for sparc rather than risking it becoming worse in the
> > future.

Okay. So you seem to be in favour of fixing the sparc64 splats Guenter
reported?

> > I don't know what the situation is for other architectures that does not
> > support RT.
> > 
> 
> For my part I still don't understand why PROVE_RAW_LOCK_NESTING is no longer
> a configurable option, or in other words why it is mandated even for architectures
> not supporting RT. To me this means that I'll either have to disable PROVE_LOCKING
> for sparc or live with endless warning backtraces. The latter obscures real
> problems, so it is a no-go.

It is documented in Documentation/locking/locktypes.rst how the locks
should nest. It is just nobody enabled it on sparc64 and tested. The
option was meant temporary until the big read blocks are cleared.

> So, if people want to keep mandating PROVE_RAW_LOCK_NESTING together with
> PROVE_LOCKING for all architectures, I'll disable PROVE_LOCKING for sparc
> in my testing. NP, just let me know. I'll then do the same for other
> architectures not supporting RT if I hit the same problem there.

Waiman posted a patch to disable it on architectures that don't support
PREEMPT_RT. You could also post the patches you discussed. Andreas does
not seem to be against it (but then I don't know if he is a 32 or 64bit
guy). I did not year from other architectures so far.

> Guenter

Sebastian

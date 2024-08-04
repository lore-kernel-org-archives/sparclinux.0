Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E51171D;
	Sun,  4 Aug 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722799009; cv=none; b=KYNC+WB2infhd1qJZvq9HbiZrtP/aQ5ClKIR8zRWfOzKObZNOC2qmphfmEHcGgL0vkEZbaQYPMvX2GDSD/I13PzyqODfJJhh6AKxAh4aId826XGXguLu0SZDD/20brvOQ1+1mhykrcv+w3jfCTM7pMvCsTibo5XipMhg7aPbwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722799009; c=relaxed/simple;
	bh=l7+erS5UQeOqcyD+eTBREFeT9yuScxFrP8dGxndw1S0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSdodH/WTGAriFT+prsFgU6IFJnsvjzwJQuPjp6HQNvH1zZL3puq4soFcW4BdQn8IOZQ4Asig/esa0X2U1RNKXBMB8dhXcXgjgpd/db3QcZLrLUIpNJFgTKyx/LPkF7ukWoB9yMNsdcwLVBFh2lpRgJLkFqzbK9iPLtetUNJwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tlkPkAhe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPfLHY9p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tlkPkAhe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPfLHY9p"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722799006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hT4RsXjcr24UFgRDoW9KNmLIfwaA8bAOKgEc4/mRzA=;
	b=tlkPkAheTwov5UrNWDc0Zngh5B95C2rZYC/KnX7PMRWtNTUkAdXL0dP9I6heicycrWznWq
	gz73ZIoX0SA+8K7CznO8Wv7WpYNYSvzGJ/v5PJd3Pj0wM5pEk803wFr5UjjMF7PJoruFYm
	pntLgd+kjYV2H4LvLCNvtTttPLH44sz3+QzuNreVLfjIQmQ0cLy78XdnfR3Vlj4gvBn/f0
	D0J1i3XX/QmTZNqPBcMMIJQyqLpSAai0K/f+z42qPqIvP0yLw86ThhXGfUXMIe9W4Jpgru
	JA8RIqUgXhBJ9uxjnWg0AuS/Wup+C8ef1kruvlBDMrSAmj6d0QGhmkbKOpj+Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722799006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hT4RsXjcr24UFgRDoW9KNmLIfwaA8bAOKgEc4/mRzA=;
	b=ZPfLHY9p8dQTXBMOy6UJgEObprWxJFu0JYkNpcztf0tsbM1rmnGsvfPF1GvmJNDqUHSeh7
	2VNJ5D+nwgpJQ+Ag==
To: Koakuma <koachan@protonmail.com>
Cc: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sparc/vdso: Add helper function for 64-bit right shift
 on 32-bit target
In-Reply-To: <Y5IejvnMTMbzucl5EK4C9ptWTnkPJlPJVKyCj1L1o2_2GPbmY5GZ55bKckWzKATaZcFF9SLCcvI4EMOhG3sifxCgEtkSdV2KDhv5jRBy9wk=@protonmail.com>
References: <20240804-sparc-shr64-v1-1-25050968339a@protonmail.com>
 <871q3470nn.ffs@tglx>
 <Y5IejvnMTMbzucl5EK4C9ptWTnkPJlPJVKyCj1L1o2_2GPbmY5GZ55bKckWzKATaZcFF9SLCcvI4EMOhG3sifxCgEtkSdV2KDhv5jRBy9wk=@protonmail.com>
Date: Sun, 04 Aug 2024 21:16:45 +0200
Message-ID: <87y15c5c9u.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 04 2024 at 17:30, Koakuma wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> Why does this sparc'ism need to be in generic code?
>
> Doesn't x86 also have a couple functions that live in math64.h anyway?

No. Both functions are used in the generic lib/vdso/ code.

> That's why I thought it is fine to put it in there...
>
> In any case, though, I am open to moving the function to sparc directory,
> if that is indeed the proper place for that function.

I think so as sparc is having it's own VDSO implementation and does not
use the generic one.

Thanks,

        tglx

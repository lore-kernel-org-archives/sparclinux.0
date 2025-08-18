Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742A13B797;
	Mon, 18 Aug 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496253; cv=none; b=E349H+X5h/OaryoCmC1uH5lXGMu0Z1o+0sSuzH4/HDi7lTxeH88Kzj/9HBkusZa+mNz08P+rS4Ve1AIrxKBYM1bkqtliD+6Fpy8VxZ7aEbrLxPewzjGPyN2O4Vu5cRGWHBzIMJ96AGt04f/26Yx+eX+WrYmRzG4rPv04ueAiUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496253; c=relaxed/simple;
	bh=CQfufM/VTcXp9QjfED6rlaMvi8drm6PxmTWrxo8/Kcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmB9aOMKcpdO40a8ViHGY+ot8LGkPjqZuZM3phCCr/ZqdUXmgs/wBrUqOM+ZemVvUvxJFmr+sRVqkEtROMNlPmsZwlNvvwdZN7Pz4sFiTGHcFYRpQ4t66GSFS3v3uKEJLMAOBmROTZgbxUYDjJhHdpgkDNDpqRnUyfvwH5X60Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=acXOpBKS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x9UajhGU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="acXOpBKS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x9UajhGU"
Date: Mon, 18 Aug 2025 07:50:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755496249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wf0Z6OuOZWleNnvHLFh/d+cICHHxWRzn2uEG6isVr8=;
	b=acXOpBKSyhRByqLNIQzAZTPy/XUcnLqJX49grd40/d/CXEcwRZ9iJe2WB7v1YipL09uJ7a
	QE/e96IgkWbm+vL9rjxnSaXJvEn7JC/jzGStRe/SSTgBr/YwLd29L1a35LHQhQ6BEBipyB
	WWq3nU69+Pwhl7nYYqVWWKA8NdMr7VZPqv0QciRFSJRoPX1yPLB9smZ34kyKN11nVkaTm8
	zVCmL6sm73z7/BegZRGXinjxNFvWF+DBuiOorOpEf6HfPWBncPIay1D8rj50Y7yqCHjd2m
	jTs1rI/nOSloMbp+4C8zjnWn3Jyk4+vntRHklNwPZcUjhEAWR9oIMcF6wnHn3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755496249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wf0Z6OuOZWleNnvHLFh/d+cICHHxWRzn2uEG6isVr8=;
	b=x9UajhGUzCtg3Mtvek0as/vcInY9ug5TfqQwzmOrlprr2+LurZaJRXUvbcgAq1sTDGPB9w
	9E1IN1iVjXjr/YAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 12/13] sparc64: vdso: Implement clock_getres()
Message-ID: <20250818073135-130dfc53-225c-48a3-b960-e982faa866bf@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
 <bf9ec82b-af1b-4684-ada5-8529b7ceb06a@app.fastmail.com>
 <20250815142418-d28c6551-bec1-4a65-9c52-f1afd7b630ed@linutronix.de>
 <5309ef99-9ae7-4525-8d58-f954c13797bc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5309ef99-9ae7-4525-8d58-f954c13797bc@app.fastmail.com>

On Fri, Aug 15, 2025 at 10:09:23PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 15, 2025, at 14:34, Thomas Weißschuh wrote:
> > On Fri, Aug 15, 2025 at 02:13:46PM +0200, Arnd Bergmann wrote:
> >> On Fri, Aug 15, 2025, at 12:41, Thomas Weißschuh wrote:

(...)

> >> On sparc64 kernels, I think you only need the
> >> clock_getres_fallback() for 64-bit userspace, while
> >> the compat path probably doesn't care about getres, neither
> >> the time32 nor time64 variant.
> >
> > Why?
> 
> The clock_getres() vdso call is questionable even on 64-bit
> systems, though we appear to have ended up with one on all
> the major ones. Realistically if an application needs the
> resolution often enough to want a fast way to get it, it can
> just store it in a variable.

Agreed.

> On 32-bit, we decided against adding a clock_getres_time64()
> syscall when we added clock_gettime64() because of this.

My assumption was that clock_getres_time64() wouldn't make sense in the
first place, as no clock would have a resolution this big.

> For time64 userspace, this means that glibc always calls
> the system call instead of the vdso, and old time32
> userspace wouldn't use the clock_getres() vdso because
> there was no vdso implementation when it was compiled.

Is this paragraph meant to be specific for SPARC? Glibc does use the
clock_getres() vdso fastpath on time64 architectures. But on SPARC no
application would ever use clock_getres() through the vdso today,
as it doesn't exist yet.

In any case, I have no strong opinions about this patch and am happy to drop it
or support only SPARC64. Most likely nobody will bother to update glibc anyways.


Thomas

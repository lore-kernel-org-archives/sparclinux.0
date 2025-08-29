Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764E30FC00;
	Fri, 29 Aug 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464771; cv=none; b=X7uSgk8rprkkkid5W8AO/+CcrYOtOVzFFeYGk4CRxLOusU2tPSEcJz7WF7rdUSjNIZjk2guJ3pwJk+nhYXwejKqzDF4euBS7e3G+Khhx6/7a9QwQ6MI+RutMoz4GMFssb6yfFf+aBAnH6GR+OyOWqiYMjGLhH8ljZ4G+qiv9mRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464771; c=relaxed/simple;
	bh=AG1U5uZDjwxxo89I1nJNqY4zzgoxn6rOGGM85LkZafw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR5yLjQfrW7tDWSdL7fhfwE6cTy4aU5uOQRMAAmpYr1B9pMpGNvNmfQOAPPePTatKlNo7EM8b1xyZ0zhdz6fRThsU+8AUIcraB6pCqWq5WFzztyq79SVFlRHQ7b2XwlV1f7sAqhQXF/UIbRMhemtCvNUGekGyfW0JleoAeoyeUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDgFte3x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjyZkTfd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDgFte3x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tjyZkTfd"
Date: Fri, 29 Aug 2025 12:52:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756464767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qteIrrZy/Hd5PTkCLfVwMbS81evxs/mvu7xmf+DTkII=;
	b=iDgFte3xeL3v3s7mKgsMIwDz8G70PvZgPwjMlfNW2q72bKpr02zIzP9VYaJ9szgoAx/+Wn
	u6OmDFBogxwxOdwXpCM65eQAKp1PPjnoDSv6up/o17Lamun1cc/datGkoMsdDeGnZXPc7q
	/1qimv9/sT/qaJOBDoCh+Oc9RGQvVud/XmzQWDHGCJDTT9so52iTgYQvvXL7cROwwIwAx5
	3+gP1LRaVqqyRWjzAdAL6F+0Ac/lVS/4nTulGv2PccEVd6Ov8eG1Bb2b8HSrhBMVgeIwqU
	P3LdfozU6Qh6YFKoIPQqkeFloGWjqcNAQTHz6c/jotOAzy/i8dMdpcOx42dUGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756464767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qteIrrZy/Hd5PTkCLfVwMbS81evxs/mvu7xmf+DTkII=;
	b=tjyZkTfdLB5cdfijs+sd0FC7oRA75mECeN4v41oUjuTdoN3O+IwLnT/tt0xXB/atkO38tP
	GrLdrlvTsGt+NnAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	"David S. Miller" <davem@davemloft.net>, Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
	Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
Message-ID: <20250829124314-288d0445-a744-4022-93bf-7da255182411@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
 <b7ab1bdca349208532804d0d5e5af56817cd25c6.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7ab1bdca349208532804d0d5e5af56817cd25c6.camel@physik.fu-berlin.de>

On Fri, Aug 29, 2025 at 12:40:59PM +0200, John Paul Adrian Glaubitz wrote:
> On Fri, 2025-08-29 at 12:37 +0200, Thomas Weißschuh wrote:
> > In the meantime I installed a full Debian, but the bug is still not
> > reproducible in QEMU.
> 
> Please keep in mind that QEMU emulates sun4u (on UltraSPARC II) while
> Andreas was testing on sun4v (on Niagara 4). There might be differences.

I am aware. Unfortuntely I don't have anything else available.
If anybody could test this on real sun4u that would be great.
Or teach me how to use sun4v QEMU without it crashing on me.
In the past you offered access to a physical machine.
Does this offer still stand? Does it also run into the bug?

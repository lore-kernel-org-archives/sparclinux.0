Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36205377A8E
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740812; cv=none; b=JnNL5enAKdItF0C/W5DyvwzzygtJ4k3pUJVCo4JG0uSopkmh/+akxNv7+Fl8Ld7NpYEH3rxNXwc21ix+8L3zxBFdR5eQky+yXStn/MNruwvTuE01/+nhhYhwrxB1IFqyAaQISB8jcKrni2ZlRvL0+VjxFFnkf0B7YIJJAPeK+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740812; c=relaxed/simple;
	bh=rDWahC2zYLyUUe8PUoO8V/s4yZFQTHn7uv447S0tzU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2rKsmtQRRPwXxWYWMl5FMXAPLJBkbsvjoasoXJ4HZa3ZJxaWL4PfyMzJ3rblNIplEiWzqD3LSBbzu2ypGT/x9qfq7N+i1qtXjN3ZykxITsHikz9y3kjDqMKZMIN7w3u0A0Rj8zJnoxEwLUIF2bf9anXQcJTOAhP0ecw2K4g0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=X57lOKz1; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=ZJPQtMeQ; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="X57lOKz1";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="ZJPQtMeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786740808; x=1787345608;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nrYtPulkZ4mcIxLMP3yo3Oq21lFIwulqUScAEaLy53Y=;
	b=X57lOKz1Oy/Iad9MsAfE5T33WaqNz/tSjzI8eE8zo4EWKhV/6rROWPEafnnaXZcXMbdC85ZsZM6z4
	 lOhMjFxOdH8EQdcwYcVKmze1tmxoO+hRDdbz9GkrdveTfz4P3dhf0uwpTontD8UDjVS19nWQjQKsdw
	 FjtPiQCwvYxkhkjbQIvojL9tYFQKPcR7w9xUYORlh4RdEPLXBDh+rHQx7boLYAFTnaMAk/71U7rc0q
	 zvZOySabmEaR4/z4ca6jPjOsvhhwL3Jf6Y8P7pvyqR9ycHiJjcB70MfklyndiwOvfOIWI5UCa4SImg
	 9BnL1C3BWk4rkkypru4UDCH3UNlxMbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786740808; x=1787345608;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nrYtPulkZ4mcIxLMP3yo3Oq21lFIwulqUScAEaLy53Y=;
	b=ZJPQtMeQlxL+tEFgBPf5aeGf2oqF7/30eTWjT4+oQT/+3HKbNIUZRNJHELAu7AqtKwHS+5+G1/k8d
	 CgT5tD8DA==
X-HalOne-ID: 318c3163-9822-11f1-982a-fd5ae24138eb
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:173:77b0:ce00:a307])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 318c3163-9822-11f1-982a-fd5ae24138eb;
	Fri, 14 Aug 2026 20:53:28 +0000 (UTC)
Date: Fri, 14 Aug 2026 22:53:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sparc32: allow a kernel loaded away from the start
 of RAM
Message-ID: <20260814205326.GD534878@ravnborg.org>
References: <20260814105723.3454511-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814105723.3454511-1-linmag7@gmail.com>

Hi Magnus.

On Fri, Aug 14, 2026 at 12:52:31PM +0200, Magnus Lindholm wrote:
> Many years ago I ran Linux on my SPARCstation hardware and tried to keep
> up with new releases, but somewhere around 3.x I hit a wall, sooner for
> SMP builds since they are larger. As the kernel grew it simply became too
> big for SILO to load. On this machine the last one that fit was 2.6.32,
> at 2598956 bytes against a 2605056 byte window: six kilobytes to spare.
> 3.12 was 184KB over. Fixing it turned out to need more than SILO changes,
> the kernel side needed work too, and I never got around to giving it
> serious thought. I recently dusted off my old SPARCs and picked the
> journey back up.
> 
> A current sparc32 kernel no longer fits in the window SILO loads into:
> 0x4000 up to SILO's own text at 0x280000, about 2.5MB. Loading it higher
> instead exposes two places that assume the kernel sits at the start of
> RAM.
> 
> Patch 1 is an independent pre-existing bug. viking_flush_page() and
> viking_mxcc_flush_page() compute a physical address as vaddr -
> PAGE_OFFSET, which is __pa() without phys_base. It is wrong regardless of
> the rest of this series; it simply cannot be observed while phys_base is
> zero. When it is not, iommu_flush_iotlb() flushes the wrong page, the
> IOMMU walks stale IOPTEs and every DMA transfer fails. It comes first so
> that no commit in the series leaves Viking DMA broken.
> 
> Patch 2 makes setup_arch() discover a non-zero phys_base. It takes it from
> the lowest sp_banks[] entry today, and phys_base is the offset __pa() and
> __va() are defined in terms of, so once the kernel is loaded elsewhere
> every early translation is wrong by the difference, including the physical
> addresses written into page table descriptors. The tablewalker then
> follows pointers into pages holding nothing, while the same tables read
> back correctly through the nocache view, and the machine stops right after
> the context table pointer is installed with no console left to say why.
> The probe is the architecture's existing __get_phys(), which already
> implements it for sun4m and sun4d and returns zero elsewhere.
> 
> Patch 3 sets HdrS to 0x0300, the protocol level that tells a boot loader
> the kernel supports being located somewhere other than physical 0x4000.
> 
> No change in behaviour when phys_base is zero.
> 
> Tested on a SPARCstation 20 booting from SCSI to a full userspace, with
> and without an initramfs, using a SILO carrying the matching loader
> changes. Tested with both CPU module types this machine accepts, single
> and dual:
> 
>   SuperSPARC-II, TI Viking/MXCC   the path patch 1 corrects
>   HyperSPARC RT625, ROSS SRMMU    the only variant whose DVMA mappings
>                                   are page coloured

I thought Viking was only used by the large sun4d machine.
Good to learn something new here.

Nice to see someone having fun with these Sun machines.
I gave up and have actually tried to have the support for sun4m and
sun4d removed from the kernel.

	Sam

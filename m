Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E124E4A1
	for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786910111; cv=none; b=WECQMWPpG3WdsVAqUd9G3Lw0raU4eeqZ53fKLjW4j5pXrE1guJTmjfbIbDIkhf3uQVgcy3OflotQiS/abe6FmnVUZpafDYdP6G2Kem+UZAPqjsiPrFztjwWwzTMNG69LD97W/6eRfNV2jF7cVvCFfr/B712C5jWrxE+1chY3j80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786910111; c=relaxed/simple;
	bh=QZG2b+r+a0eIrt+VlEerAw3q6TQ19rZBCrxotsWRsd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=texqjPNxiRJLEg9NgASrZmNk2UwW4r1teGq9FGWjeygXW1pHrAXLfziKs5WbG/hsOA0rH3rk2FlgpQT25qEYgs5wS1zfD07jbAuMgeUWQoqNevJ/F9YGJQn1bR87ZmLb0YqLr5Iw6Yw2FJg5P0Y//VR7O9JUVTd6t2sgh5EkREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=gdE+0DnH; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=430GGdbG; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="gdE+0DnH";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="430GGdbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786910098; x=1787514898;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=DMONH6bAOhOpgRSZeR7tOKa1eXZ6/1oczQIiZXkQCEU=;
	b=gdE+0DnHGSnvrqltThtSTfifGmphHRl5Jixejb9BpSBlfqx9JkeHrelB0JiDMwB+cKrDKN7cr9HtY
	 Fe59jPrIYwz6ZctFcUSYcS3Uuaju6QEfyz2GfG3zm3Uc7Xy838ehv5KdeApftoMpbC9uETuvahkLqF
	 33LgAjq/WWZWbxryJfKP+fVa+dyAwefplqju0LutQ2GJtXxmTpb6L9hpBfP7SomJOrIYZUvb6/NMCQ
	 RCVphvWEEpatAK8tHgL4NKQOCL+iMqoCTyM99hzWYdWjjcHM5QnaQwjea0Qmm+rSE9cA3lctn/bOl2
	 +86SFwOzya4bEdw3msX4vtvYvIkb+XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786910098; x=1787514898;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=DMONH6bAOhOpgRSZeR7tOKa1eXZ6/1oczQIiZXkQCEU=;
	b=430GGdbGu6y7f1edFl4KiRtMwY/GWwuFcGnmSDuD0jC6k84ouMGOk3qKBTjrtBMYla8u9EIPPM7Uo
	 IXpO46pCw==
X-HalOne-ID: 5a683067-99ac-11f1-9ab2-09e225b634d1
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:750c:ee10:ce36:ae21])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 5a683067-99ac-11f1-9ab2-09e225b634d1;
	Sun, 16 Aug 2026 19:54:57 +0000 (UTC)
Date: Sun, 16 Aug 2026 21:54:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sparc32: derive phys_base from the PAGE_OFFSET
 mapping
Message-ID: <20260816195456.GA660273@ravnborg.org>
References: <20260816075141.3489194-1-linmag7@gmail.com>
 <20260816075141.3489194-3-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816075141.3489194-3-linmag7@gmail.com>

Hi Magnus.

On Sun, Aug 16, 2026 at 09:50:16AM +0200, Magnus Lindholm wrote:
> setup_arch() computes phys_base as the base of the lowest sp_banks[]
> entry, that is, where RAM starts, and assumes the kernel image was loaded
> there. That holds for the traditional boot path, where SILO places the
> image at physical 0x4000 and PAGE_OFFSET is mapped to physical 0.
> 
> It stops holding once the image no longer fits there. SILO loads a kernel
> between physical 0x4000 and its own text at 0x280000, a window of 2605056
> bytes; a current sparc32 kernel is roughly twice that. The loader must
> then place the image elsewhere in physical memory and map PAGE_OFFSET to
> it, at which point phys_base describes where RAM begins rather than what
> PAGE_OFFSET maps to, and the two disagree.
> 
> phys_base is the offset __pa() and __va() are defined in terms of, so once
> it is wrong every early translation is wrong by the difference, including
> the physical addresses written into page table descriptors. The
> tablewalker then follows pointers into pages that hold nothing while the
> same tables read back correctly through the nocache view. The failure
> surfaces as a hang right after the context table pointer is installed and
> the TLB flushed, with nothing on the console to explain it, since the PROM
> mappings the early console depends on have become just as unreachable.
> 
> Ask the MMU what PAGE_OFFSET actually translates to and adopt that.
> __get_phys() already implements this probe for sun4m and sun4d and returns
> zero elsewhere, so no new low level MMU access is introduced and machines
> without an SRMMU are unaffected.
> 
> Memory below the kernel cannot be reached through the linear map, which
> runs upward from PAGE_OFFSET, so drop the banks that fall below it rather
> than leave entries that __va() would translate to below PAGE_OFFSET.
> 
> With this a 6MB kernel loaded at physical 0x03000000 boots on sun4m: the
> context table lands at its true physical address,
> srmmu_inherit_prom_mappings() preserves the PROM console mappings, and
> srmmu.c needs no change at all, since map_kernel() already handles a
> non-zero phys_base via do_large_mapping().
The patch looks good but I dislike we introduce more code that uses
sp_banks. Can we somehow use memblock for this?

Part of my old grand plan was to replace all uses of sp_banks with
memblock. I have some old patches somewhere in case you are ready to
give this a spin.

The patch is:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

My sp_banks comment shall not hold it back.
It is anyway Andreas that will handle them.

	Sam

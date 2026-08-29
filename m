Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182337CD40
	for <sparclinux@vger.kernel.org>; Sat, 29 Aug 2026 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984980; cv=none; b=IS/axFSUkxL0RP80/sIyGfb4sB2ZYq2BUXXry61Q8JG2p90AyUWZ1W+ZCRtmDoEnaPa6tMxF6arHtFsvN1w9PhLqUhrO4AkxbMorhPMvJZpDSY7UWc+bcGaYI3rlqkVo+dkECCwAzxr+CYBDfAWatUk4GgUo4hvdslX/LA8A+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984980; c=relaxed/simple;
	bh=I+KX+GOt+ZPbnIbley7tUR4hG6ahjX95VPlSuz6jCZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyFtPFZiLIL4Qtwqn7iN4Tm1ePQEzJevT0/L/q8PTP7a59oTqGujqVaqa85T4fTUnXqsM0jWxV+SYk7f8sOEiEfUwTx5j6ZHCExXy8Hcny2FAAkMl3PMf0ixho2F5JDiRE7mC5HYp2Q0WmOu29jfDHG0zncSXU0gMUS06ZaXVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=k2Gg1VET; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=+TUn1lJI; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="k2Gg1VET";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="+TUn1lJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787984974; x=1788589774;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=ByUoej/URWxu8Ikuxc4S/wIe5XCxLqXuIXrqwP8M/Po=;
	b=k2Gg1VET6r1zYgUZcmBfLaNocEPd7QH4McUkB5+x4kzp+aAX0051LV/hYlGhjOkbeAOQ0sqe1mVqT
	 vN9+H7vqUHJ/21FZ7563I4YwDhxEIz5Iutqbtn6KErIc7XzcBrb06RRwMiuI9tNnM27oeV3VyGOF+G
	 0yufwRJRYfE8gq7yXTR2HjvZ6pTClszR9XVDdGYfvLxdv9bhKiUxjRTuIug/MUs79zvCZVrbkLmT66
	 pQYhmv7wFi4eQJWq+F76pD2pyTT/CSawE/jzfbIVQHNdUMi3zQFlUU5i7tES/T6ArnacNlpkVL9OMR
	 sbYalk/19smCEl9SVsIX7WsggA/uL0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787984974; x=1788589774;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=ByUoej/URWxu8Ikuxc4S/wIe5XCxLqXuIXrqwP8M/Po=;
	b=+TUn1lJIe6nHHvfxnV4FO6roxXA5RnhekOItDPn4QZG4I/m4T1DFufI3n3sTjcWdRkYg/LSM/h5ht
	 NKvBVkZDw==
X-HalOne-ID: ff5f9e81-a372-11f1-8b18-6bcdb618a7d0
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:cd23:4a74:8afa:914b])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id ff5f9e81-a372-11f1-8b18-6bcdb618a7d0;
	Sat, 29 Aug 2026 06:29:34 +0000 (UTC)
Date: Sat, 29 Aug 2026 08:29:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] sparc32: replace sp_banks with memblock
Message-ID: <20260829062933.GB44338@ravnborg.org>
References: <20260827182757.6856-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827182757.6856-1-linmag7@gmail.com>

Hi Magnus.

On Thu, Aug 27, 2026 at 08:24:12PM +0200, Magnus Lindholm wrote:
> Replace the sparc32-private sp_banks memory description with memblock.
> 
> The first two patches convert the SRMMU consumers that already run after
> bootmem_init() has populated memblock. The third patch moves memblock
> population to prom_meminit() and applies the mem= limit there, keeping that
> intermediate state correct. The fourth patch moves the early memory setup
> into setup_32.c and the final patch removes the now-unused sp_banks array.
> 
> This work is based on an earlier eight-patch series by Sam Ravnborg.
> Patch 2 directly carries over Sam's memblock sizing conversion. The series
> has otherwise been substantially reorganized and reworked for the current
> kernel. Compared with Sam's series, this version is ported to the current
> generic MM setup, keeps the sparc32 mem= command-line option by using
> memblock_enforce_memory_limit(), and uses memblock's exclusive range-end
> semantics throughout.
Thanks for picking this up!
Patches 1,2,3,5 are:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I left some comments in patch 4.

	Sam

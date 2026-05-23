Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0631F985
	for <sparclinux@vger.kernel.org>; Sat, 23 May 2026 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555269; cv=none; b=kmIkEsBjeOJ9ScHYd0hHG7x3Ec53FWa0K50ubEONAvcn+3Gj8pRBLo5AKBJ9E42DiPYuqXeEBPgJ295e8I/WYan5UlkOzow2NXexvgDFk6hgbCzwkDE5G7eX1qzlQRcBFAe+NDErbwMKCsQMvv7rEQWMPHvBME6yRKF3S1pR6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555269; c=relaxed/simple;
	bh=ibuIO+aAG3K1KGklkGKKCx56tIMfkPBlgd+iMnohY7c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qlUGSaK/J3z/M1YClMQTzKUCuEWkbJ+nE2j6mGS8WfRrIj9UcX7ES+LS/Pze29JAe2xOnTJfWi7iqeV94gBy3iAQYYw7iaUdxB/NUb+EvuDYOnOfNgem1e5j6elTgTTTkRkHbxy4JWjrnv88LoqSc1z9fMpgDZf+GeSC3zZVPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ep1rK/zM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ep1rK/zM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5761F000E9;
	Sat, 23 May 2026 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779555267;
	bh=ZN5o432wxDfbglDQi3EPlICxvkm9fqCcJ5dcvgyatQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ep1rK/zMEJV2IwXzzCPVQvcv2Os6prHVLDjg3I1PlqSjkMwI8iRL/TylUTE+YFVAi
	 jZ/6GJpPDzhFYIhDKyqTHXGp0CRUTQjkqDXOLKg2UN7SnTt/odogdgcWbcJxQICult
	 W2DYFYOsH6XdbM4QTa+EfZ314DZdigdCfIlZqk/I=
Date: Sat, 23 May 2026 09:54:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com
Subject: Re: [patch 1/1] sparc: add _mcount() prototype
Message-Id: <20260523095427.ef875aa8d2908a65fcb193c5@linux-foundation.org>
In-Reply-To: <d754f87694da033d9d80581c9a60df891e3c763d.camel@physik.fu-berlin.de>
References: <20260523042535.C3A6B1F000E9@smtp.kernel.org>
	<d754f87694da033d9d80581c9a60df891e3c763d.camel@physik.fu-berlin.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 09:49:13 +0200 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Andrew,
> 
> On Fri, 2026-05-22 at 21:25 -0700, Andrew Morton wrote:
> > From: Andrew Morton <akpm@linux-foundation.org>
> > Subject: sparc: add _mcount() prototype
> > Date: Fri May 22 09:20:26 PM PDT 2026
> > 
> > sparc64 defconfig told me
> > 
> > WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
> > Is "_mcount" prototyped in <asm/asm-prototypes.h>?
> 
> I think that must be a regression as I haven't seen this before. I should
> pull and build a current kernel, my last build was around v7.1-rc1.

OK.  I tried bare 7.1-rc4, the warning is there.  gcc-15.2.0.


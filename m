Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF348FF9C;
	Sat, 17 Oct 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248462; cv=none; b=TC2QZGFzqQ16Biz1PAmvEgtS/DiPoYQV1Xr5iViIeUVvch/I1pFrmqAS5OH7rik5+m/87n0NZeOHvAOz3oy2anLszLgjqe4m5nIDeZ8d7qIxNNYNxY8J4JAXcrdI7EOUKXuo5eS+8N/8s8Q7SyAOCzY+H9AlKbc3j/5d/q/Huw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248462; c=relaxed/simple;
	bh=r3X3z1z3iN1lFp9psrcamRpBzgWWdRLRwtFsKGYbwF4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J5bNhL+x8gdHUBU3iJNz0YsMS+f41bdKdXFY4+LjqnFvYwxueRpjdbPFjyLnFb5RGn8VKLc+G6APtYDdpWTSOJeEovWPsrAtiuARtE4D6R9g+KmIMyPvUir1Vx8KYSVxNCNXwX0GrAFSJsqI6KvKZXDgxS1fySrM4B9eDX8e3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 2C0D8100383D4C; Sat, 17 Oct 2026 16:40:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 29DB91100CD75B;
	Sat, 17 Oct 2026 16:40:26 +0200 (CEST)
Date: Sat, 17 Oct 2026 16:40:26 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Stian Halseth <stian@itx.no>
cc: Andreas Larsson <andreas@gaisler.com>, 
    "David S . Miller" <davem@davemloft.net>, Kees Cook <kees@kernel.org>, 
    Michel Lespinasse <michel@lespinasse.org>, sparclinux@vger.kernel.org, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sparc64: Randomize mmap base and PIE executables
In-Reply-To: <20261017100451.2266781-1-stian@itx.no>
Message-ID: <s4s6or92-27s9-73ns-ns7q-7821or0o6o20@vanv.qr>
References: <20261017100451.2266781-1-stian@itx.no>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Saturday 2026-10-17 12:04, Stian Halseth wrote:

>On sparc64 a 64-bit process gets little address space randomization:
>the stack moves, but shared libraries, anonymous mappings, PIE
>executables and the brk heap land at the same address on every run.
>Tested on a T4-1 and a T7-1 (sun4v) and a V240 (sun4u), with 64-bit and

I too gave this a spin, on T5240 with a Linux 7.2.11 base and
Debian's LP64 userland.

Tested-by: Jan Engelhardt <jengelh@inai.de>

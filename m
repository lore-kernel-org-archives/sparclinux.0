Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA9354AE4;
	Sun, 19 Oct 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760901493; cv=none; b=IWkjgICD7EG3422bnCOKOtTb+K1068nz1THp17EpU1/9LBJ40GYxgn8vQxAHDObkTLfZFmCPBRtkuIShJaz1jjNFH668uol7sOhxPBmmj2Hkbg9psOcmt+Ov7KSrox8Fl/++L4n+q1JY4leRRxEc6KU+O7g5FGHf3gn0H2MmQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760901493; c=relaxed/simple;
	bh=AbZFXn6kwETMJW8cChbyTo9aH5d5PaR1eTrbogoSfWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7W0rjfWPA0XTG40ZsnAryTRbeWO3joIOozceeMqOUiEDEvAcLy47fefquO/WYtrmlD/SBKgXSpqZFF58hFPCJw+OIObY7Wl0cetSd34tJ+c6NTcAtvciyeVTwH4Jg1s1avyfGkRCSb0T3mTCrBnoB52Pj4gdMbsu8/miZTsat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B58B4340F14;
	Sun, 19 Oct 2025 19:18:10 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>,  Stian Halseth <stian@itx.no>,
  sparclinux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: don't reference obsolete termio struct for TC*
 constants
In-Reply-To: <e11ecaf723594bf01c66fc5c80c25bda0621f34f.1759359616.git.sam@gentoo.org>
Organization: Gentoo
References: <99f1a93cf8cd4f0ece8611be2860677084663aac.1759359610.git.sam@gentoo.org>
	<e11ecaf723594bf01c66fc5c80c25bda0621f34f.1759359616.git.sam@gentoo.org>
User-Agent: mu4e 1.12.13; emacs 31.0.50
Date: Sun, 19 Oct 2025 20:18:06 +0100
Message-ID: <87ecqyaefl.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sam James <sam@gentoo.org> writes:

> Similar in nature to ab107276607af90b13a5994997e19b7b9731e251. glibc-2.42
> drops the legacy termio struct, but the ioctls.h header still defines some
> TC* constants in terms of termio (via sizeof). Hardcode the values instead.
>
> This fixes building Python for example, which falls over like:
>   ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'
>
> Link: https://bugs.gentoo.org/961769
> Link: https://bugs.gentoo.org/962600
> Co-authored-by: Stian Halseth <stian@itx.no>
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v3: Fix constants.
> v2: Fix title.
>
>  arch/sparc/include/uapi/asm/ioctls.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Ping.

>
> diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
> index 7fd2f5873c9e7..f26befbf690fb 100644
> --- a/arch/sparc/include/uapi/asm/ioctls.h
> +++ b/arch/sparc/include/uapi/asm/ioctls.h
> @@ -5,10 +5,10 @@
>  #include <asm/ioctl.h>
>  
>  /* Big T */
> -#define TCGETA		_IOR('T', 1, struct termio)
> -#define TCSETA		_IOW('T', 2, struct termio)
> -#define TCSETAW		_IOW('T', 3, struct termio)
> -#define TCSETAF		_IOW('T', 4, struct termio)
> +#define TCGETA          0x40125401
> +#define TCSETA          0x80125402
> +#define TCSETAW         0x80125403
> +#define TCSETAF         0x80125404
>  #define TCSBRK		_IO('T', 5)
>  #define TCXONC		_IO('T', 6)
>  #define TCFLSH		_IO('T', 7)

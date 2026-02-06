Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2F1F2380;
	Fri,  6 Feb 2026 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374351; cv=none; b=cX+A3BESUVbRuHUIvehTyKHqzK5MZC3kwLemh+Pez59IgKhDMcNrU7gh3qOVDbQU97wWlg5pssiOQfQ649Ridk00ZgJuUpHPdnaYKd2GywkkjqTR/80c1+s4dpqKl7KT+iZTg/0WcSpa9yLgCovCJHGvWhUz9JZBnypY3V/FROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374351; c=relaxed/simple;
	bh=Hh20h5Hcu53pXyq0qXQUPkhDRM6zeeFmXUWZOa4SwD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlmJ8x2Fpb4f649fBQzqN3QIHdzfJUN2hSb+3m35hgp1ZgndWwjDDBlZUUh3awpy5swNy8psbNZsUm1gDjp0aAxdukQYLyZaBHUg0wm/vOgVE/7okz4SoTUkLZIDH0x8JWzEURKQWgc9qmfZFD0F1GiUqVFkwM47K3sRKmee8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Hd4voFKf reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Hd4voFKf"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f6rDX4r1Vz1DQrb;
	Fri,  6 Feb 2026 11:39:08 +0100 (CET)
Received: from [10.10.15.18] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f6rDX2q83z1DDdY;
	Fri,  6 Feb 2026 11:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770374348;
	bh=PiWfC2SLl19iYDIaggWSIKVVWMbScaO/1gAOnFBFuPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Hd4voFKfAllBl9iwNHggE26zzCEhw5U2pN1NZ3YzRnEsFjyUVUAjphVqp4+kglEQZ
	 EkJJPZ2yFiL7aX9vz0nMSzBH4wfw3g7jqQ0UcqXLgL0YEYrcw+tHNWnaCDbhV7gdmt
	 WB7M0C6KDno6gzGln6lCKVa5aAxyd+DQlnRs6d/OX5hbwu/7g5pynHp8K8jdFV7caQ
	 0VQhlFUR2Ihid6uMZLchKM/+B4g44YqZFrnCImPUV80e/d7p+c0xsU/3ju/AeDnZG5
	 Yrb9MTNuwhtW4d7LYktlOcw3khEMIMi6NbuIuaoSWYM4qJTy8OPjHxIWd3lFbP/RUv
	 N87hMElXE4TbA==
Message-ID: <a673343c-6964-41ab-a26f-fcee931951df@gaisler.com>
Date: Fri, 6 Feb 2026 11:39:07 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sparc: don't reference obsolete termio struct for TC*
 constants
To: Sam James <sam@gentoo.org>, "David S. Miller" <davem@davemloft.net>
Cc: glaubitz@physik.fu-berlin.de, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <123e6a3a-6360-45cb-8eef-23b1660b9253@gaisler.com>
 <db618c0a5a47e512fafc06304042cdda147c5088.1770212429.git.sam@gentoo.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <db618c0a5a47e512fafc06304042cdda147c5088.1770212429.git.sam@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-04 14:40, Sam James wrote:
> Similar in nature to commit ab107276607a ("powerpc: Fix struct termio related ioctl macros").
> 
> glibc-2.42 drops the legacy termio struct, but the ioctls.h header still
> defines some TC* constants in terms of termio (via sizeof). Hardcode the
> values instead.
> 
> This fixes building Python for example, which falls over like:
>   ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'
> 
> Link: https://bugs.gentoo.org/961769
> Link: https://bugs.gentoo.org/962600
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v4: Tweak commit message for commit ref and add comments for old definitions.
> v3: Fix constants.
> v2: Fix title.
> 
>  arch/sparc/include/uapi/asm/ioctls.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
> index 7fd2f5873c9e..a8bbdf9877a4 100644
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
> +#define TCGETA          0x40125401 /* _IOR('T', 1, struct termio) */
> +#define TCSETA          0x80125402 /* _IOW('T', 2, struct termio) */
> +#define TCSETAW         0x80125403 /* _IOW('T', 3, struct termio) */
> +#define TCSETAF         0x80125404 /* _IOW('T', 4, struct termio) */
>  #define TCSBRK		_IO('T', 5)
>  #define TCXONC		_IO('T', 6)
>  #define TCFLSH		_IO('T', 7)


Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


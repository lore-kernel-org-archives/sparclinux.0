Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509CC2FB
	for <sparclinux@vger.kernel.org>; Thu, 30 Jan 2025 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738222811; cv=none; b=fBwwDhT2WbVZ+7mohPaMRsgTme+8iKX47CHcq2UdwH4GiZUout2dYA+zXg2gbdhnocikww6DKfq/Gj2IJLH3aHbJuiKiBetCR/nozchB+RnLSN/aqK/qZBXuxRH7thSCs5+8byl0IFUzywL7hkbVq4pHPeWr2fzvrgrv2ImMxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738222811; c=relaxed/simple;
	bh=LXiURlaGxc0RPWCN709yc2muVzit5B9enfmSlPxP1+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvKaBjuYuE99foUbPAfio1WnqdA1pteCRpMRZDBskQSMzmyc494LMZqqpaMZ6IoiX1u9zj/IqSsXxEQkqWSN2cZHsOPF3U8RObkB8c8dsbJXY6XyoP1Yq9FdHO0mAU/2lXh683mvJtc8TqR9aMcdgp9osXk2aswpjbM0cqYgi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=fLjE/jMr; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="fLjE/jMr"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Yk9sV3lT8z1DHYg;
	Thu, 30 Jan 2025 08:39:58 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Yk9sV1xJJz1DHYN;
	Thu, 30 Jan 2025 08:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1738222798;
	bh=F7bUHXRk5k4/l7b72dZ1zNsdITh5AVlOZge71JzQHPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fLjE/jMrCCZQwrXCG05EfWvPQQBmcpFrPfZJqIiwqawnE4JyLV5aid1Egn9Nnxgfx
	 3MKrYD9G2QFa5wk7rhbs/5z14WupKi6LnaZoTYMvmZTNyizTVDNMZFGhDwWsl/fQEY
	 VEQd9gI/5nUark6FLWNr1jz4bu1VVlFlZs+YzTCA=
Message-ID: <d834befe-ea59-40a8-94b2-58e992e4afdf@gaisler.com>
Date: Thu, 30 Jan 2025 08:39:56 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH] ioctl02: Use correct termios structure
To: Petr Vorel <petr.vorel@gmail.com>, buildroot@buildroot.org
Cc: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
 Martin Doucha <martin.doucha@suse.com>, sparclinux@vger.kernel.org,
 Mike Gilbert <floppym@gentoo.org>, James Hilliard <james.hilliard1@gmail.com>
References: <20240226155137.25523-1-mdoucha@suse.cz>
 <20250129214219.GA447474@pevik>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250129214219.GA447474@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-01-29 22:42, Petr Vorel wrote:
> Hi all,
> 
> FYI this LTP commit merged as 697a06a827 [1] which is needed to fix ioctl02.c
> test on ppc64le on all kernel versions breaks compilation on Buildroot
> bootlin-sparc64-glibc toolchain (gcc: 13.3.0, kernel headers: 4.19.255, glibc: 2.39):
> 
> 	In file included from br-test-pkg/bootlin-sparc64-glibc/host/sparc64-buildroot-linux-gnu/sysroot/usr/include/sys/ioctl.h:29,
> 					 from ../../../../include/lapi/ioctl.h:11,
> 					 from ioctl02.c:31:
> 	br-test-pkg/bootlin-sparc64-glibc/host/sparc64-buildroot-linux-gnu/sysroot/usr/include/bits/ioctl-types.h:36:8: error: redefinition of ‘struct termio’
> 	   36 | struct termio
> 		  |        ^~~~~~
> 	In file included from ioctl02.c:29:
> 	br-test-pkg/bootlin-sparc64-glibc/host/sparc64-buildroot-linux-gnu/sysroot/usr/include/asm/termbits.h:17:8: note: originally defined here
> 	   17 | struct termio {
> 
> The problem is with kernel <asm/termbits.h> incompatibility with glibc
> <bits/ioctl-types.h> included via <sys/ioctl.h> which is needed by ioctl02.c
> and also by LTP library include/safe_macros_fn.h.
> 
> This problem was fixed a year ago in kernel v6.10-rc1 in commit c32d18e7942d
> ("sparc: move struct termio to asm/termios.h") [2].
> 
> Because nobody noticed this change I suppose nobody uses LTP on sparc64
> or people compile LTP on sparc64 with new kernel headers.
> 
> @Cyril @Martin FYI another example of conflicting glibc and kernel headers (not
> listed in [3]). IMHO nothing to be done on LTP side unless we can magically put
> back <termios.h> and have ppc64le working with it.
> 
> @Buildroot As I wrote, because LTP needs this fix for ppc64le (arch actually
> tested by LTP developers), the only solution for Buildroot is to require
> toolchain based on v6.10 kernel headers for sparc64 (quite a big limitation for
> several cross compilation toolchain, some are based on 4.19 kernel headers,
> 5.11 requirement for musl effectively disables LTP on Buildroot on musl).
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/commit/697a06a827978887e4c88710dc7d31d6f3ee816a
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c32d18e7942d7589b62e301eb426b32623366565
> [3] https://sourceware.org/glibc/wiki/Synchronizing_Headers

The patch in [2] was also applied to stable branches, so it is also
included in v6.6.74, v6.1.127, v5.15.177, v5.10.233, and v5.4.289 
kernel versions that are currently used by Buildroot master.

For the 4.19 kernel it is in place since v4.19.316.

Cheers,
Andreas


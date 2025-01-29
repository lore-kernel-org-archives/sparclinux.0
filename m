Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0522619
	for <sparclinux@vger.kernel.org>; Wed, 29 Jan 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186945; cv=none; b=P5s7wvXuK6fhyrSHn0CiB+tqhL7ay2eisuNvyJ4D/zFfQcsr8uRledgNnjMcYGeaAdXGtvT2O6PajVqyLEkJvhsiEaA/f31H3Q/vXDNIcuyw59rBf2em0+U9QiWiBYiaFnjoFli13/e1lHVKISXwQJBJW3wkU1GATfDKfM2zdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186945; c=relaxed/simple;
	bh=ZVIlfcSLYzO5e5J/0eG1Zi62cbOOTShSOaImw5O/0A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHhrj8PoshBFz/p8aRacECv4NLSVH90KFt6asIrjTKqtiha3mOl7X0RkayPc3xU9uh3DRwmeve9WdF6xRn8n70s+d46Ihaz+flsjqscFY5p84DQ3sn2l57wFBoQYBZDyhxptytkIbZRf5CYEdIWlTKx7MQy4MzuB1ycnThzUogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaHT/GI7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaHT/GI7"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e06af753so58854f8f.2
        for <sparclinux@vger.kernel.org>; Wed, 29 Jan 2025 13:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738186942; x=1738791742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rr8sxsKiF/lU9vsbhVl5SmziNEiI8NAifs0lNyPeKH4=;
        b=aaHT/GI7tQi/EXtUGU6gD4Q9xv6bc9+8SBn3ZOCYA2DdxSsxhK6Y0oXFMaAi64oxzb
         VSvviC/K+NMUXz8YCtcw0RDQXMAefhUOHLHN42lvKO0UcUvurO38LW3P3MQZBtNuy2KM
         LJ9Z3bhODDnhy9phjdrMTCByKSC0GtCtB7PRRaLI8iPWm1VY64XEJ2xI3oUFik6zRNhD
         BQqPmswH9l2WShcPPxr8/z6tY7EbHZSn1qaxXmNmy+XOmmP0UjQLz6NhF/+Zem5s6wqA
         miO/RZvQweZDdZ61jB6DsMaX/DYGaTV5QnOymra2StiEgq4ib+c/fZeV0L7+AkO1bju9
         0Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738186942; x=1738791742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr8sxsKiF/lU9vsbhVl5SmziNEiI8NAifs0lNyPeKH4=;
        b=aBnVw5Z9kAOTD7Y7ASJu57MSO7rLYL/17+bN3EGbwd2qnAtq2hyZxz6ZvjEtRXergK
         7kZko36NAHHaaFN5he4c91Ke4j3GAbDPZOSd+ZVpgAepJdKPk66xYozuPar6inGoB6xi
         7ok/rocvgY/kz5GD/PDr1w5smNpyW4EejJs7wKwiXrJg8XQBdxYLBm4obP1pfuU5aM67
         9JrvgFLJyY5nigTemjfmCqEK0d6eT6yzSzhYujePito/e+eNFSTv1uEshxxjza8kzUQN
         GHREXtJIE3oqDx7vKilsM8sTvQ1WHjnIVyYN3JlMl2TfE914bz6ka2nVsIIv+FAMG4tO
         yujQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKcqwX1/XDbvViwJsXcJloXLlZmk5eYm3hHv+lYWiCfJ8T4kfxoUIp491H+QD/vWE02VC/gX/Qity5@vger.kernel.org
X-Gm-Message-State: AOJu0YykY0+wdbljBMUPFlKU2uOBXk0H2UgXd9WZkMWwMAThhTBK/Eq9
	kYQp9HoIG2xX+jV2IkVf74ZfxeuPsCbNQ/EhvkzEmjj28bxzS5ng
X-Gm-Gg: ASbGncsqhIk0r8A4SfxuqEjJy2d/H6bi7QBfO8/Jcy/LcvcS36g3pqpbGaQg4eeN3+x
	UTTfnl6StAPyZPa6kZnNiPLu6fRfPOsC8JVvRpc51KomQweLZVKfr3kal3HjCjKGFCd5NlAssxG
	i+6Vn4mCQ0of54oqETmC6GHxY1UYgvpUhCsil8tq9QjNKpHeKaLR+niEWQplGRcE/+ZZK06jq88
	bEJOlNI1QD0fhszyVnCK314YYP0X6YBW7rTc4DyTtQREa0W4VdF6KE0w4Sr7rEHh3QdubVGV+U5
	VW8U5ogNzUVhElNrFvnd
X-Google-Smtp-Source: AGHT+IFoSi4pQyWa540ZMOoVaZElt7UULsPNO8T5++ktbSr6E6fWptQOWZVXTTTpG3iQKBnwCrQDqw==
X-Received: by 2002:a5d:6489:0:b0:38c:246f:b0b3 with SMTP id ffacd0b85a97d-38c52097871mr4094679f8f.51.1738186941922;
        Wed, 29 Jan 2025 13:42:21 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0eccc3sm3189f8f.18.2025.01.29.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 13:42:21 -0800 (PST)
Date: Wed, 29 Jan 2025 22:42:19 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: buildroot@buildroot.org
Cc: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
	Martin Doucha <martin.doucha@suse.com>, sparclinux@vger.kernel.org,
	Mike Gilbert <floppym@gentoo.org>,
	Andreas Larsson <andreas@gaisler.com>,
	James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [LTP] [PATCH] ioctl02: Use correct termios structure
Message-ID: <20250129214219.GA447474@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20240226155137.25523-1-mdoucha@suse.cz>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226155137.25523-1-mdoucha@suse.cz>

Hi all,

FYI this LTP commit merged as 697a06a827 [1] which is needed to fix ioctl02.c
test on ppc64le on all kernel versions breaks compilation on Buildroot
bootlin-sparc64-glibc toolchain (gcc: 13.3.0, kernel headers: 4.19.255, glibc: 2.39):

	In file included from br-test-pkg/bootlin-sparc64-glibc/host/sparc64-buildroot-linux-gnu/sysroot/usr/include/sys/ioctl.h:29,
					 from ../../../../include/lapi/ioctl.h:11,
					 from ioctl02.c:31:
	br-test-pkg/bootlin-sparc64-glibc/host/sparc64-buildroot-linux-gnu/sysroot/usr/include/bits/ioctl-types.h:36:8: error: redefinition of ‘struct termio’
	   36 | struct termio
		  |        ^~~~~~
	In file included from ioctl02.c:29:
	br-test-pkg/bootlin-sparc64-glibc/host/sparc64-buildroot-linux-gnu/sysroot/usr/include/asm/termbits.h:17:8: note: originally defined here
	   17 | struct termio {

The problem is with kernel <asm/termbits.h> incompatibility with glibc
<bits/ioctl-types.h> included via <sys/ioctl.h> which is needed by ioctl02.c
and also by LTP library include/safe_macros_fn.h.

This problem was fixed a year ago in kernel v6.10-rc1 in commit c32d18e7942d
("sparc: move struct termio to asm/termios.h") [2].

Because nobody noticed this change I suppose nobody uses LTP on sparc64
or people compile LTP on sparc64 with new kernel headers.

@Cyril @Martin FYI another example of conflicting glibc and kernel headers (not
listed in [3]). IMHO nothing to be done on LTP side unless we can magically put
back <termios.h> and have ppc64le working with it.

@Buildroot As I wrote, because LTP needs this fix for ppc64le (arch actually
tested by LTP developers), the only solution for Buildroot is to require
toolchain based on v6.10 kernel headers for sparc64 (quite a big limitation for
several cross compilation toolchain, some are based on 4.19 kernel headers,
5.11 requirement for musl effectively disables LTP on Buildroot on musl).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/697a06a827978887e4c88710dc7d31d6f3ee816a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c32d18e7942d7589b62e301eb426b32623366565
[3] https://sourceware.org/glibc/wiki/Synchronizing_Headers

> The termios structure definition in <termios.h> is incompatible
> with direct ioctl() calls. The correct definition is in <asm/termbits.h>

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
> index aab80b251..f3bfb239a 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
> @@ -26,7 +26,7 @@

>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <termios.h>
> +#include <asm/termbits.h>

>  #include "lapi/ioctl.h"
>  #include "tst_test.h"


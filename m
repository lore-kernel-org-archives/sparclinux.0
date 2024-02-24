Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEDCDF60;
	Sat, 24 Feb 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743587; cv=none; b=IUTgmyvNIVIEYcEK4C5xTxYMpTa7A3k/iZLkJbpagv2BrhRn7nH29r5eTC1DemeBcCvHyIZ/9srXIzA65AfFpH5lniP5jWHef6z0YwdPknHqxIOtahJ0M/6guftKnIly2M9sBpwR7tekf75U1pVbP8vAv40KrdrdK7xitPqHmPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743587; c=relaxed/simple;
	bh=zcC4poV40hXhdD6shqkx1O5mAMYUvsMHdLQpdJIhhAY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UociwsObqBlrIa0tpjGKpNEK49z0sj5uvcnqfEjeIzDgLS7l60hBBBNR5gOOgCcSUpmNoSVC/wdzV8ZKyLT/7Gyp/D2avi5Wy5+EJmHjVUjz0I2YZvljbt0RcXZJZoVoQ57Hw67J/aAGWqi9nGYzAaMipIHRaDx1homL4wyhQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8675892009C; Sat, 24 Feb 2024 03:54:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 77EED92009B;
	Sat, 24 Feb 2024 02:54:28 +0000 (GMT)
Date: Sat, 24 Feb 2024 02:54:28 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Miquel Raynal <miquel.raynal@bootlin.com>, sparclinux@vger.kernel.org, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, 
    Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sparc32: Use generic cmpdi2/ucmpdi2 variants
In-Reply-To: <20240223-sam-fix-sparc32-all-builds-v1-1-5c60fd5c9250@ravnborg.org>
Message-ID: <alpine.DEB.2.21.2402240248560.61493@angie.orcam.me.uk>
References: <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org> <20240223-sam-fix-sparc32-all-builds-v1-1-5c60fd5c9250@ravnborg.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Sam Ravnborg via B4 Relay wrote:

> Use the generic variants - the implementation is the same.
> As a nice side-effect fix the following warnings:
> 
> cmpdi2.c: warning: no previous prototype for '__cmpdi2' [-Wmissing-prototypes]
> ucmpdi2.c: warning: no previous prototype for '__ucmpdi2' [-Wmissing-prototypes]
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> ---

 LGTM.  You may wish to add:

Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")

but otherwise:

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk> # build-tested

  Maciej

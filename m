From: David Miller <davem@davemloft.net>
Date: Wed, 22 Jul 2009 18:25:54 +0000
Subject: Re: [PATCH,resend] sparc64: build compressed image (zImage) by
Message-Id: <20090722.112554.221617981.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200907162041.53181.elendil@planet.nl>
	<20090716201601.GA6038@merkur.ravnborg.org>
	<200907221907.40698.elendil@planet.nl>
In-Reply-To: <200907221907.40698.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: elendil@planet.nl
Cc: sparclinux@vger.kernel.org, linux-kbuild@vger.kernel.org, jurij@wooyd.org

From: Frans Pop <elendil@planet.nl>
Date: Wed, 22 Jul 2009 19:07:39 +0200

> I vaguely recall from Debian work that loading compressed kernels caused 
> problems on sparc32 hardware (due to insufficient memory?), which could 
> justify the difference. But I may be wrong.

This is, unfortunately, very likely true.

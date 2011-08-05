From: David Miller <davem@davemloft.net>
Date: Fri, 05 Aug 2011 09:33:30 +0000
Subject: Re: [PATCH] sparc: Access kernel TSB using physical addressing
Message-Id: <20110805.023330.24522201010821730.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110805.010032.779552426005653854.davem@davemloft.net>
In-Reply-To: <20110805.010032.779552426005653854.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 5 Aug 2011 11:27:27 +0200

> Having all the extern definitions from vmlinux.lds located in
> arch/sparc/include/asm/sections.h would IMO be more obvious.

Yes, the patching facilities could be improved quite a bit,
even beyond just placing the declarations in a sane place.

I have a cleanup planned, and I'll keep your feedback in mind.

Thanks!

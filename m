From: Ben Collins <ben.collins@canonical.com>
Date: Tue, 19 Aug 2008 23:28:37 +0000
Subject: Re: [PATCH] Make silo work with recent kernel headers and gcc 4.3
Message-Id: <1219188517.17001.179.camel@cunning>
List-Id: <sparclinux.vger.kernel.org>
References: <1219187229.7722.15.camel@lya.porno-bullen.de>
In-Reply-To: <1219187229.7722.15.camel@lya.porno-bullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2008-08-20 at 01:07 +0200, Friedrich Oslage wrote:
> These are the patches we(Gentoo) are using to compile silo with recent
> linux kernel headers(>=2.6.25) and gcc 4.3.
> 
> I only checked Debian SID, but probably all other distributions out
> there would benefit from this.
> 
> Please apply them :)

I'll check the rest of it, but on initial glance, wouldn't it be better
to just do -lgcc instead of the `gcc -print...` mess?


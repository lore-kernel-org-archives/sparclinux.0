From: "Mustafa Hussein" <mustafa.hussein@comcast.net>
Date: Wed, 31 Mar 2004 00:50:32 +0000
Subject: Re: atyfb module, unknown symbol prom_palette
Message-Id: <006601c416ba$2e664940$fa0da8c0@juba>
List-Id: <sparclinux.vger.kernel.org>
References: <002b01c416a1$556dee30$fa0da8c0@juba>
In-Reply-To: <002b01c416a1$556dee30$fa0da8c0@juba>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> Congratulations, you are the first person to try and build any
> of these things as a module :-)
>
> This should fix it:
>
> === arch/sparc64/kernel/sparc64_ksyms.c 1.65 vs edited ==> --- 1.65/arch/sparc64/kernel/sparc64_ksyms.c Fri Mar 19 13:59:48 2004

Thanks, it works!
The reason for building atyfb as module is to get around this problem:
when atyfb is built into the kernel (2.6.0 thru 2.6.3), the elite3d is not
recognized at all.
I'm trying to setup a dual-headed system, and eventually XFree with Xinerama
support.


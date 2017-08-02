From: David Miller <davem@davemloft.net>
Date: Wed, 02 Aug 2017 23:27:35 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <20170802.162735.793721374402820186.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <22912.11736.664315.645426@gargle.gargle.HOWL>
        <20170801205829.GA7496@ravnborg.org>
        <20170802213647.GA5506@ravnborg.org>
In-Reply-To: <20170802213647.GA5506@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: mikpelinux@gmail.com, matorola@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 2 Aug 2017 23:36:47 +0200

> And memset calls down to bzero, where %o0=buf, %o1=len
> 
> %o0 = 0xc
> %o1 = 0xfff000123c897a80
> %o2 = 0x0
> %o3 = 0xc
> 
> So from this we know that:
> res = 0xfff000123c897a80
> to + (n - 0xfff000123c897a80)) = 0xc
> 
> The value "fff000123c897a80" really looks like a constructed address
> from somewhere in the strace code, and where this constructed address
> is used to provoke some unusual behaviour.
> The "fff0" part may be a sparc thing.
> 
> So far the analysis seems to match the intial conclusion that
> we in this special case try to zero out the remaining memory
> based on the return value of raw_copy_from_user.
> And therefore we use the return value (res) which triggers the oops.

Yes, the return value is bogus.

> So rather than manipulating with the assembler code as suggested
> in the previous mail this simpler patch could be tested:
 ...
> -		memset(to + (n - res), 0, res);
> +		void: /*memset(to + (n - res), 0, res);*/

Need a semicolon rather than a colon there :-)

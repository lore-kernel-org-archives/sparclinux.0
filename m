From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 06 May 2006 00:34:49 +0000
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060505.173449.83405876.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060505113514.GA28863@palantir8>
In-Reply-To: <20060505113514.GA28863@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: errandir_news@mph.eclipse.co.uk
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 5 May 2006 12:35:14 +0100

> When I try to boot 2.6.17-rc3 on my SS20 I get this error for every
> module it tries to load:
>   module crc32: Unknown relocation: 17
> 
> This worked okay on 2.6.16-rc2. Is anyone looking into this problem yet?
> It's comming from a new type R_SPARC_PC22 in the ELF header. Any idea
> what could be causing this? Is it intentional or a bug?
> 
> I've attached my dmesg output and the config. Please CC me as I'm not
> subscribed to linux-kernel.

I don't see how that type of relocation can be emitted.
Can you send me one of the smaller of the *.ko files that
have this problem?  Thanks.

I can add the relocation handling to the Sparc module support,
but I don't think it should be necessary in the first place
and looking at a sample module with the problem will help me
figure this out.

From: David Miller <davem@davemloft.net>
Date: Thu, 08 Mar 2007 22:03:57 +0000
Subject: Re: Sunfire v880
Message-Id: <20070308.140357.59657265.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Thu, 8 Mar 2007 16:58:12 -0500

> Thanks for all your help with this.  I wish I could send you a v880.
> If there's anything else you or anyone else would like me to try let
> me know.  One last thing, I noticed this message when I create the
> aout version of the kernel:
> 
> PT 0 Entry: Loadable to 0x400000[0x39e918] from 0x0[0x32b788] align 0x100000
> PT 1 Entry: unknown
> 
> perhaps the additional size added by that patch changes something that
> makes it happy when loading?

The only working theory I can come up with is that yes, indeed,
it makes the layout of the kernel different and for some reason
that fixes the bootup failure.

> If I figure out anything new I'll let you know.

Thanks.

From: "David S. Miller" <davem@redhat.com>
Date: Sun, 09 May 2004 02:25:20 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040508192520.6474eb92.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 8 May 2004 17:49:15 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> Either way it's your changes that messed it up, so now consider this a
> report against the changes made in 2.6.6-rc3-mm2. :D

I didn't make the changes you mention to the sparc port, someone
else added that sparc changes to the -mm patch series not me :-)

Since Andrew Morton (akpm@osdl.org) maintains that patch set,
probably you should send him a note about it.

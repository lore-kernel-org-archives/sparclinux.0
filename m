From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 25 Jan 2006 04:15:11 +0000
Subject: Re: Kernel Bugzilla #2682: arch/sparc/kernel/sun4m_smp.c: [OPERA] potential error detected by an ana
Message-Id: <20060125041511.GD7655@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060122175356.GF10003@stusta.de>
In-Reply-To: <20060122175356.GF10003@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 22 Jan 2006 13:34:17 -0800
>> Bob Breuer's SMP patch does a drastic rearrangement that eliminates
>> that line along with many others surrounding it. It is a better idea to
>> take Bob's patch than to fiddle with things piecemeal.
>> It's not so much a bug as nonsensical.

On Tue, Jan 24, 2006 at 01:09:50PM -0800, David S. Miller wrote:
> I'd like to see Bob's patch formally submitted then.

I've been a bit too far beyond lax in my duties to offer a coherent
excuse. Bob, it looks like I need to get my act together and merge your
stuff ASAP. It might be a good idea to resend your last patch so Dave
can get a look at it, too. In the meantime I can testboot it on a bunch
of different boxen.

I'll follow up in private with realtime communication info..


-- wli

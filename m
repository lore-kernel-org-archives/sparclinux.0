From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 28 May 2012 15:42:59 +0000
Subject: Re: [PATCH 03/15] sparc32: implement proper LEON support in head_32 (after highmem)
Message-Id: <20120528154259.GA12270@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1338016819-22245-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1338016819-22245-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 28, 2012 at 01:52:22PM +0200, Daniel Hellstrom wrote:
> Hello Sam,
>
> I have tested the last patch series [1..15], however LEON can boot. I'm 
> trying to figure out why, this patch removes the cputypval for LEON which 
> makes the architecture detection not be executed. Since some things 
> nowdays default to LEON I suggest that the cputypval string defaults to 
> "LEON" as well, or that the check is reintroduced, or that cputypval is 
> set to "LEON" when a LEON is detected. The compatible/compatability 
> property is set to LEON on LEON systems. What to you think?
That I screwed it up :-(

The cputypval is never set for leon. I was not needed in head_32.S
and I forgot later that we did not set it for leon then.
And we use it later where we today uses the default value for leon.

I will cook up a patch for this tonight.

	Sam

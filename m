From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 05 Jan 2011 19:58:17 +0000
Subject: Re: [PATCH] sparc32: Added LEON dma_ops
Message-Id: <20110105195817.GA25644@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294243785-8082-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294243785-8082-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kristoffer.

> My patch tried to touch the generic SPARC32 code as little as
> possible.

I think it is time to accept that LEON is a first class citizen here
and accepts that code shall be well integrated with the rest of SPARC32
rather than avoid touching it.
I know where you are coming from maintaining this out-of-tree.
But LEON is now part of the kernel.

For testing you can request the community for help.
There are still people around that run a few SPARC32 systems - albeit
they seem to be few these days.

> SBUS is always defined.
You are right.
I will kill the remaining ifdefs as they confused me.

>  We will await further feedback and post it again next week.

It would be better is you tried to split it up already now and
address the feedback that you already have.
Then the review is much easier.

	Sam

From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 28 Dec 2004 03:06:57 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to behave nicely in userland
Message-Id: <20041228030657.GI771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 11 Dec 2004 16:06:39 -0800 Jeremy Huddleston <eradicator@gentoo.org> wrote:
>> In changing from the glibc check to __KERNEL__, processor.h doesn't work
>> for some userland code.  Here's an update to correct this.

On Mon, Dec 27, 2004 at 06:38:52PM -0800, David S. Miller wrote:
> I don't think this is too pleasant.
> Actually, I can't see much of anything that userland needs to get
> at inside of processor.h, so why don't you just __KERNEL__ ifdef
> out nearly the entire file?

I'm vaguely disinclined to take fixes for userspace inclusion of
kernel headers unless, say, other arches are taking such steps and
we would only penalize ourselves by not doing so.

By and large I'd prefer to discourage userspace code from using
kernel headers. Does this work in a significant number of other
arches as things stand now?


-- wli

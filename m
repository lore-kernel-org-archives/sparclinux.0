From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 20 Aug 2004 21:13:04 +0000
Subject: Re: Buglet making vmlinux with -j
Message-Id: <20040820211304.GM11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200408202156.06459.crn@netunix.com>
In-Reply-To: <200408202156.06459.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 20 Aug 2004 13:59:56 -0700 William Lee Irwin III wrote:
>> You're going to have to be more precise in your description for me to
>> tell.

On Fri, Aug 20, 2004 at 02:05:29PM -0700, David S. Miller wrote:
> It's because of all the btfixup stuff in the sparc32
> build machinery, William.
> He doesn't need to give any more description, it is clear
> what the issue is.

Hmm. Now that I've seen the patch I know what people are on about,
but maybe I'm too dense today to figure out what "silently finishes
before linking" means, as I've yet to decipher it even afterward.


-- wli

From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 18 Aug 2004 21:41:44 +0000
Subject: Re: Sun4d progress
Message-Id: <20040818214144.GM11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 18, 2004 at 02:33:28PM -0700, William Lee Irwin III wrote:
>> I won't know for a while, no. I'll work on explaining what each of

On Wed, Aug 18, 2004 at 02:39:18PM -0700, Keith M Wesolowski wrote:
> I don't remember whether this applies to 2.4 (I think it does), but
> certainly in 2.6 the problem is the sbus ranges munging.  I explained
> this very briefly to Will at some point, but the gist of it is,
> there's a comment that says something to the effect that "How is this
> supposed to work?  Ask Dave."  At one point, I traced this out and
> found that some crucial ranges fixup that happened in 2.2 wasn't
> happening in 2.6.  This is triggered by the SCSI init, BTW.
> Bearing in mind that this worked on 2.2, it shouldn't be hard to fix
> up.

Okay, I'll audit 2.2 for this also.


-- wli

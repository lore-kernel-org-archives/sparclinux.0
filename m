From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 15 Feb 2004 00:47:30 +0000
Subject: Re: RFC: [sparc32] atomic_t is 32 bits
Message-Id: <20040215004729.GA18037@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040213052029.GD22176@foobazco.org>
In-Reply-To: <20040213052029.GD22176@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Feb 13, 2004 at 09:26:38PM -0800, David S. Miller wrote:

> I am going to apply this now to 2.6.x, but we should uninline some of this
> stuff afterwards as I agree with Peter.

Looking at it again, so do I.  I'll cook up a patch to do so based on
some measurements I'm making.

Thanks for the feedback.

-- 
Keith M Wesolowski

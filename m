From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 04 May 2004 16:37:35 +0000
Subject: Re: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <20040504163735.GA4333@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040504132104.GA23807@artsapartment.org>
In-Reply-To: <20040504132104.GA23807@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 04, 2004 at 06:11:44PM +0200, Thomas Nemeth wrote:

> 	Why don't you just remove all strcmp's ?
> 	Something like
> if (strlen(&cputypval)=4)
> 	sparc_cpu_model=sun4;

It's not "sun4" but rather "sun4 " so this is wrong.

> else if (&cputypval[4]='c')
> 	sparc_cpu_model=sun4c;
> else if (&cputypval[4]='d')
> 	sparc_cpu_model=sun4d;

See also head.S.

Any patch that modifies this stuff needs to make a significant
improvement; for example, setting these values early in head.S and
getting rid of this altogether.

But really it is not worth spending time on.

-- 
Keith M Wesolowski
